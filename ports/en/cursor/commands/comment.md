Write one comment or message. Read
`.cursor/rules/concise-comment.mdc` first: it holds the rules, and
this file only the procedure.

The subject is the text below. If it is empty, the subject is the thing most
recently under discussion — the diff hunk you just read, the thread you were
asked about, the question someone put to you.

(Your arguments: whatever you typed after the command name, when there was any.)

How:

1. **Read what you are commenting on** — the file at the line, the thread
   from the top, the card. A comment about a line you skipped is a guess
   wearing a `path:line`. When the line is out of reach, say so and stop.
2. **Name the kind**, because it changes the shape: a review comment anchored
   to a diff line, a reply in a thread, a note on someone's card, a message
   to a person. Left unsaid and unclear: a review comment, and say you
   assumed that.
3. Write it as the reference says, plus what the kind adds: a review comment
   says whether it blocks, inside the comment; a reply answers in the first
   sentence — "you were right, fixed in `a1b2c3d`" is the whole reply; when
   the fix is one line, give the line, as a suggestion block or the
   replacement itself.
4. Count the lines, then check the draft against the reference and fix what
   fails. What goes over three lines is reasoning for the card or the PR; the
   anchor and the exact value stay.

Delivery: each comment in its own fenced block, ready to paste — four
backticks when it carries a fence of its own, as a suggestion block does.
Several comments get the anchor above each block on its own line
(`api/src/auth/retry.ts:88`). After them, only values the subject left open,
one line each, opening with **Missing:**.

Posting: draft only, by default. When the invocation names a destination a
tool can reach — a PR number, an issue URL, a card id — show the draft and
the exact target, and post only after the user says to, in this
conversation. A named destination says where it would go; the user's word in
this conversation is the permission.
