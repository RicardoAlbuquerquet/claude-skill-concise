---
description: Draft a review comment, a thread reply, a note on a card, or a message to a person — the claim first, the line that proves it, one point per comment
argument-hint: "[what the comment is about, and optionally where it goes]"
---

Write one comment or message following the "Comments and replies" section of
the `concise` ruleset. Invoke the skill first if the full ruleset is not
already in context.

The subject is the text below. If it is empty, the subject is the thing most
recently under discussion — the diff hunk you just read, the thread you were
asked about, the question someone put to you.

$ARGUMENTS

First, two things before drafting:

1. **Read what you are commenting on.** Open the file at the line, read the
   thread from the top, read the card. A review comment about a line you did
   not open is a guess wearing a `path:line`, and the author finds out before
   you do. When you cannot reach it — no access, no such line — say so and
   stop.
2. **Name the kind**, because it changes the shape: a review comment anchored
   to a diff line, a reply inside a thread, a note on someone's card, or a
   message to a person. If the invocation didn't say and the subject doesn't
   make it obvious, write a review comment and say you assumed that.

Rules of the comment:

- **The claim, then the line that proves it.** "This drops the retry on 401
  (`retry.ts:88`), so a wrong password locks the account after three tries."
  Without the anchor it is an opinion, and the author has to go find what you
  already found.
- **Say whether it blocks.** The reader's first question is whether they have
  to act before merging. A change request, a suggestion they can take or
  leave, and a note for later are three different comments — say which one
  this is, in it, not in a label they may not see.
- **One comment, one point.** Two unrelated points are two comments, so each
  gets resolved on its own. If the subject holds several, deliver several
  blocks rather than one comment with a list inside it.
- **A reply answers in the first sentence.** When the answer is "you were
  right, fixed in `a1b2c3d`", that is the whole reply — no re-argument of what
  is now settled, no recap of the thread the reader just read.
- **Say what would change your mind** instead of hedging the claim. "Unless
  there's a caller I missed" beats "maybe consider possibly".
- **No praise as filler.** A generic opener costs the reader a paragraph to
  find out this is a request for changes. Praise that names a specific
  decision is content; "Great work here!" is not.
- **When the fix is one line, give the line.** A suggestion block, or the
  replacement itself — asking for a change and leaving its shape to the
  reader costs a round trip.
- **The reader was not in this conversation** and will not scroll up: no "as
  discussed", no reference to this chat, exact values rather than descriptions
  of them. A note on a card is the summary of the summary: three lines is
  already long and one is common — what changed or what they have to do, with
  the anchor. It also takes the narrow panel: no headers, no tables, bold only
  as an item label. What needs a second paragraph is an edit to the card body,
  not a comment on it.
- Never sign as an AI agent, here or anywhere.

Before delivering, audit the draft yourself — claim first, anchor present,
blocking or not stated, one point, three lines at most when it is a note on a
card, nothing that only makes sense to someone who read this conversation —
and fix what fails. Deliver only the clean
version.

Delivery: each comment in its own fenced block, ready to paste, with four
backticks when it carries a fence of its own — a suggestion block does. When
there are several, put the anchor above each block on its own line
(`retry.ts:88`) so they can be pasted into the right places. Nothing after
them except values you could not fill from the subject, one line each,
opening with **Missing:**.

Posting: draft only, by default. When the invocation names a destination a
tool can reach — a PR number, an issue URL, a card id, with `gh` or an MCP
board available — show the draft and the exact target, and post it only after
the user says to, in this conversation. A named destination tells you where
it would go; it is not permission to notify someone.
