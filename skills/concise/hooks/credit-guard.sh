#!/usr/bin/env bash
# Denies a shell call that would put AI credit into a commit, PR, issue or
# release. Deterministic string match, no API call.
#   $1 = deny reason shown to the model
#   $2 = opt-out flag file under ~/.claude
# Escape hatch for writing *about* the rule (this repo does): export
# CONCISE_ALLOW_CREDIT=1, or touch the flag file to switch the guard off.
reason="$1"
flag="${2:-}"

[ -n "$flag" ] && [ -f "$HOME/.claude/$flag" ] && exit 0
[ -n "${CONCISE_ALLOW_CREDIT:-}" ] && exit 0

in=$(cat)

# Only calls that publish text: a commit, a PR/issue body or comment, a
# release note, a raw API write.
printf '%s' "$in" |
  grep -qE 'git( -C [^ ]+)? commit|gh (pr|issue) (create|edit|comment|review)|gh release (create|edit)|gh api' ||
  exit 0

# A message passed as a file is invisible in the command string — read it.
body=$in
file=$(printf '%s' "$in" |
  grep -oE '(--body-file|--notes-file|--file|-F)[= ]+[^ "]+' |
  head -1 | sed 's/^[^ =]*[= ]*//')
[ -n "$file" ] && [ -f "$file" ] && body="$in
$(cat "$file")"

printf '%s' "$body" |
  grep -qiE 'co-authored-by:.{0,80}(claude|copilot|gemini|cursor|codex|anthropic\.com)|generated with.{0,80}(claude|copilot|gemini|cursor|codex)|co-authored-by:.{0,80}gpt' ||
  exit 0

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
