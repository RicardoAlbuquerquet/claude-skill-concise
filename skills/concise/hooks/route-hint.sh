#!/usr/bin/env bash
# Routes a PR description through the command that writes it. Denies the
# first `gh pr create` (or `gh pr edit --body`) of a session with a reason
# naming the command, and lets the call through when it comes again — a
# nudge, never a wall.
#   $1 = deny reason shown to the model
#   $2 = opt-out flag file under ~/.claude
# Escape hatch: export CONCISE_NO_ROUTE_HINT=1, or touch the flag file.
reason="$1"
flag="${2:-}"

[ -n "$flag" ] && [ -f "$HOME/.claude/$flag" ] && exit 0
[ -n "${CONCISE_NO_ROUTE_HINT:-}" ] && exit 0

in=$(cat)

# Only the calls that publish a description.
printf '%s' "$in" |
  grep -qE 'gh pr create|gh pr edit.*--body' ||
  exit 0

# `/concise:pr create` opens the PR with this same call: denying it would send
# the session to run the command it is already running.
transcript=$(printf '%s' "$in" |
  sed -n 's/.*"transcript_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
[ -n "$transcript" ] && [ -f "$transcript" ] &&
  grep -qE '<command-name>/concise:pr</command-name>|"skill":"concise:pr"' "$transcript" &&
  exit 0

# Once per session: the second attempt is the model deciding to go ahead, and
# a hook that keeps denying it turns into a wall the session cannot leave.
sid=$(printf '%s' "$in" |
  sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
mark="${TMPDIR:-/tmp}/concise-route-hint.${sid:-default}"
[ -f "$mark" ] && exit 0
# Nothing else removes a mark. Dropping one older than a day costs a session
# resumed after that at most a second hint.
find "${TMPDIR:-/tmp}" -maxdepth 1 -name 'concise-route-hint.*' -mtime +0 -exec rm -f {} + 2>/dev/null
: > "$mark"

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
