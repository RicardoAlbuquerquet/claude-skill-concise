#!/usr/bin/env bash
# A change inside a plugin that doesn't bump its version never reaches an
# installed copy: the self-update hook runs `claude plugin update`, which
# compares version numbers. This makes the CONTRIBUTING rule executable.
# Usage: check-bump.sh [base-ref]   (default origin/main)
set -u

BASE="${1:-origin/main}"
fail=0

version () { sed -n 's/.*"version": *"\([^"]*\)".*/\1/p'; }

for dir in skills/concise skills/respostas-curtas; do
  manifest="$dir/.claude-plugin/plugin.json"
  changed=$(git diff --name-only "$BASE"...HEAD -- "$dir" | wc -l | tr -d ' ')
  old=$(git show "$BASE:$manifest" 2>/dev/null | version)
  new=$(version < "$manifest")
  if [ "$changed" -gt 0 ] && [ "$old" = "$new" ]; then
    printf '%-28s %s file(s) changed, version still %s — bump it\n' "$dir:" "$changed" "$new"
    fail=1
  else
    printf '%-28s ok (changed=%s, %s -> %s)\n' "$dir:" "$changed" "${old:-?}" "$new"
  fi
done

exit $fail
