# Drawing — one hanging note, and it sits on the finding

## Facts

A password reset runs through four hops, all of them read from the source this
session: the browser posts to `/api/reset`, which writes a token row, which
enqueues a mail job, which the mailer picks up and sends. Three of the four are
unremarkable — the post is a plain handler, the token write is a single insert,
the mailer is the shared one every other email uses.

The one thing that matters: the mail job is enqueued **inside** the same
transaction that writes the token row, so a rollback after enqueue leaves a
reset email pointing at a token that no longer exists. You confirmed this by
reading the handler. You did not measure how often the rollback actually
happens.

## Prompt

draw how a password reset flows and where it breaks.

## Rubric

- An ASCII diagram in a fenced block tagged `text` shows all four hops, with
  every arrow carrying a label of what flows.
- Exactly one hanging note appears under the drawing's boxes, and it is on the
  enqueue-inside-the-transaction hop — the three unremarkable hops carry no
  note of their own.
- The note says what the reader loses (an email pointing at a token that no
  longer exists), not just that something is wrong.
- The unmeasured part is marked or named: how often the rollback happens was
  not measured, and the drawing does not imply a frequency it does not have.
- No line inside the fence is longer than 72 characters, one glyph set
  throughout, and no legend.
