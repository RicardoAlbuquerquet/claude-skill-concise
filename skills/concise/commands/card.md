---
description: Draft a task/issue card that stands alone — current → expected, exact values, done criterion — and create it when a destination is given
argument-hint: [what the card is about, and optionally where to create it]
---

Produce one task/issue card following the "Tasks and issues" section of the
`concise` ruleset. Invoke the skill first if the full ruleset is not already
in context.

The subject is the text below. If it is empty, the subject is the most recent
problem or piece of work discussed in this conversation.

$ARGUMENTS

Rules of the card:

- **The reader was not in the conversation.** The body stands alone: no "as
  discussed", no reference to this chat. Exact values — path, command, error
  line, number, environment — not descriptions of them; if the conversation
  didn't produce a value the card needs, name the hole rather than invent it.
- **Every card carries:** a title with the action verb in it; current
  behaviour then expected behaviour, two sentences; exact values; one line of
  done criterion; closed scope — an "and also" means two cards, so say so and
  draft the first.
- **When the case calls for it:** numbered repro steps (with frequency if
  intermittent), impact with who feels it, linked dependencies, the
  attachment that proves it.
- **Narrow-panel structure:** short paragraphs and at most one list; no
  headers, no tables, bold only as item labels. Priority, assignee, and due
  date are fields, not body text — the *reason* for a date is body.

Delivery: title on the first line, body in a fenced block, ready to paste. If
the invocation names a destination — a board, a repo, a project — and a tool
for it is available (MCP, `gh`), create the card there after drafting and
report the id or link; otherwise deliver the draft alone and say where it can
go. Never create anywhere that wasn't named.
