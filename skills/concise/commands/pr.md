---
description: Draft the pull request description for the current branch — grounded in the real diff, exact test steps at the end
argument-hint: [base ref — defaults to origin/main]
---

Write the pull request description for the current branch, following the PR
section of the `concise` ruleset. Invoke the skill first if the full ruleset
is not already in context.

The base is the ref below if given, otherwise `origin/main`:

$ARGUMENTS

How:

1. Run `git fetch`, then diff `<base>...HEAD` — file names first, the diff
   itself where names aren't enough. Read enough of the changed files to
   describe **behaviour**, not lines. If the branch has no commits over the
   base, say so and stop; never invent a description.
2. First line: what the PR does. After it, only what the reviewer can't get
   faster from the diff: what changes for whoever uses this, decisions taken
   with their costs, what was left out of scope, and anything unverified —
   named as unverified.
3. No template headers over short content, no prose restating the diff, no
   process narration, no credit to an AI agent anywhere.
4. End with the test steps: the exact copy-pasteable command, what appears if
   it's right, and what would prove it broke when the command doesn't cover
   the case. When you did not run a step, say so inside the step itself.

Deliver the description in a fenced block, ready to paste into
`gh pr create --body` or the GitHub form. Nothing after the block except
holes you could not fill from the branch, one line each, opening with
**Missing:**.
