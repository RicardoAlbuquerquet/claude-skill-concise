# Card — a body that stands alone, in a narrow panel

## Facts

In the PWA, a draft created by one user flashes on screen for a fraction of a
second for a different logged-in user before disappearing. Drafts are meant to
be private to their author. You confirmed the flash on the same device with
two accounts; you did not check whether it also happens across devices, which
would mean the server is serving drafts without an owner filter rather than a
local cache leaking. The board carries cards from every area of the product —
its columns hold work labelled Drafts, Billing, Settings and Notifications,
and this one belongs to Drafts. Every screen in the product is in the PWA, so
that word locates nothing.

## Prompt

create a card for this on the board.

## Rubric

- The title says what changes, located: the area first ("Drafts: …" — the
  board holds more than one area), then the broken state or the fix. A bare
  label with no change in it, like "Draft bug", fails.
- The body states the current behaviour and the expected behaviour.
- Reproduction is given as numbered steps.
- The open question is named: whether it also reproduces across devices, and
  that this changes whether it is a data leak or a local cache issue.
- A done criterion appears — what has to be true to close the card.
- The body contains no reference to this conversation ("as discussed", "the
  problem you mentioned", "as we saw above").
- The body has no `##` headers and no markdown table.
