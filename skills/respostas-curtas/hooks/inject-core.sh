#!/usr/bin/env bash
# Prints the style core into the session's context: the user's override when
# it exists, the shipped core otherwise.
#   $1 = override file name under ~/.claude
#   $2 = shipped core file name under the plugin's hooks/
override="$HOME/.claude/$1"
[ -f "$override" ] && exec cat "$override"
exec cat "$CLAUDE_PLUGIN_ROOT/hooks/$2"
