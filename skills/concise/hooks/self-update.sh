#!/usr/bin/env bash
# Keeps the installed copy following the marketplace — one check every few
# hours, one at a time, and never twice for the same failure.
#   $1 = plugin name (concise)
# Hours between checks: ~/.claude/.<plugin>-update-hours, or 6.
# Opt out with ~/.claude/.<plugin>-no-self-update.
plugin="$1"
dir="$HOME/.claude"
stamp="$dir/.$plugin-update-stamp"
lock="$dir/.$plugin-update-lock"
failed="$dir/.$plugin-update-failed"
note="$dir/.$plugin-update-note"

[ -f "$dir/.$plugin-no-self-update" ] && exit 0

# With no CLI on the PATH nothing can update, and a silent exit leaves the
# copy stale forever. The failure mark is what the weekly warning reads.
if ! command -v claude >/dev/null 2>&1; then
  [ -f "$failed" ] || date +%s > "$failed"
  exit 0
fi

now=$(date +%s)
hours=$(cat "$dir/.$plugin-update-hours" 2>/dev/null)
case "$hours" in ''|*[!0-9]*) hours=6 ;; esac

# One check every few hours is right for everyone except the person shipping
# the versions: inside the marketplace's own repo the throttle would hold the
# cache — and the client's update button with it — stale. The manifest lives
# at the repo root, so resolve the root: a session opened in a subdirectory is
# still inside the repo.
in_repo=0
top=$(git rev-parse --show-toplevel 2>/dev/null)
mf="${top:-.}/.claude-plugin/marketplace.json"
[ -f "$mf" ] &&
  grep -q '"name"[[:space:]]*:[[:space:]]*"claude-skill-concise"' "$mf" &&
  in_repo=1

if [ "$in_repo" = 0 ]; then
  last=$(cat "$stamp" 2>/dev/null)
  case "$last" in
    ''|*[!0-9]*) last=0 ;;
  esac
  [ "$(( now - last ))" -lt "$(( hours * 3600 ))" ] && exit 0
fi

# A session that ends before the check does kills it without running the trap
# below — a headless `claude -p` ends in about a second. The hook's own limit
# is 30 seconds, so a lock older than two minutes belongs to a killed run.
[ -d "$lock" ] && find "$lock" -maxdepth 0 -mmin +2 2>/dev/null | grep -q . && rmdir "$lock" 2>/dev/null
mkdir "$lock" 2>/dev/null || exit 0
trap 'rmdir "$lock" 2>/dev/null' EXIT

# Failed until it succeeds: a killed run records nothing else, and the weekly
# warning reads this mark.
[ -f "$failed" ] || printf '%s' "$now" > "$failed"

if claude plugin marketplace update claude-skill-concise >/dev/null 2>&1; then
  out=$(claude plugin update "$plugin@claude-skill-concise" 2>&1)
else
  out=""
fi

case "$out" in
  *"updated from"*)
    rm -f "$failed"
    printf '%s' "$now" > "$stamp"
    printf '%s' "$out" | grep -oE 'updated from [0-9.]+ to [0-9.]+' |
      head -1 | sed "s/^/$plugin /" > "$note"
    ;;
  *"latest version"*)
    rm -f "$failed"
    printf '%s' "$now" > "$stamp"
    ;;
  # Anything else keeps the stamp and the failure mark: a check that never
  # reached the marketplace retries next session, in place of waiting out the
  # window.
esac
