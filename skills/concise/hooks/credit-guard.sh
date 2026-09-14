#!/usr/bin/env bash
# Denies a call that would put AI credit into a commit, PR, issue, release,
# card or file. Deterministic string match, no API call.
#   $1 = deny reason shown to the model
#   $2 = opt-out flag file under ~/.claude
# Escape hatch for writing *about* the rule (this repo does): export
# CONCISE_ALLOW_CREDIT=1, or touch the flag file to switch the guard off.
reason="$1"
flag="${2:-}"

[ -n "$flag" ] && [ -f "$HOME/.claude/$flag" ] && exit 0
[ -n "${CONCISE_ALLOW_CREDIT:-}" ] && exit 0

in=$(cat)
tool=$(printf '%s' "$in" |
  sed -n 's/.*"tool_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
body=$in

case "$tool" in
  Bash|PowerShell|'')
    # Only calls that publish text: a commit, a PR/issue body or comment, a
    # squash merge, a release note, a raw API write.
    printf '%s' "$in" |
      grep -qE 'git( -C [^ ]+)? commit|gh (pr|issue) (create|edit|comment|review|merge)|gh release (create|edit)|gh api' ||
      exit 0

    # A message passed as a file is invisible in the command string — read
    # every file the call names, by flag or by `cat`, quoted or bare. Quotes
    # arrive JSON-escaped, and single ones become double so one pattern holds.
    files=$(printf '%s' "$in" | sed 's/\\"/"/g' | tr "'" '"' |
      grep -oE '(--body-file|--notes-file|--file|-F|\$\(cat|Get-Content( -[A-Za-z]+)*)[= ]+("[^"]+"|[^ ")]+)' |
      sed -E 's/^[^ =]+( -[A-Za-z]+)*[= ]+"?//; s/"$//')
    while IFS= read -r f; do
      [ -n "$f" ] && [ -f "$f" ] && body="$body
$(cat "$f")"
    done <<EOF
$files
EOF

    printf '%s' "$body" |
      grep -qiE 'co-authored-by:.{0,80}(claude|copilot|gemini|cursor|codex|anthropic\.com)|generated with.{0,80}(claude|copilot|gemini|cursor|codex)|co-authored-by:.{0,80}gpt' ||
      exit 0
    ;;
  *)
    # A file write or a board call carries the text itself, and a repo that
    # documents the rule quotes the credit in prose. Only the signature shape
    # is denied here: the trailer opening its own line, or the badge with its
    # emoji or its link.
    printf '%s' "$body" |
      grep -qiE '(\\n|^)[[:space:]]*co-authored-by:[[:space:]]{0,4}[^"]{0,80}(claude|copilot|gemini|cursor|codex|gpt|anthropic\.com)|🤖[^"]{0,40}generated with|generated with[^"]{0,40}\[(claude|copilot|gemini|cursor|codex)' ||
      exit 0
    ;;
esac

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
