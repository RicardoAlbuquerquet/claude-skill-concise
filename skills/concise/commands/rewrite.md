---
description: Rewrite a finished text to the concise ruleset — same information, none of the padding
argument-hint: "[text to rewrite — empty targets your previous reply]"
---

Rewrite one finished text so it complies with the `concise` ruleset. If the
full ruleset is not already in context, invoke the `concise` skill first.

The target is the text below. When the whole argument is a path to a file
that exists, read that file and rewrite its contents; when it is empty, the
target is your own previous response in this conversation; otherwise the
argument itself is the text.

$ARGUMENTS

Rules of the rewrite:

- **Same facts, same commitments.** Rewriting is not summarising: every exact
  value, caveat, piece of bad news, and scope note in the original survives.
  The "Never cut" list applies to what the original *said*, not to what is
  convenient to keep.
- **You may add what the original owed** — a missing cost on a recommendation,
  a missing test step on a PR description — but only when the original
  contains the information to fill it. When it doesn't, report the hole
  instead of inventing content. Never invent a value, a number, or a result.
- **Pick the register by destination.** A PR description follows the PR
  section of the ruleset; a task or issue follows its section, including the
  two-widths thresholds for title and body; a chat reply follows the budgets
  table.

Deliver the rewritten text first. Put it in a fenced block when it is destined
for another surface — PR, issue, commit message, e-mail — so it can be copied
whole, with four backticks when the text carries a fence of its own; leave it
as prose when it is a chat reply. A file target is delivered the same way —
never edit the file unless the user asks. After it, only if the original was
missing something the ruleset requires, add one line per hole, each opening
with **Missing:**. Nothing else: no before/after word counts, no commentary
on what was cut.
