---
description: Put the live options side by side and still recommend one — each cost named, the recommendation argued against the alternatives specifically
argument-hint: "[the decision, and the options if you already know them]"
---

Lay out one decision that belongs to the reader, following the "When the
choice is the user's" section of the `concise` ruleset. Invoke the skill first
if the full ruleset is not already in context.

The subject is the text below. If it is empty, the subject is the choice most
recently raised in this conversation.

$ARGUMENTS

Use this for the calls that are not yours: product trade-offs, money, risk
appetite, anything irreversible. A call that *is* yours does not get a menu —
make it, and say what it cost.

Rules of the layout:

- **Only the live options**, usually two or three. An option you would never
  take is filler dressed as a choice, and it makes the reader work through a
  row to discover you weren't offering it. Say in one line which one you
  dropped and why, rather than padding the table with it.
- **Side by side, in a table**: the option, what it gets them, what it costs.
  Cells hold values and short phrases, not sentences — the argument lives in
  the prose under the table. Build it even when the whole answer is four
  lines; side by side is what makes it a choice instead of a pitch.
- **Then `Recommendation: X`**, with up to three lines for why it wins
  *against the others specifically*. "Redis is fast" is not a comparison;
  "Redis is the only one of the two that survives a deploy" is.
- **Name the condition that flips it.** "If the traffic stays under one
  replica, the in-process counter is the right call" tells the reader which
  fact to check; a recommendation with no flip condition reads as a preference.
- **Check the costs, don't guess them.** Read the config, the pricing page,
  the code that would have to change. A cost you did not verify is named as
  unverified, in the cell, not silently rounded off.
- **What is irreversible says so**, and what the deadline is if there is one.
- **Never stop at "your call".** A block that hands over the options and takes
  the advice out leaves the reader exactly where they were, holding a choice
  whose costs only you measured.

Before delivering, audit the draft yourself — every option live, no column
whose cells all say the same thing, a recommendation present and argued
against the alternatives, the flip condition stated, unverified costs marked —
and fix what fails. Deliver only the clean version.

Delivery: the table and the recommendation in the conversation. When the
invocation names another destination, take that surface's register from the
ruleset — a card or a chat panel is narrow, so the same content goes as one
line per option with the cost after a dash, no table. A decision record in a
file keeps the table and adds the date and what was rejected.

Draft only: do not act on the recommendation, and do not treat the reader
reading it as the reader choosing it.
