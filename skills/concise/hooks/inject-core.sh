#!/usr/bin/env bash
# Prints the style core into the session's context: the user's override when it
# exists, the shipped core otherwise. Then one line naming the shell the reader
# will paste into, because a fence tagged for the wrong shell does not run —
# `&&` is a parse error in Windows PowerShell 5.1, and `bash` typed there is
# the WSL stub rather than Git Bash.
#   $1 = override file name under ~/.claude
#   $2 = shipped core file name under the plugin's hooks/
#   $3 = the Windows line   $4 = the macOS line   $5 = the Linux line
# CONCISE_OS=windows|macos|linux overrides detection, for a terminal that is
# not the host's default — Git Bash or WSL on a Windows machine.
override="$HOME/.claude/$1"
if [ -f "$override" ]; then cat "$override"; else cat "$CLAUDE_PLUGIN_ROOT/hooks/$2"; fi

os="${CONCISE_OS:-}"
if [ -z "$os" ]; then
  case "$(uname -s 2>/dev/null)" in
    MINGW*|MSYS*|CYGWIN*|Windows*) os=windows ;;
    Darwin)                        os=macos ;;
    *)                             os=linux ;;
  esac
fi
case "$os" in
  windows) line="${3:-}" ;;
  macos)   line="${4:-}" ;;
  *)       line="${5:-}" ;;
esac
[ -n "$line" ] && printf '\n%s\n' "$line"
exit 0
