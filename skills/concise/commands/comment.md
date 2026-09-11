---
description: Draft a comment or message — the claim, then the line that proves it
argument-hint: "[what the comment is about, and optionally where it goes]"
---

Write one comment or message. Read
`${CLAUDE_PLUGIN_ROOT}/references/comment.md` first: it holds the rules, and
this file only the procedure.

The subject is the text below. If it is empty, the subject is the thing most
recently under discussion — the diff hunk you just read, the thread you were
asked about, the question someone put to you.

$ARGUMENTS

How:

1. **Read what you are commenting on** — the file at the line, the thread
   from the top, the card. A comment about a line you did not open is a
   guess wearing a `path:line`. When you cannot reach it, say so and stop.
2. **Name the kind**, because it changes the shape: a review comment anchored
   to a diff line, a reply in a thread, a note on someone's card, a message
   to a person. Not said and not obvious: a review comment, and say you
   assumed that.
3. Write it as the reference says, plus what the kind adds: a review comment
   says whether it blocks, inside the comment; a reply answers in the first
   sentence — "you were right, fixed in `a1b2c3d`" is the whole reply; when
   the fix is one line, give the line, as a suggestion block or the
   replacement itself.
4. Count the lines, then check the draft against the reference and fix what
   fails. What goes over three lines is reasoning for the card or the PR,
   never the anchor or the exact value.

Delivery: each comment in its own fenced block, ready to paste — four
backticks when it carries a fence of its own, as a suggestion block does.
Several comments get the anchor above each block on its own line
(`api/src/auth/retry.ts:88`). Nothing after them except values you could not fill from the
subject, one line each, opening with **Missing:**.

Posting: draft only, by default. When the invocation names a destination a
tool can reach — a PR number, an issue URL, a card id — show the draft and
the exact target, and post only after the user says to, in this
conversation. A named destination says where it would go; it is not
permission to notify someone.
