---
description: Draft the PR description from the real diff — `create` opens it
argument-hint: "[base ref, `create` to open it, extra context the diff can't show]"
---

Write the pull request description for the current branch. Read
`${CLAUDE_PLUGIN_ROOT}/references/pull-request.md` first: it holds the rules,
and this file only the procedure.

The argument below may carry a base ref, extra context the diff can't show —
a card id, a constraint, a reason — or both. A leading word that
`git rev-parse --verify` resolves is the base; the literal word `create`
anywhere in it is the permission to open the PR; everything else is context.
No ref, base is `origin/main`.

$ARGUMENTS

How:

1. `git fetch`, then `git log <base>..HEAD --oneline` — the titles carry the
   why — then the diff `<base>...HEAD`: file names first, the diff itself
   where names aren't enough, and enough of the changed files to describe
   behaviour, not lines. No commits over the base: say so and stop.
2. Look for the template: `.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE.md`, `docs/`, or a `.github/PULL_REQUEST_TEMPLATE/`
   directory.
3. Look for the card or issue that motivated the branch: in the conversation,
   then — when `gh` or an MCP board is reachable — by searching it for the
   branch's subject. Not found, no reference, and no question blocking on it.
4. Write it as the reference says. A feature with no screen yet is no excuse
   for a vague test step — the step is the direct call itself, route and body
   included.
5. Check the draft against the reference and fix what fails; over
   twenty-five prose lines, the cut comes out of what repeats something else,
   never out of a caveat, a value or a fence.

Deliver the title first, on its own line, ready for `gh pr create --title`;
then the description in a fenced block, ready for `--body` or the GitHub
form. **Fence the delivery with four backticks**: the description carries a
`bash` block by rule, and a three-backtick wrapper ends at that inner fence.
Nothing after the block except holes you could not fill from the branch, one
line each, opening with **Missing:**.

Draft by default: `gh pr create` does not run. The one exception is the
literal word `create` in the invocation — then you deliver the title and
description as always, run `gh pr create` with exactly those, and report the
URL. The word has to be typed: a base ref, a card id, a branch that obviously
wants a PR, or a PR you opened earlier are none of them permission. Anything
that would make the call wrong stops before it — no commits over the base, a
hole you could not fill, `gh` not authenticated, the branch not pushed — and
you say which, with the draft delivered anyway.
