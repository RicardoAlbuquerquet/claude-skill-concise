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

# The hook scripts carry the behaviour (the credit-guard regex among it) and
# must be byte-identical across ports — the language lives in hooks.json, which
# passes the strings in. Counting lines would not catch a one-sided fix.
identical () {
  for f in credit-guard.sh inject-core.sh notices.sh self-update.sh; do
    cmp -s "$EN/hooks/$f" "$PT/hooks/$f" || { printf '%s' "$f differs"; return; }
  done
  printf 'identical'
}

# Same for the shape of hooks.json: same events, same matchers, same script
# called with the same argument count — only the human strings may differ.
shape () {
  sed -n 's/.*"\(SessionStart\|PreToolUse\)".*/\1/p; s/.*"matcher": *"\([^"]*\)".*/matcher=\1/p; s/.*hooks\/\([a-z-]*\.sh\).*/script=\1/p' "$1" | tr '\n' ' '
}

printf '%-38s %8s %8s\n' '' concise resp-cur

check 'SKILL.md: ## sections'     "$(count '^## ' $EN/SKILL.md)"        "$(count '^## ' $PT/SKILL.md)"
check 'SKILL.md: table lines'     "$(count '^\|' $EN/SKILL.md)"         "$(count '^\|' $PT/SKILL.md)"
check 'SKILL.md: bullets'         "$(count '^- ' $EN/SKILL.md)"         "$(count '^- ' $PT/SKILL.md)"
check 'SKILL.md: numbered items'  "$(count '^[0-9]+\. ' $EN/SKILL.md)"  "$(count '^[0-9]+\. ' $PT/SKILL.md)"
check 'SKILL.md: fenced blocks'   "$(count '^```' $EN/SKILL.md)"        "$(count '^```' $PT/SKILL.md)"
check 'hook core: bullets'        "$(count '^- ' $EN/hooks/core.md)"    "$(count '^- ' $PT/hooks/nucleo.md)"
check 'hooks.json: hook count'    "$(count '"type"' $EN/hooks/hooks.json)" "$(count '"type"' $PT/hooks/hooks.json)"
check 'hooks/*.sh: byte-identical' "$(identical)"                        'identical'
check 'hooks.json: shape'          "$(shape $EN/hooks/hooks.json)"       "$(shape $PT/hooks/hooks.json)"
check 'plugin.json: version'      "$(version $EN/.claude-plugin/plugin.json)" "$(version $PT/.claude-plugin/plugin.json)"
check 'commands/: files'          "$(files $EN/commands)"               "$(files $PT/commands)"
check 'agents/: files'            "$(files $EN/agents)"                 "$(files $PT/agents)"
check 'README: ## sections'       "$(count '^## ' README.md)"           "$(count '^## ' README.pt-BR.md)"

exit $fail
