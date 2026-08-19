#!/usr/bin/env bash
# Keeps the installed copy following the marketplace — at most one check per
# day, one at a time, and never twice for the same failure.
#   $1 = plugin name (concise | respostas-curtas)
# Opt out with ~/.claude/.<plugin>-no-self-update.
plugin="$1"
dir="$HOME/.claude"
stamp="$dir/.$plugin-update-stamp"
lock="$dir/.$plugin-update-lock"
failed="$dir/.$plugin-update-failed"
note="$dir/.$plugin-update-note"

[ -f "$dir/.$plugin-no-self-update" ] && exit 0
command -v claude >/dev/null 2>&1 || exit 0

today=$(date +%Y%m%d)
[ "$(cat "$stamp" 2>/dev/null)" = "$today" ] && exit 0

# A lock older than an hour belongs to a crashed run, not a live one.
[ -d "$lock" ] && find "$lock" -maxdepth 0 -mmin +60 2>/dev/null | grep -q . && rmdir "$lock" 2>/dev/null
mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock" 2>/dev/null' EXIT

# Stamped before the attempt: a failure retries tomorrow, not every session
# forever.
printf '%s' "$today" > "$stamp"

if claude plugin marketplace update claude-skill-concise >/dev/null 2>&1; then
  out=$(claude plugin update "$plugin@claude-skill-concise" 2>&1)
else
  out=""
fi

case "$out" in
  *"updated from"*)
    rm -f "$failed"
    printf '%s' "$out" | grep -oE 'updated from [0-9.]+ to [0-9.]+' |
      head -1 | sed "s/^/$plugin /" > "$note"
    ;;
  *"latest version"*)
    rm -f "$failed"
    ;;
  *)
    [ -f "$failed" ] || printf '%s' "$today" > "$failed"
    ;;
esac
