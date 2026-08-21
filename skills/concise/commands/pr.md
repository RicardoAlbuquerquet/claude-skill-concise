---
description: Draft the pull request description for the current branch — grounded in the real diff, exact test steps at the end
argument-hint: [base ref, extra context the diff can't show, or both]
---

Write the pull request description for the current branch, following the PR
section of the `concise` ruleset. Invoke the skill first if the full ruleset
is not already in context.

The argument below may carry a base ref, extra context the diff can't show —
a card id, a constraint, a reason — or both. A leading word that
`git rev-parse --verify` resolves is the base; everything else is context.
No ref, base is `origin/main`.

$ARGUMENTS

How:

1. Run `git fetch`, then `git log <base>..HEAD --oneline` — the commit
   titles carry the why — then diff `<base>...HEAD`: file names first, the
   diff itself where names aren't enough. Read enough of the changed files
   to describe **behaviour**, not lines. If the branch has no commits over
   the base, say so and stop; never invent a description.
2. Check for the repo's template: `.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE.md`, `docs/`, or a `.github/PULL_REQUEST_TEMPLATE/`
   directory. When one exists it is a contract: keep its headers and fill
   them in this register — a section with nothing to say gets a "none", and
   a checklist box is ticked only when it's true.
3. Look for the card or issue that motivated the branch: first in the
   conversation, then — when a tracker tool is reachable (`gh`, an MCP
   board) — by searching it for the branch's subject. Found, it enters the
   description as a reference with its link: `Closes #N` on GitHub when the
   PR resolves it, the card's link or id otherwise. Not found, no reference —
   never invent one, and don't block asking for it.
4. Three sections, in this order, with their headers: **what is being
   solved**, **what was done**, **how to test it**. The problem leads, in the
   reader's terms, taken from the commits, the linked card or the branch name
   and never invented — the title already said what the PR does. Then what
   was done, in the shape the work took: a paragraph for one thing, a list
   for several, a table when the change is a value per case.
5. In those sections, only what the reviewer can't get faster from the diff:
   what changes for whoever uses this, decisions taken with their costs, what
   was left out of scope, and anything unverified — named as unverified. When
   the diff spans many files, one line says where to start reading — the
   file where the mechanism lives.
6. Markdown earns its place here as anywhere: a table for rows and columns, a
   list for the deliverables, code spans on paths and values, bold on the
   claim that carries a block. What does not: prose restating the diff, a
   file-by-file map, a count of what changed, process narration, a section
   for an alternative that a line would carry, and credit to an AI agent
   anywhere. Several deliverables read as a short list — one line each, label
   first, `- ` at the start of the line — never a paragraph chained with
   semicolons or dashes.
7. End with the test steps: the exact copy-pasteable command, what appears if
   it's right, and what would prove it broke when the command doesn't cover
   the case. When you did not run a step, say so inside the step itself. A
   feature with no screen yet is not an excuse — the step is the direct call
   itself, route and body included, not a note that a direct call exists.

Before delivering, audit the draft against the checklist yourself — title in
the repo's shape with its area, the description opening on what is solved, exact
values in spans, deliverables as a list, the three sections in order, nothing
restating the diff, test steps with the unrun ones marked — and fix what
fails. Deliver only the
clean version.

Deliver the title first, on its own line — what changes when it merges, in
the shape the repo's log already uses, the area first inside that shape when
the list holds more than one, and nothing the list already shows beside it.
Not the symptom form a card takes: the title names the state after the merge.
Ready for `gh pr create --title`. Then the description in a fenced
block, ready to paste into `--body` or the GitHub form. **Fence the delivery
with four backticks**: the description carries a `bash` block by rule, and a
three-backtick wrapper ends at that inner fence, truncating the delivery.
Nothing after the block except holes you could not fill from the branch, one
line each, opening with **Missing:**.

Draft only: never run `gh pr create` — opening a PR is the user's call, and
they have the title and body ready to paste.
