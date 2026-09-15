#!/usr/bin/env bash
# Denies a call that would put AI credit into a commit, PR, issue, release,
# card or file. Deterministic string match, no API call. Reading the command
# text leaks: a message can reach git through a variable, a script or an
# editor. So a push also reads the messages git actually stored for every
# commit about to leave, whatever wrote them.
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
    # Only calls that publish text: a commit or an annotated tag, a PR, MR or
    # issue body or comment, a squash merge, a release note, a raw API write —
    # on GitHub or GitLab. Git takes options before the verb: `git -c k=v
    # commit` is a commit too.
    publishes=0; pushes=0
    printf '%s' "$in" |
      grep -qE 'git( +-[cC] +[^ ]+| +--[a-z-]+(=[^ ]+)?)* +(commit|tag)|gh (pr|issue) (create|edit|comment|review|merge)|gh release (create|edit)|gh api|glab (mr|issue) (create|update|note|merge)|glab release (create|update)|glab api' &&
      publishes=1
    printf '%s' "$in" |
      grep -qE 'git( +-[cC] +[^ ]+| +--[a-z-]+(=[^ ]+)?)* +push|gh pr create|glab mr create' &&
      pushes=1
    [ "$publishes" = 1 ] || [ "$pushes" = 1 ] || exit 0

    # The commits a push sends: past the upstream when the branch has one,
    # past the remote's default branch otherwise. `git -C dir` names the repo;
    # without it the hook's own directory is the project.
    if [ "$pushes" = 1 ]; then
      repo=$(printf '%s' "$in" | sed 's/\\"/"/g' | grep -oE 'git +-C +("[^"]+"|[^ ]+)' | head -1 | sed -E 's/^git +-C +"?//; s/"$//')
      g () { if [ -n "$repo" ]; then git -C "$repo" "$@"; else git "$@"; fi; }
      base=$(g rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null) ||
        base=$(g rev-parse --abbrev-ref origin/HEAD 2>/dev/null) || base=""
      if [ -n "$base" ]; then
        hit=$(g log --format='%h%x09%B%x00' "$base..HEAD" 2>/dev/null | tr '\000' '\036' |
          awk 'BEGIN{RS="\036"} tolower($0) ~ /(^|\n)[ \t]*co-authored-by:[^\n]*(claude|copilot|gemini|cursor|codex|gpt|anthropic\.com)|generated with[^\n]*(claude|copilot|gemini|cursor|codex)/ {sub(/^\n/,""); split($0,a,"\t"); print a[1]; exit}')
        if [ -n "$hit" ]; then
          reason="$reason Commit $hit, about to be pushed, carries it: reword it with git commit --amend or an interactive rebase."
          printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
          exit 0
        fi
      fi
      [ "$publishes" = 1 ] || exit 0
    fi

    # A message passed as a file is invisible in the command string — read
    # every file the call names, by flag or by `cat`, quoted or bare. Quotes
    # arrive JSON-escaped, and single ones become double so one pattern holds.
    cmd=$(printf '%s' "$in" | sed 's/\\"/"/g' | tr "'" '"')
    files=$(printf '%s' "$cmd" |
      grep -oE '(--body-file|--notes-file|--file|-F|\$\(cat|Get-Content( -[A-Za-z]+)*)[= ]+("[^"]+"|[^ ")]+)' |
      sed -E 's/^[^ =]+( -[A-Za-z]+)*[= ]+"?//; s/"$//')

    # A script names the file through a variable — `W=...; gh pr create
    # --body-file "$W/pr.md"` — or through the home. Resolve what the call
    # itself assigns, in bash or PowerShell, then the hook's environment; a
    # path still holding an unknown variable stays unread.
    resolve () {
      local f=$1 i=0 name val
      case "$f" in "~"/*) f="$HOME/${f#\~/}" ;; esac
      while [ "$i" -lt 5 ]; do
        name=$(printf '%s' "$f" | sed -nE 's/.*\$(env:)?\{?([A-Za-z_][A-Za-z0-9_]*).*/\2/p')
        [ -n "$name" ] || break
        val=$(printf '%s' "$cmd" |
          grep -oE "(^|[ ;&|(\"])(export +)?\\\$?$name *= *(\"[^\"]*\"|[^ ;&|\"]+)" | tail -1 |
          sed -E "s/^.*$name *= *\"?//; s/\"$//")
        [ -n "$val" ] || val=${!name}
        [ -n "$val" ] || break
        f=${f//\$\{$name\}/$val}
        f=${f//\$env:$name/$val}
        f=${f//\$$name/$val}
        i=$((i + 1))
      done
      printf '%s' "$f" | sed 's#\\\\#/#g; s#\\#/#g'
    }

    while IFS= read -r f; do
      [ -n "$f" ] || continue
      f=$(resolve "$f")
      [ -f "$f" ] && body="$body
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
    # emoji or its link. Codex edits files through a patch, where an added line
    # opens with "+".
    printf '%s' "$body" |
      grep -qiE '(\\n|^)[+[:space:]]*co-authored-by:[[:space:]]{0,4}[^"]{0,80}(claude|copilot|gemini|cursor|codex|gpt|anthropic\.com)|🤖[^"]{0,40}generated with|generated with[^"]{0,40}\[(claude|copilot|gemini|cursor|codex)' ||
      exit 0
    ;;
esac

printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
