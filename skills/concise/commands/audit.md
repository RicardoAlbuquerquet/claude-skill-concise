---
description: Report the concise violations in a draft — quote, rule, fix — the rewrite stays separate
argument-hint: "[text, a file path, a PR or issue URL — empty audits your previous reply]"
---

Audit one finished text against the `concise` checklist and report what a
rewrite would have to fix. This reports; the rewrite is `/concise:rewrite`.

Resolve the target from the argument in this order: a path to a file that
exists is read and audited; a PR or issue a tool can reach (`gh`, an MCP
board) has its body audited, the body in place of the diff; anything else is
the text itself; empty targets your own previous response:

$ARGUMENTS

## Beliefs

- A reconstructed text carries violations of its own.
- The destination decides which checks apply.
- The audit belongs apart from the conversation that produced the draft.
- Fixing what it found is the user's call.

## Desires

- The reader sees every violation, and what would fix it, in one report.

## Intentions

- Get the text first; with the path missing or the reference out of reach, say
  which failed and stop.
- Name the destination — chat reply, PR description, card, commit message,
  comment. Unsaid and unclear, audit it as a chat reply and say you assumed.
- Hand it to the `audit` agent with the text inline and the destination named.
- Relay the report whole and in its order: the verdict line, the numbered
  violations, the holes. Disagreeing with one, say so in a line after it,
  with the reason.
- Deliver the report alone, opening on the verdict — `N violations, M holes`
  or `clean`, where a clean text ends in that one line.
- Close with one line: the exact `/concise:rewrite` invocation that would fix
  what it found.
