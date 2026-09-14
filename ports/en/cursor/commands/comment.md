Write one comment or message. The rules live in
`.cursor/rules/concise-comment.mdc` — read it first.

The subject is the text below; empty, it is whatever is most recently under
discussion — the diff hunk you just read, the thread you were asked about, the
question someone put to you:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- A comment about a line you skipped is a guess wearing a `path:line`.
- The kind changes the shape: a review comment anchored to a diff line, a
  reply in a thread, a note on a card, a message to a person.
- A named destination says where the comment would go; only the user's word in
  this conversation posts it.

## Desires

- The person reads three lines and knows what to do.

## Intentions

- Read what you are commenting on — the file at the line, the thread from the
  top, the card. Out of reach, say so and stop.
- Name the kind. Unsaid and unclear, it is a review comment, and you say you
  assumed that.
- Write it as the reference says, plus what the kind adds: a review comment
  says whether it blocks, inside the comment; a reply answers in the first
  sentence, and "you were right, fixed in `a1b2c3d`" is the whole reply; a
  one-line fix arrives as the line, in a suggestion block or as itself.
- Count the lines, then check the draft against the reference. What runs past
  three lines is reasoning for the card or the PR; the anchor and the exact
  value stay.
- Deliver each comment in its own fenced block, ready to paste — four
  backticks when it carries a fence, as a suggestion block does. Several
  comments get the anchor on its own line above each block
  (`api/src/auth/retry.ts:88`).
- Close with one line per value the subject left open, opening with
  **Missing:**.
- With a destination a tool can reach — a PR number, an issue URL, a card id —
  show the draft and the exact target, and post only after the user says to.
