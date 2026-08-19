#!/usr/bin/env bash
# Runs each case in evals/cases/ through `claude -p` with the skill as system
# prompt, then grades the response with a second `claude -p` call as judge.
# Two API calls per case.
#
#   bash evals/run.sh                          # all cases, EN skill
#   SKILL=respostas-curtas bash evals/run.sh   # the PT port
#   ONLY=03 bash evals/run.sh                  # one case, by filename fragment
#   CLAUDE_BIN=./stub bash evals/run.sh        # swap the CLI (used in testing)
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="${SKILL:-concise}"
BIN="${CLAUDE_BIN:-claude}"
SKILL_FILE="$ROOT/skills/$SKILL/SKILL.md"
[ -f "$SKILL_FILE" ] || { echo "no such skill: $SKILL_FILE" >&2; exit 2; }

# sub(/\r$/,"") tolerates CRLF working copies (Windows checkout read from WSL)
section () { awk -v s="## $1" '{sub(/\r$/,"")} $0==s{f=1;next} /^## /{f=0} f' "$2"; }

pass=0 failn=0
for case_file in "$ROOT"/evals/cases/*.md; do
  name=$(basename "$case_file" .md)
  case "$name" in *"${ONLY:-}"*) ;; *) continue ;; esac

  facts=$(section Facts "$case_file")
  prompt=$(section Prompt "$case_file")
  rubric=$(section Rubric "$case_file")

  # A missing or misnamed section produces an empty rubric, and an empty
  # rubric has nothing to violate — a permanent false PASS in the only
  # safety net the rules have. (Facts may legitimately be empty.)
  [ -n "$prompt" ] && [ -n "$rubric" ] || {
    echo "$name: no '## Prompt' or '## Rubric' section" >&2; exit 2; }

  response=$("$BIN" -p "$prompt" --append-system-prompt "$(cat "$SKILL_FILE")

You are replying in a terminal. Do not use tools. The facts below are things
you already verified yourself this session — treat them as your own findings,
and treat any action they describe as one you have not performed yet.

$facts")
  rc=$?

  # A dead CLI must abort the suite, not spread across every case as a FAIL
  # the rules did not earn. Auth is matched at the start of the output, so a
  # response that merely discusses OAuth doesn't trip it.
  case "$response" in
    "Failed to authenticate"*|"Invalid API key"*|*"OAuth session expired"*)
      echo "auth error from '$BIN -p' — log in first (open claude, run /login), then re-run" >&2
      exit 3 ;;
  esac
  # An empty response or a non-zero exit is the CLI failing, not the rules —
  # scoring it would blame the skill for a network error. No length floor
  # beyond that: this style produces legitimately short answers.
  if [ "$rc" -ne 0 ] || [ -z "$(printf '%s' "$response" | tr -d '[:space:]')" ]; then
    echo "$name: '$BIN -p' returned nothing (exit $rc) — aborting instead of scoring it" >&2
    exit 3
  fi

  verdict=$("$BIN" -p "Grade the response below against the rubric, item by
item. For each item print OK, or VIOLATION followed by the shortest quote that
proves it. The very last line must be exactly PASS (every item OK) or FAIL.

## Response
$response

## Rubric
$rubric")

  # The judge sometimes decorates its verdict (**PASS**, "PASS." ) — strip
  # punctuation and emphasis before comparing, or a passing case reads as a
  # failure.
  last=$(printf '%s\n' "$verdict" | awk 'NF{l=$0} END{print l}' | tr -d '[:space:]*_`.:!')
  if [ "$last" = "PASS" ]; then
    echo "PASS  $name"; pass=$((pass+1))
  else
    echo "FAIL  $name"; failn=$((failn+1))
    printf '%s\n' "$verdict" | sed 's/^/      /'
  fi
done

echo "----"
echo "$pass passed, $failn failed"
[ $((pass + failn)) -gt 0 ] || { echo "no case matched ONLY=${ONLY:-}" >&2; exit 2; }
[ "$failn" -eq 0 ]
