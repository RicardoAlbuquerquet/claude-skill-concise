Write one status update, following the "Status update mid-work" budget and the
"Always keep" list of the `concise` ruleset. Read `.cursor/rules/concise-full.mdc` first if the
full ruleset is absent from the context.

The argument below says who reads it and where it goes — a person, a channel,
a comment on the card, this conversation. Empty, the reader is the person you
are already talking to.

(Your arguments: whatever you typed after the command name, when there was any.)

How:

1. **Find the previous update** before writing this one — your last message in
   this conversation, the last comment on the card, the last message in the
   thread. Everything the reader already has is old news, and an update that
   restarts the story makes them re-read to find the two lines that moved.
2. **Find what actually changed, in the repo and the tracker**: `git log`
   since that point, `gh run list` or the CI page for the gate, the tracker
   for what someone else moved. An update reporting a green build you left
   unchecked is the one failure that costs the reader the most, because they
   stop checking.
3. **Bad news first** — a failing test, a step you skipped, an estimate that
   moved, an action that rewrote shared state. It goes ahead of the part that
   is fine. Eight confirmations followed by two defects makes the reader walk
   past everything that is already fine.
4. **Only the delta.** One line is the whole update when one thing happened;
   "CI green, merging" is a complete status. A caveat you already stated and
   that stayed the same gets a clause pointing at it, and comes back in full
   only when the reader is about to act against it or when you hand the work
   over.
5. **What waits on the reader gets its own block**, apart from what merely
   informs them — the decision, the access, the review. Say what stalls while
   it is missing, and by when.
6. **Say when the next update lands**, or what event produces it. "When CI
   finishes" is an answer; silence is what makes people ask.
7. **Exact values**: the branch, the number, the run, the error line. Say what
   is left, where "almost done" says only how it feels.

When the destination is a channel or a person who may lack the previous
update, one clause of anchor — "since Tuesday: …" — carries the link, and the
recap stays out. Writing the first update, say so in the first line and give
the current state in place of a delta.

Check the draft against the rules above and fix what fails before delivering.

Delivery: as prose when the destination is this conversation; in a fenced
block when it goes somewhere else, in that surface's register — a comment on a
card takes the narrow panel, so plain paragraphs, with headers and tables left
for the PR.

Draft only: it stays here even when the destination is named and a tool can
reach it. Naming where it goes says the address; notifying a person waits for
the user's word.
