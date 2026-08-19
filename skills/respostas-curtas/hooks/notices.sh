#!/usr/bin/env bash
# The only hook that talks to the user: the one-time map of what got
# installed, the version the self-update just applied, and a weekly warning
# when that update has been failing. Emits systemMessage JSON, so it lands on
# the user's screen instead of in the model's context.
#   $1 = plugin name (concise | respostas-curtas)
#   $2 = welcome text, shown once
#   $3 = weekly warning text, "%s" replaced by the update command
plugin="$1"
welcome="$2"
warning="$3"
dir="$HOME/.claude"
notes=""

if [ ! -f "$dir/.$plugin-welcomed" ]; then
  notes="$welcome"
  : > "$dir/.$plugin-welcomed"
fi

note="$dir/.$plugin-update-note"
if [ -s "$note" ]; then
  notes="${notes:+$notes  }$(cat "$note")"
  rm -f "$note"
fi

failed="$dir/.$plugin-update-failed"
if [ -f "$failed" ] && find "$failed" -maxdepth 0 -mtime +6 2>/dev/null | grep -q .; then
  # shellcheck disable=SC2059
  notes="${notes:+$notes  }$(printf "$warning" "claude plugin update $plugin@claude-skill-concise")"
  : > "$failed"
fi

[ -n "$notes" ] || exit 0
printf '{"systemMessage": "%s"}\n' "$(printf '%s' "$notes" | sed 's/\\/\\\\/g; s/"/\\"/g')"
