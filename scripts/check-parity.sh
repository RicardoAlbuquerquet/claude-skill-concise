#!/usr/bin/env bash
# The two ports are the same document in two languages, and CONTRIBUTING
# requires the structure to stay identical. This compares the structure —
# counts, not words — and fails on the first drift.
set -u

EN=skills/concise
PT=skills/respostas-curtas
fail=0

check () { # label  value_en  value_pt
  if [ "$2" = "$3" ]; then
    printf '%-38s %8s %8s   ok\n' "$1" "$2" "$3"
  else
    printf '%-38s %8s %8s   MISMATCH\n' "$1" "$2" "$3"
    fail=1
  fi
}

count ()   { grep -c -E "$1" "$2"; }
version () { sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$1"; }
files ()   { find "$1" -name '*.md' 2>/dev/null | wc -l | tr -d ' '; }

printf '%-38s %8s %8s\n' '' concise resp-cur

check 'SKILL.md: ## sections'     "$(count '^## ' $EN/SKILL.md)"        "$(count '^## ' $PT/SKILL.md)"
check 'SKILL.md: table lines'     "$(count '^\|' $EN/SKILL.md)"         "$(count '^\|' $PT/SKILL.md)"
check 'SKILL.md: bullets'         "$(count '^- ' $EN/SKILL.md)"         "$(count '^- ' $PT/SKILL.md)"
check 'SKILL.md: numbered items'  "$(count '^[0-9]+\. ' $EN/SKILL.md)"  "$(count '^[0-9]+\. ' $PT/SKILL.md)"
check 'SKILL.md: fenced blocks'   "$(count '^```' $EN/SKILL.md)"        "$(count '^```' $PT/SKILL.md)"
check 'hook core: bullets'        "$(count '^- ' $EN/hooks/core.md)"    "$(count '^- ' $PT/hooks/nucleo.md)"
check 'hooks.json: hook count'    "$(count '"type"' $EN/hooks/hooks.json)" "$(count '"type"' $PT/hooks/hooks.json)"
check 'plugin.json: version'      "$(version $EN/.claude-plugin/plugin.json)" "$(version $PT/.claude-plugin/plugin.json)"
check 'commands/: files'          "$(files $EN/commands)"               "$(files $PT/commands)"
check 'agents/: files'            "$(files $EN/agents)"                 "$(files $PT/agents)"

exit $fail
