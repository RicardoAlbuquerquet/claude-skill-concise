Write one status update, following the "Status update" row of the budgets and
the "Always keep" list of the `concise` ruleset. Read `.cursor/rules/concise-full.mdc` first if the
full ruleset is absent from the context.

The argument says who reads it and where it goes — a person, a channel, a
comment on the card, this conversation. Empty, the reader is the person you
are already talking to:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- The reader already has the last update; restarting the story makes them
  re-read to find the two lines that moved.
- A gate reaches the update after you check it: an assumed green costs the
  reader their trust in every update after it.
- A named destination is an address; the user's word is what notifies a person.

## Desires

- The reader learns in one pass what moved and what waits on them.

## Intentions

- Find the previous update first: your last message here, the last comment on
  the card, the last message in the thread.
- Find what changed since it, in the repo and the tracker: `git log`,
  `gh run list` or the CI page for the gate, whoever moved a ticket.
- Open with bad news — a failing test, a step you skipped, an estimate that
  moved, an action that rewrote shared state.
- Send the delta alone; "CI green, merging" is a complete update. A caveat
  already stated comes back as a clause, and in full only when the reader is
  about to act against it or when you hand the work over.
- Give what waits on the reader its own block: the decision, the access, the
  review, with what stalls and by when.
- Say when the next update lands, or what event produces it.
- Keep exact values — the branch, the number, the run, the error line. Say
  what is left, where "almost done" says only how it feels.
- Carry one clause of anchor — "since Tuesday: …" — for a reader who may lack
  the previous update; a first update says so and gives the current state.
- Check the draft against these rules, then deliver: prose when it stays in
  this conversation, a fenced block in that surface's register when it goes
  elsewhere — a card panel is narrow, so plain paragraphs, headers and tables
  left for the PR.
- Draft only: it stays here even when a tool could reach the destination.
