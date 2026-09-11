# Pull request descriptions

## Beliefs

- **The reviewer has the diff open in the next tab**, and it shows what
  changed better than prose: a file-by-file map, a count of what changed or a
  section per area competes with it and loses.
- **The problem is the one part the reviewer can't rebuild** — the title says
  what the PR does, and the diff shows what was done.
- **A column of bold labels down the left edge is what gets read first.** Five
  paragraphs wearing dashes, or an unlabelled block parked between two
  headers, has no way in until it is read whole.
- **A step that reads as verified but wasn't is worse than no step**: the
  reviewer stops checking what nobody checked.
- **A repo's `PULL_REQUEST_TEMPLATE` is a contract**, while a `## Changes`
  header over a diff the reviewer already has open is decoration with the
  template's authority behind it.

## Desires

- The reviewer knows what is solved, reads what was done in one screenful, and
  checks it without having to ask.

## Intentions

- **Three jobs, in this order, under their headers**: what is being solved,
  what was done, how to test it. The problem opens, in the reader's terms:
  "the export truncated its own output whenever the description contained a
  code block" beats "fixes the fence handling".
- **What was done takes the shape the work took**: a paragraph for one thing;
  for several, a markdown list (`- ` at the start of the line), one line each,
  opening with a bold label naming the surface — a screen, an endpoint, a
  file, a behaviour; a table for a value per case. An item past one line is
  two claims or one padded one, and deliverables chained with semicolons are
  the same wall of text.
- **Nothing floats between the sections**: a migration note, a risk, a value
  that came out different, a decision with its cost — each is a line under its
  own bold label, inside the section it belongs to.
- **One screenful — about twenty-five lines of prose, fences not counted.**
  Past that, check whether it is two PRs. A ceiling, not a target, and never
  paid for with a section folded into a sentence, a caveat dropped, or two
  commands sharing a fence. Each deliverable is stated once — a paragraph
  retelling a row of the table above it is the diff again — and a check you
  already ran is one line plus the output that proves it ("already run:
  `44 ok, 0 falhas`"), never the account of running it.
- **When the diff spans many files, one line says where to start reading** —
  the file where the mechanism lives.
- **An alternative you discarded gets a line**, and the argument that
  discarded it goes to the commit body or the card.
- **A template is filled in this register**: its headers kept, a section with
  nothing to say gets "none", a box ticked only when it is true — and a
  template with no slot for the problem still gets it, leading its first
  section in a sentence or two.
- **The title says what changes, the area first, nothing the list already
  shows beside it**, in the shape the repo's log uses — and it names the state
  after the merge, not the symptom a card names: "Documents: bold shows up as
  raw asterisks" is the card; "Documents: escape the asterisks the exporter
  emits raw" is the PR. A description that needs "and also" is two PRs.
- **The card that motivated the work rides along when it exists** —
  `Closes #52` on GitHub, a board card as its link or id — taken from the
  conversation or a tracker a tool can reach, never invented.
- **It ends with how the reviewer checks it**:

1. **The exact command**, copy-pasteable: `npm test -- auth` counts, "run the
   tests" doesn't.
2. **What shows up if it's right** — the number, the output line, the screen.
3. **What would prove it broke**, when step 1's command doesn't cover the
   case.

A step you didn't run says so inside the step, and what you checked instead
goes in that same step — collected at the end, it reads as a disclaimer and
gets skimmed as one. Handing the reviewer the sequence that would prove a
check can break is a step, and stays.
