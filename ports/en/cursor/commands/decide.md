Lay out one decision that belongs to the reader, following the
"Recommendations, choices and plans" section of the `concise` ruleset. Read `.cursor/rules/concise-full.mdc` first if the full ruleset is absent from the context.

The subject is the text below. If it is empty, the subject is the choice most
recently raised in this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

Use this for the calls that belong to the reader: product trade-offs, money,
risk appetite, anything irreversible. A call that *is* yours gets made, with
what it cost.

Rules of the layout:

- **Only the live options**, usually two or three. An option you would refuse
  is filler dressed as a choice, and it makes the reader work through a row
  to discover it was off the table. Say in one line which one you dropped and
  why, and keep the table to the live ones.
- **Side by side, in a table**: the option, what it gets them, what it costs.
  Cells hold values and short phrases; the argument lives in the prose under
  the table. Build it even when the whole answer is four lines; side by side
  is what makes it a choice instead of a pitch.
- **Then `Recommendation: X`**, with up to three lines for why it wins
  *against the others specifically*. "Redis is the only one of the two that
  survives a deploy" is a comparison; "Redis is fast" is a description.
- **Name the condition that flips it.** "If the traffic stays under one
  replica, the in-process counter is the right call" tells the reader which
  fact to check; the flip condition is what turns a preference into a
  judgement.
- **Check the costs.** Read the config, the pricing page, the code that would
  have to change. A cost you left unverified is named as unverified, in the
  cell.
- **What is irreversible says so**, and what the deadline is if there is one.
- **Always end past "your call".** A block that hands over the options with
  the advice taken out leaves the reader exactly where they were, holding a
  choice whose costs only you measured.

Check the draft against the rules above and fix what fails before delivering.

Delivery: the table and the recommendation in the conversation. When the
invocation names another destination, take that surface's register from the
ruleset — a card or a chat panel is narrow, so the same content goes as one
line per option with the cost after a dash, the table left for the wide
surface. A decision record in a file keeps the table and adds the date and
what was rejected.

Draft only: acting on the recommendation waits for the reader to choose it,
in their own words.
