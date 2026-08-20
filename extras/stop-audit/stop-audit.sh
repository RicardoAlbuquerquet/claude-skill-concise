#!/usr/bin/env bash
# Opt-in Stop auditor: judges the turn's final response against the concise
# core and warns on clear violations. Experimental — it costs one API call
# per turn and depends on the transcript format, so on any failure it stays
# silent rather than blocking the session. JSON handling uses jq when
# present, node otherwise; with neither on PATH it does nothing.
set -u
BIN="${CLAUDE_BIN:-claude}"
command -v "$BIN" >/dev/null 2>&1 || exit 0

if command -v jq >/dev/null 2>&1; then
  get_path () { jq -r '.transcript_path // empty' 2>/dev/null; }
  get_last () { jq -rs '[.[] | select(.type=="assistant")] | last
    | .message.content // [] | map(select(.type=="text") | .text)
    | join("\n")' "$1" 2>/dev/null; }
  to_json () { jq -Rs . 2>/dev/null; }
elif command -v node >/dev/null 2>&1; then
  get_path () { node -e 'let d="";process.stdin.on("data",c=>d+=c).on("end",()=>{
    try{process.stdout.write(JSON.parse(d).transcript_path||"")}catch(e){}})' 2>/dev/null; }
  get_last () { node -e 'const fs=require("fs");try{
    const rows=fs.readFileSync(process.argv[1],"utf8").split("\n").filter(Boolean)
      .map(l=>{try{return JSON.parse(l)}catch(e){return null}})
      .filter(x=>x&&x.type==="assistant");
    const m=rows[rows.length-1];
    process.stdout.write((m.message.content||[]).filter(c=>c.type==="text")
      .map(c=>c.text).join("\n"))}catch(e){}' "$1" 2>/dev/null; }
  to_json () { node -e 'let d="";process.stdin.on("data",c=>d+=c).on("end",()=>
    process.stdout.write(JSON.stringify(d)))' 2>/dev/null; }
else
  exit 0
fi

transcript=$(get_path) || exit 0
[ -n "$transcript" ] && [ -f "$transcript" ] || exit 0

last=$(get_last "$transcript")
[ -n "$last" ] || exit 0

# Judge against the shipped core rather than a copy of it. A hand-written
# summary here drifts every time a rule lands, and an auditor grading against
# last month's rules is worse than none. CONCISE_CORE points at the file when
# the plugin root is not in the environment; the four-line fallback is only
# for an install that has neither.
core=""
for c in "${CONCISE_CORE:-}" "$HOME/.claude/concise-core-override.md" \
         "${CLAUDE_PLUGIN_ROOT:-}/hooks/core.md"; do
  [ -n "$c" ] && [ -f "$c" ] && { core=$(cat "$c"); break; }
done
[ -n "$core" ] || core="The answer goes in the first sentence; no preamble,
postamble, or process narration; a recommendation carries its cost; exact
values and caveats are kept."

verdict=$("$BIN" -p "Audit the response below against these rules. Reply with
exactly OK, or with one line naming the single clearest violation.

$core

--- the response ---

$last" 2>/dev/null) || exit 0

case "$verdict" in OK*|ok*|"") exit 0 ;; esac
printf '{"systemMessage": %s}\n' "$(printf 'style: %s' "$verdict" | to_json)"
