---
description: Draft a task/issue card that stands alone — current → expected, exact values, done criterion — and create it when a destination is given
argument-hint: "[what the card is about, and optionally where to create it]"
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
- **Every card carries:** a title that says what changes, the area first when
  the board holds more than one, the symptom or the action verb after it, and
  nothing a field or a label already says; current
  behaviour then expected behaviour, two sentences; exact values; one line of
  done criterion; closed scope — an "and also" means two cards, so say so and
  draft the first.
- **When the case calls for it:** numbered repro steps (with frequency if
  intermittent), impact with who feels it, linked dependencies, the
  attachment that proves it.
- **The layout:** current behaviour in one paragraph, expected behaviour in
  the next, two sentences each, blank line between — then the recurring
  slots, each opening in bold on its own
  line: **Where:**, **Done when:**, **Out of scope:**, **Repro:**, **Impact:**,
  **Reverts:**. Skip the slots that have nothing in them; never merge two
  into one line, and **Repro:** heads the numbered steps rather than
  swallowing them. Those labels are what the reader scans for, and five
  paragraphs with the done criterion buried in the fourth is the failure this
  replaces.
- **Two code spans in a prose paragraph, no parenthesis inside a
  parenthesis** — the **Where:** line is exempt, it exists to hold them. The
  value the reader opens or types stays in the sentence; a third name in the
  same breath moves to that line or goes.
- **Two widths:** the column shows the title alone and cuts it; the body is
  read in the detail view a click opens. A header only past fifteen lines
  with three blocks doing different jobs, a table only at three rows by three
  columns of values, and a linked document instead when the destination
  renders narrow or in plain text. Priority, assignee, and due date are
  fields, not body text — the *reason* for a date is body.

Before delivering, audit the draft against the card checklist yourself —
what changes in the title with its area, current → expected in two sentences
each, every recurring slot on its own labelled line, no prose paragraph
carrying a third span or a nested parenthesis, exact values, done criterion,
headers and tables only past their thresholds, body standing alone — and fix
what fails. Deliver only the clean version.

Delivery: title on the first line, body in a fenced block, ready to paste.
Fence it with four backticks when the body carries a fence of its own —
repro commands do — so the wrapper doesn't end at the inner one.

When the invocation names a destination — a board, a repo, a project — and a
tool for it is available (MCP, `gh`), create it there after drafting, in this
order:

1. **Look for the card that already exists** — search the destination for the
   symptom or subject. A likely match gets linked and reported instead of a
   duplicate created beside it.
2. **On GitHub, honour the issue template**: pick the matching form under
   `.github/ISSUE_TEMPLATE/`, keep its headers, fill them in this register —
   "none" where there is nothing to say.
3. **Fields, not text**: discover what the destination offers — labels,
   members, statuses, priority — and put what the conversation settled into
   the fields. What nobody settled stays at the default, and you say so.
4. **Wire what's connected**: a named blocker or parent gets the real link —
   a relation or subtask on a board, a `#number` reference on GitHub.
5. Create, then report the id or link — plus the fields you set and the ones
   left at default.

Without a destination, deliver the draft alone and say where it can go.
Never create anywhere that wasn't named.
