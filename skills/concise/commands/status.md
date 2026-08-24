---
description: Write the status update — only the delta since the last one, bad news first, and whatever is waiting on the reader in its own block
argument-hint: "[who reads it and where it goes — optional]"
---

Write one status update, following the "Status update mid-work" budget and the
"Never cut" list of the `concise` ruleset. Invoke the skill first if the full
ruleset is not already in context.

The argument below says who reads it and where it goes — a person, a channel,
a comment on the card, this conversation. Empty, the reader is the person you
are already talking to.

$ARGUMENTS

How:

1. **Find the previous update** before writing this one — your last message in
   this conversation, the last comment on the card, the last message in the
   thread. Everything the reader already has is not news, and an update that
   restarts the story makes them re-read to find the two lines that moved.
2. **Find what actually changed**, don't recall it: `git log` since that point,
   `gh run list` or the CI page for the gate, the tracker for what someone
   else moved. An update reporting a green build you did not look at is the
   one failure that costs the reader the most, because they stop checking.
3. **Bad news first** — a failing test, a step you skipped, an estimate that
   moved, an action that rewrote shared state. It goes ahead of the part that
   is fine. Eight confirmations followed by two defects makes the reader walk
   past everything that needs nothing from them.
4. **Only the delta.** One line is the whole update when one thing happened;
   "CI green, merging" is a complete status. A caveat you already stated and
   that hasn't changed is not news again — a clause pointing at it beats the
   paragraph, and it comes back in full only when the reader is about to act
   against it or when you hand the work over.
5. **What waits on the reader gets its own block**, apart from what merely
   informs them — the decision, the access, the review. Say what stalls if it
   doesn't come, and by when.
6. **Say when the next update lands**, or what event produces it. "When CI
   finishes" is an answer; silence is what makes people ask.
7. **Exact values**: the branch, the number, the run, the error line. Never
   "almost done" — say what is left.

When the destination is a channel or a person who may not have the previous
update, one clause of anchor is allowed — "since Tuesday: …" — and a recap is
not. When you genuinely have no previous update to build on, say that in the
first line and give the current state instead of a delta.

Before delivering, audit the draft yourself — nothing the reader already had,
bad news on top, what is blocked and on whom, exact values, no process
narration and no "just wanted to update you" — and fix what fails. Deliver
only the clean version.

Delivery: as prose when the destination is this conversation; in a fenced
block when it goes somewhere else, in that surface's register — a comment on a
card takes the narrow panel, so no headers and no table.

Draft only: never post it, even when the destination is named and a tool can
reach it. Naming where it goes is not permission to notify a person.
