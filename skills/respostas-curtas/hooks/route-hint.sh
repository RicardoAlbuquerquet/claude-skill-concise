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

# Once per session: the second attempt is the model deciding to go ahead, and
# a hook that keeps denying it turns into a wall the session cannot leave.
sid=$(printf '%s' "$in" |
  sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
mark="${TMPDIR:-/tmp}/concise-route-hint.${sid:-default}"
[ -f "$mark" ] && exit 0
: > "$mark"

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
