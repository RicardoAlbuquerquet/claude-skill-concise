Rewrite one finished text so it complies with the `concise` ruleset. If the
full ruleset is absent from the context, read `.cursor/rules/concise-full.mdc` first.

The target is the text below. When the whole argument is a path to a file
that exists, read that file and rewrite its contents; when it is empty, the
target is your own previous response in this conversation; otherwise the
argument itself is the text.

(Your arguments: whatever you typed after the command name, when there was any.)

Rules of the rewrite:

- **Same facts, same commitments.** Rewriting keeps every fact: every exact
  value, caveat, piece of bad news, and scope note in the original survives.
  The **Always keep** list applies to what the original *said*.
- **You may add what the original owed** — a missing cost on a recommendation,
  a missing test step on a PR description — only when the original contains
  the information to fill it; otherwise report the hole. Every value, number
  and result comes from the original.
- **Pick the register by destination.** A PR description, a card, a commit
  message, a changelog entry, a comment or text in code follows its own file
  under `.cursor/rules/` — read it first; a chat reply
  follows the budgets table.

Deliver the rewritten text first. Put it in a fenced block when it is destined
for another surface — PR, issue, commit message, e-mail — so it can be copied
whole, with four backticks when the text carries a fence of its own; leave it
as prose when it is a chat reply. A file target is delivered the same way —
the file itself changes only when the user asks. After it, only if the
original was missing something the ruleset requires, add one line per hole,
each opening with **Missing:**. That is the whole delivery; word counts and
commentary on the cuts stay out.
