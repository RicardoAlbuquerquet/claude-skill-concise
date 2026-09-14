#!/usr/bin/env bash
# Puts one line of the style next to every prompt. The core arrives once, at
# session start, and a long session drifts away from it; this lands between
# the user's message and the history on every turn, where it cannot scroll
# out of reach. Emitted as additionalContext, so the model sees it and the
# transcript does not.
#   $1 = the reminder, one line
#   $2 = opt-out flag file under ~/.claude
#   $3.. = `word,word|rule`: the rule joins the reminder when the prompt holds
#          one of the words, which are matched in lower case and have to be
#          ASCII: the lowering here works byte by byte and mangles an accent.
#          one of the words. Artifact rules cost attention on every other
#          turn, so they ride along only on the turn that writes one.
# Escape hatch: export CONCISE_NO_TURN_REMINDER=1, or touch the flag file.
text="${1:-}"
flag="${2:-}"
shift 2 2>/dev/null

# The prompt arrives on stdin. One `tr` lowercases it: ${in,,} needs bash 4,
# and macOS ships 3.2, where the whole hook dies on a bad substitution.
in=""
while IFS= read -r line || [ -n "$line" ]; do in="$in $line"; done
lc=$(printf '%s' "$in" | tr '[:upper:]' '[:lower:]')

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
