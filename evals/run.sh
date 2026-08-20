#!/usr/bin/env bash
# Runs each case in evals/cases/ through `claude -p` with the skill as system
# prompt, then grades the response with a second `claude -p` call as judge.
# Two API calls per case.
#
#   bash evals/run.sh                          # all cases, EN skill
#   SKILL=respostas-curtas bash evals/run.sh   # the PT port
#   ONLY=03 bash evals/run.sh                  # one case, by filename fragment
#   CLAUDE_BIN=./stub bash evals/run.sh        # swap the CLI (used in testing)
#   CORE=1 bash evals/run.sh                   # judge the always-on core, not the skill
#   BASELINE=1 bash evals/run.sh               # no style at all — what the model does raw
#   RUNS=3 bash evals/run.sh                   # N attempts per case, pass rate reported
#   MODEL=claude-sonnet-5 bash evals/run.sh    # pin the model so runs compare
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="${SKILL:-concise}"
BIN="${CLAUDE_BIN:-claude}"
RUNS="${RUNS:-1}"
SKILL_FILE="$ROOT/skills/$SKILL/SKILL.md"
CORE_FILE="$ROOT/skills/$SKILL/hooks/core.md"
[ -f "$CORE_FILE" ] || CORE_FILE="$ROOT/skills/$SKILL/hooks/nucleo.md"
[ -f "$SKILL_FILE" ] || { echo "no such skill: $SKILL_FILE" >&2; exit 2; }

# What the model is given: the full ruleset (default), only the ~20-line core
# the hook injects into every session, or nothing at all — the baseline that
# says whether a case measures the rules or the model's own habits.
if [ -n "${BASELINE:-}" ]; then
  STYLE=""; MODE=baseline
elif [ -n "${CORE:-}" ]; then
  STYLE=$(cat "$CORE_FILE"); MODE=core
else
  STYLE=$(cat "$SKILL_FILE"); MODE=skill
fi
MODEL_ARG=""
[ -n "${MODEL:-}" ] && MODEL_ARG="--model ${MODEL}"

# Where the style and the facts are handed to the CLI. `--append-system-prompt-file`
# is what keeps this working as the skill grows; an older CLI without it falls
# back to the command line, which is the arrangement that broke on Windows.
SYS_FILE="${TMPDIR:-/tmp}/concise-eval-sys.$$"
trap 'rm -f "$SYS_FILE"' EXIT INT TERM
SYS_MODE=file
"$BIN" --help 2>&1 | grep -q 'append-system-prompt\[-file\]\|append-system-prompt-file' || {
  SYS_MODE=arg
  echo "note: this '$BIN' has no --append-system-prompt-file; falling back to the" >&2
  echo "      command line, which Windows caps at 32767 characters. Update the CLI" >&2
  echo "      if the suite dies with 'Argument list too long'." >&2
}
echo "mode=$MODE skill=$SKILL runs=$RUNS${MODEL:+ model=$MODEL}"

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

  ok=0
  attempt=1
  while [ "$attempt" -le "$RUNS" ]; do

  # The style and the facts used to travel on the command line, which Windows
  # caps at 32767 characters. The PT skill reached 31 KB and the suite began
  # dying with "Argument list too long" partway through — a ceiling that moves
  # closer every time a rule lands. A file has no such limit.
  printf '%s\n\n%s\n\n%s\n' "$STYLE" \
"You are replying in a terminal. Do not use tools. The facts below are things
you already verified yourself this session — treat them as your own findings,
and treat any action they describe as one you have not performed yet." \
    "$facts" > "$SYS_FILE"

  # shellcheck disable=SC2086
  if [ "$SYS_MODE" = file ]; then
    response=$("$BIN" -p "$prompt" $MODEL_ARG --append-system-prompt-file "$SYS_FILE")
  else
    response=$("$BIN" -p "$prompt" $MODEL_ARG --append-system-prompt "$(cat "$SYS_FILE")")
  fi
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

  # shellcheck disable=SC2086
  verdict=$("$BIN" -p $MODEL_ARG "Grade the response below against the rubric, item by
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
    ok=$((ok+1))
  else
    lastverdict=$verdict
  fi
  attempt=$((attempt+1))
  done

  if [ "$ok" -eq "$RUNS" ]; then
    echo "PASS  $name"; pass=$((pass+1))
  elif [ "$ok" -gt 0 ]; then
    # Flaky is a finding, not a pass: the rule holds sometimes.
    echo "FLAKY $name  ($ok/$RUNS)"; failn=$((failn+1))
    printf '%s\n' "$lastverdict" | sed 's/^/      /'
  else
    echo "FAIL  $name"; failn=$((failn+1))
    printf '%s\n' "$lastverdict" | sed 's/^/      /'
  fi
done

echo "----"
echo "$pass passed, $failn failed  (mode=$MODE)"
[ $((pass + failn)) -gt 0 ] || { echo "no case matched ONLY=${ONLY:-}" >&2; exit 2; }
# In baseline mode a pass is not good news — it means the case measures the
# model's own habits, not the rules — so the exit code is informational.
[ "$MODE" = baseline ] && exit 0
[ "$failn" -eq 0 ]
