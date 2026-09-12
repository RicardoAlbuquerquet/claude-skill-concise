# Tasks and issues

## Beliefs

- **The reader was away from the conversation.** A card created over MCP or an
  issue on GitHub is read weeks later, by someone else, with the conversation
  out of reach — so what was settled here has to travel inside the card.
- **The column shows the title alone, cut at around 300px**, and the first
  word is the one that gets scanned; the body is read in the detail view a
  click opens.
- **A filled field restated in the body is a copy that goes stale** the
  moment someone edits the field. A reason is different — "the deadline is the
  28th because the invoice run is on the 29th" is a fact only the body holds.
- **A duplicate costs triage twice** and splits the discussion.
- **The history fattens a card** — how you got there, what you ruled out —
  and leaves what the reader will do unchanged.

## Desires

- Three weeks from now, with only the card in hand, someone knows what
  changes, why now, and how to tell it's finished — and can act on it.

## Intentions

Every card carries:

- **A title that says what changes, located**: the area first when the board
  holds more than one — "Documents: bold shows up as raw asterisks" — then the
  symptom when the reader recognises it, or the action verb otherwise
  ("Archived: hide the page from whoever lacks access"). The title always
  carries the change: "Invoice filter" alone is a label. And only what the
  card's fields leave unsaid — a `fix(...)` prefix beside a red `bugfix` label
  spends the scanned characters twice.
- **Current behaviour, then expected behaviour**, two sentences each: the gap
  between them is the work.
- **Exact values in place of descriptions** — path, command, error line,
  number, environment, version: "`/auth/refresh` takes 2.1 s in production"
  says what "login is slow" leaves out.
- **One line of done criterion** — the PR test step in short form.
- **Closed scope**, small enough for one delivery: "and also" is two cards,
  and what this card leaves for another is said when someone could widen it.

And when the case calls for it: **how to reproduce**, as numbered steps, with
how often it fails when it is intermittent; **impact, with who feels it** —
how many users, which customer, what happens while it sits, since that is
what sets priority where "urgent" in the title decides zero; **dependencies
and blockers, linked**; **an attachment that proves it** — screenshot, log,
payload, trace ID.

Its layout, for a body read in a detail view:

- **Two paragraphs, then labelled lines.** Current behaviour, a blank line,
  expected behaviour; then each recurring slot in bold on its own line —
  **Where:** for the files and settings touched, **Done when:**, **Out of
  scope:**, **Repro:** heading its numbered steps, **Impact:**, **Reverts:**.
  One label per line, and the sentence after it in plain text.
- **Two code spans per prose paragraph, and parentheses one level deep.** The
  value the reader will open or type stays in the sentence; the other pointers
  move to **Where:**, which is exempt from the count.
- **A header once the body passes fifteen lines** and carries three blocks
  doing different jobs; below that, `## The problem` over two lines is
  decoration.
- **A table at three rows by three columns or more** with a value in every
  cell; anything smaller is a list, and a destination that renders narrow or
  plain gets the table in a linked document.
- **Fifteen lines is already a long card**, and the body stands alone: "as we
  discussed" and "that problem you mentioned" point at a conversation the
  reader lacks, so the fact itself goes in.

Creating through a tool: what the conversation settled — priority, assignee,
label — goes into the field, in place of both the text and the default. The
tracker's own issue template is a contract: pick the form that matches and
fill it in this register. Look for the card that already exists first, and
point at a likely match — link it, comment on it — in place of a card beside
it. The history stays out: a card describes what is left, and the route to
finding it stays in the conversation.
