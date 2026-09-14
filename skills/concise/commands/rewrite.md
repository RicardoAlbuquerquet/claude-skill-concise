---
description: Rewrite a finished text to the rules, keeping every fact
argument-hint: "[text to rewrite — empty targets your previous reply]"
---

Rewrite one finished text so it complies with the `concise` ruleset. Invoke
the `concise` skill first if the full ruleset is absent from the context.

The target is the text below: a path to a file that exists is read and its
contents rewritten; empty targets your own previous response; anything else is
the text itself:

$ARGUMENTS

## Beliefs

- Rewriting keeps every fact the original said: each exact value, caveat,
  piece of bad news and scope note survives.
- What the original owed can be added only when the original holds the
  information to fill it; otherwise it is a hole to report.
- The destination decides the register.
- The file itself changes only when the user asks.

## Desires

- The text arrives ready to paste, carrying everything the original carried.

## Intentions

- Read the file under `${CLAUDE_PLUGIN_ROOT}/references/` that matches the
  destination — PR description, card, commit message, changelog entry, comment
  or text in code; a chat reply follows the budgets table.
- Take every value, number and result from the original.
- Deliver the rewritten text first: a fenced block when it is destined for
  another surface — PR, issue, commit message, e-mail — with four backticks
  when it carries a fence; prose when it is a chat reply.
- Close with one line per thing the ruleset requires and the original lacked,
  each opening with **Missing:**.
- Leave out the word count and the commentary on what you cut.
