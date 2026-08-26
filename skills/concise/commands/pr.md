---
description: Draft the pull request description for the current branch — grounded in the real diff, exact test steps at the end
argument-hint: "[base ref, `create` to open it, extra context the diff can't show]"
---

Write the pull request description for the current branch, following the PR
section of the `concise` ruleset. Invoke the skill first if the full ruleset
is not already in context.

The argument below may carry a base ref, extra context the diff can't show —
a card id, a constraint, a reason — or both. A leading word that
`git rev-parse --verify` resolves is the base; the literal word `create`
anywhere in it is the permission to open the PR; everything else is context.
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
   a checklist box is ticked only when it's true. A template with no slot for
   the problem does not delete the problem: it opens that template's first
   section, in a sentence or two, before what the header asks for.
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
   for several, a table when the change is a value per case. The whole
   description is one screenful — around twenty-five lines of prose, the
   fenced commands not counted. Past that, check whether it is two PRs before
   cutting anything the reviewer needs. A ceiling, not a target, and three
   things never pay for it: a section folded into a sentence, a caveat
   dropped, and two commands sharing one fence.
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
   anywhere. Several deliverables read as a short list — one line each,
   opening with a **bold label** that names the surface the change landed on,
   `- ` at the start of the line — never a paragraph chained with semicolons
   or dashes, and never an item running past one line, which is two claims or
   one padded one. Each is stated once: a paragraph explaining a row the
   table above it already carries is the diff retold with a grid in front of
   it. And nothing floats between the sections: a migration note, a risk, a
   value that came out different is a line under its own bold label inside
   the section it belongs to, never an unlabelled paragraph parked between
   two headers.
7. End with the test steps: the exact copy-pasteable command, what appears if
   it's right, and what would prove it broke when the command doesn't cover
   the case. When you did not run a step, say so inside the step itself, and
   put what you checked instead in that same step — gathered at the end as a
   paragraph about what did not happen, it reads as a disclaimer and gets
   skimmed as one. When you did run it, that is one line and the output line
   that proves it, never the account of running it — the break-it sequence
   handed to the reviewer to run is a step, not an account. A feature with no
   screen yet is not an excuse — the step is the direct call itself, route
   and body included, not a note that a direct call exists.

Before delivering, audit the draft against the checklist yourself — title in
the repo's shape with its area, the description opening on what is solved, exact
values in spans, every deliverable one line under a bold label, no unlabelled
paragraph between two headers, the three sections in order, nothing restating
the diff or the table beside it, test steps with the unrun ones marked inside
the step — and fix what fails. Count the prose lines too: over twenty-five, the
cut comes out of what repeats something else, never out of a caveat, a value
or a fence. Deliver only the clean version.

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

Draft by default: `gh pr create` does not run. The one exception is the
literal word `create` in the invocation — that is the permission, and then
you deliver the title and description as always, run `gh pr create` with
exactly those, and report the URL. The word has to be typed: a base ref, a
card id, a branch that obviously wants a PR, or a PR you opened earlier in
this conversation are none of them permission. Anything that would make the
call wrong stops before it — no commits over the base, a hole you could not
fill from the branch, `gh` not authenticated, the branch not pushed — and you
say which, with the draft delivered anyway.
