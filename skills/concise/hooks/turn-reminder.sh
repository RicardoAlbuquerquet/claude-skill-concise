#!/usr/bin/env bash
# Puts one line of the style next to every prompt. The core arrives once, at
# session start, and a long session drifts away from it; this lands between
# the user's message and the history on every turn, where it cannot scroll
# out of reach. Emitted as additionalContext, so the model sees it and the
# transcript does not.
#   $1 = the reminder, one line
#   $2 = opt-out flag file under ~/.claude
#   $3.. = `word,word|rule`: the rule joins the reminder when the prompt holds
#          one of the words. Artifact rules cost attention on every other
#          turn, so they ride along only on the turn that writes one. Words
#          are ASCII, matched in lower case, with punctuation turned into
#          spaces — ` pr ` is the word pr, not the end of `sempr`.
# Escape hatch: export CONCISE_NO_TURN_REMINDER=1, or touch the flag file.
text="${1:-}"
flag="${2:-}"
shift 2 2>/dev/null

# Only the prompt field is matched. The event also carries the transcript
# path and the cwd, and a user named Ricardo got the card rule on every turn.
in=$(cat)
p=""
case "$in" in
  *'"prompt"'*)
    p=${in#*\"prompt\"}
    p=${p#*\"}
    p=${p//\\\\/ }
    p=${p//\\\"/ }
    p=${p%%\"*}
    p=${p//\\n/ }
    p=${p//\\t/ }
    ;;
esac
# ${p,,} needs bash 4, and macOS ships 3.2. In the C locale `tr` lowers ASCII
# only and leaves the bytes of an accent alone, which is why words are ASCII.
lc=$(printf ' %s ' "$p" | LC_ALL=C tr '[:upper:]' '[:lower:]' | LC_ALL=C tr -c 'a-z0-9\200-\377' ' ')

[ -n "$flag" ] && [ -f "$HOME/.claude/$flag" ] && exit 0
[ -n "${CONCISE_NO_TURN_REMINDER:-}" ] && exit 0
[ -n "$text" ] || exit 0

for pair in "$@"; do
  rule=${pair#*|}
  IFS=, read -ra words <<< "${pair%%|*}"
  for w in "${words[@]}"; do
    case "$lc" in *"$w"*) text="$text $rule"; break ;; esac
  done
done

esc=${text//\\/\\\\}
esc=${esc//\"/\\\"}
esc=${esc//$'\r'/}
esc=${esc//$'\n'/ }
printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$esc"
