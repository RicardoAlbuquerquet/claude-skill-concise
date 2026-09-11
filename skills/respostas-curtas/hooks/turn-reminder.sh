#!/usr/bin/env bash
# Puts one line of the style next to every prompt. The core arrives once, at
# session start, and a long session drifts away from it; this lands between
# the user's message and the history on every turn, where it cannot scroll
# out of reach. Emitted as additionalContext, so the model sees it and the
# transcript does not.
#   $1 = the reminder, one line
#   $2 = opt-out flag file under ~/.claude
# Escape hatch: export CONCISE_NO_TURN_REMINDER=1, or touch the flag file.
text="${1:-}"
flag="${2:-}"

# The prompt arrives on stdin; nothing in it changes the reminder. Drained with
# builtins only: this runs before every prompt, and each process spawned is
# latency the user feels on Windows.
while IFS= read -r _; do :; done

[ -n "$flag" ] && [ -f "$HOME/.claude/$flag" ] && exit 0
[ -n "${CONCISE_NO_TURN_REMINDER:-}" ] && exit 0
[ -n "$text" ] || exit 0

esc=${text//\\/\\\\}
esc=${esc//\"/\\\"}
esc=${esc//$'\r'/}
esc=${esc//$'\n'/ }
printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$esc"
