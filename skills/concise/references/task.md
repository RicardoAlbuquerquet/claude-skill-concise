# Tasks and issues

## Beliefs

- **The reader wasn't in the conversation.** A card created over MCP or an
  issue on GitHub is read weeks later, by someone else, with nobody to ask —
  so "don't restate what was settled" stops applying: what was settled doesn't
  travel with it.
- **The column shows the title alone, cut at around 300px**, and the first
  word is the one that gets scanned; the body is read in the detail view a
  click opens.
- **A filled field restated in the body is a copy that goes stale** the
  moment someone edits the field. A reason is different — "the deadline is the
  28th because the invoice run is on the 29th" is a fact no field can hold.
- **A duplicate costs triage twice** and splits the discussion.
- **The history fattens a card** — how you got there, what you ruled out —
  without changing what the reader will do.

## Desires

- Three weeks from now, with no conversation, someone knows what changes, why
  now, and how to tell it's finished — and can act on it.

## Intentions

Every card carries:

- **A title that says what changes, located**: the area first when the board
  holds more than one — "Documents: bold shows up as raw asterisks" — then the
  symptom when the reader recognises it, or the action verb when they wouldn't
  ("Archived: hide the page from whoever has no access"). Never a label with no
  change in it ("Invoice filter"), and nothing the card's fields already say —
  a `fix(...)` prefix beside a red `bugfix` label spends the scanned characters
  twice.
- **Current behaviour, then expected behaviour**, two sentences each: the gap
  between them is the work.
- **Exact values, not a description of them** — path, command, error line,
  number, environment, version: "`/auth/refresh` takes 2.1 s in production"
  says what "login is slow" doesn't.
- **One line of done criterion** — the PR test step in short form.
- **Closed scope**, small enough for one delivery: "and also" is two cards,
  and what this card does *not* do is said when someone could widen it.

And when the case calls for it: **how to reproduce**, as numbered steps, with
how often it fails when it doesn't fail every time; **impact, with who feels
it** — how many users, which customer, what happens while it sits, since
"urgent" in the title decides nothing; **dependencies and blockers, linked**;
**an attachment that proves it** — screenshot, log, payload, trace ID.

Its layout, for a body read in a detail view:

- **Two paragraphs, then labelled lines.** Current behaviour, a blank line,
  expected behaviour; then each recurring slot in bold on its own line —
  **Where:** for the files and settings touched, **Done when:**, **Out of
  scope:**, **Repro:** heading its numbered steps rather than replacing them,
  **Impact:**, **Reverts:**. One label per line, nothing bold inside the
  sentence after it.
- **Two code spans per prose paragraph, and no parenthesis inside a
  parenthesis.** The value the reader will open or type stays in the sentence;
  the other pointers move to **Where:**, which is exempt from the count.
- **No header until the body passes fifteen lines** and carries three blocks
  doing different jobs; below that, `## The problem` over two lines is
  decoration.
- **A table only at three rows by three columns** with a value in every cell;
  anything smaller is a list, and a destination that renders narrow or plain
  gets the table in a linked document.
- **Fifteen lines is already a long card**, and the body stands alone: no "as
  we discussed", no "that problem you mentioned".

Creating through a tool: what the conversation settled — priority, assignee,
label — goes into the field, not the text, and not silently into the default.
The tracker's own issue template is a contract: pick the form that matches and
fill it in this register. Look for the card that already exists first, and
point at a likely match — link it, comment on it — instead of creating beside
it. The history stays out: a card describes what is left, not the route to
finding it.
