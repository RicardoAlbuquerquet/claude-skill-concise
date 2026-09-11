#!/usr/bin/env bash
# The forced output style already carries the core in the system prompt, so
# this prints only what the style cannot: the user's own core override, when
# one exists, and one line naming the shell the reader will paste into — a
# fence tagged for the wrong shell does not run: `&&` is a parse error in
# Windows PowerShell 5.1, and `bash` typed there is the WSL stub.
#   $1 = override file name under ~/.claude
#   $2 = shipped core file name under the plugin's hooks/, printed only with
#        CONCISE_INJECT_CORE=1 — for a Claude Code that ignores
#        force-for-plugin, or when another plugin's forced style loads first
#   $3 = the Windows line   $4 = the macOS line   $5 = the Linux line
# CONCISE_OS=windows|macos|linux overrides detection, for a terminal that is
# not the host's default — Git Bash or WSL on a Windows machine.
override="$HOME/.claude/$1"
printed=""
if [ -f "$override" ]; then
  cat "$override"
  printed=1
elif [ -n "${CONCISE_INJECT_CORE:-}" ]; then
  cat "$CLAUDE_PLUGIN_ROOT/hooks/$2"
  printed=1
fi

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
if [ -n "$line" ]; then
  [ -n "$printed" ] && printf '\n'
  printf '%s\n' "$line"
fi
exit 0
