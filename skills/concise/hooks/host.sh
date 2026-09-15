#!/usr/bin/env bash
# Sourced by the hooks that behave differently under Codex, which loads this
# same plugin. Codex hands a plugin PLUGIN_ROOT beside the CLAUDE_PLUGIN_ROOT
# it copies for compatibility; Claude Code sets only its own name.
# CONCISE_HOST=claude|codex overrides the guess.
concise_host () {
  case "${CONCISE_HOST:-}" in
    claude|codex) printf '%s' "$CONCISE_HOST"; return ;;
  esac
  if [ -n "${PLUGIN_ROOT:-}" ]; then printf codex; else printf claude; fi
}

# A string as the inside of a JSON string, with builtins only: these hooks run
# on every session and bash 3.2 on macOS has no `${var@Q}` to lean on.
concise_json () {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\r'/}
  s=${s//$'\t'/\\t}
  s=${s//$'\n'/\\n}
  printf '%s' "$s"
}
