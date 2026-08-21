---
description: Draw the shape — ASCII for a sequence, a branch, or a before/after, arrows labelled with what flows, one glyph set, nothing that wraps. Refuses when the subject doesn't earn a drawing
argument-hint: [what to draw — empty uses what was just explained]
---

Draw one diagram, following the "Show the shape" section of the `concise`
ruleset. Invoke the skill first if the full ruleset is not already in context.

The subject is the text below. If it is empty, the subject is the mechanism
most recently explained in this conversation.

$ARGUMENTS

First, decide whether it earns a drawing, and say no when it doesn't:

- **Worth drawing:** a path with three or more hops, anything with a branch, a
  retry or a failure route, the before and after of a structure you changed,
  or who calls whom when the finding is that the wrong thing calls the other
  thing.
- **Not worth drawing:** one function's behaviour, a three-item list, or a
  picture of a sentence that is already on the screen. A diagram repeating the
  line above it is padding with extra steps. When the subject is one of these,
  say so in one line and stop — do not draw it anyway.

Then pick the layout the subject already has. These four are starting points,
not moulds — when the real shape is none of them, draw the real shape.

**A flow**, when it is one path with three or more hops. Left to right, the
whole path on one line, everything else hanging under it:

```
PWA ──every app resume──> /auth/refresh ──> sessions
                           │
                           └─ 2.1 s p95, no index on token_hash
```

**A branch**, when the finding is that two routes diverge. Top to bottom, the
condition on the arrow rather than in a diamond, both outcomes starting at the
same column:

```
POST /orders
     │
     ├── stock ok ──────> charge ──> confirmation mail
     │
     └── out of stock ──> backorder queue
                           │
                           └─ nothing tells the buyer
```

**A before/after**, when you changed a structure. Two stacked blocks, the same
left column and the same box order, so the difference is the only thing that
moves:

```
before   worker ──> cache ──> reports_daily
after    worker ────────────> reports_daily
                               │
                               └─ 3 stale reads/day gone
```

**A call tree**, when the finding is who calls whom. Indentation carries the
depth, and a second column carries what each call costs:

```
handleOrder()
├─ validate()      pure
├─ charge()        network, no timeout
│  └─ retry()      ×3, no backoff
└─ notify()        fire and forget
```

Rules of the drawing:

- **Ground every hop in the source.** Open the files, follow the call. A
  diagram of hops you inferred is fiction the reader will act on, and it is
  believed more than a sentence would be. A hop you could not verify is
  labelled as unverified inside the drawing, or left out and named under it.
- **Label the arrows with what flows and what it costs** — `every app resume`,
  `2.1 s p95`, `retry ×3` — not with `calls` or a bare arrowhead. An unlabelled
  arrow only says two boxes are related, which the reader already assumed.
- **Label the boxes by what they do**, not by their internal name. A box
  reading `daily copy` teaches; the same box carrying the table's name teaches
  nothing to a reader who will never query it. The exception is a name the
  reader will actually use — a path, a route, a service they will open.
- **Under fifteen lines.** Past that it stops being a shape and becomes a
  second document. Cut to the hops that carry the finding.
- **Under seventy-two columns**, and this limit is the hard one. A line that
  wraps stops being a drawing altogether, and it wraps in the reader's panel
  rather than in your draft, so you never see it happen. When a before/after
  will not fit side by side inside that, stack the two blocks instead of
  shrinking the labels.
- **One glyph set and one direction.** Box-drawing or plain ASCII, the same
  arrowhead the whole way down — mixing them reads as two drawings pasted
  together. Left to right for a flow, top to bottom for a branch, and what runs
  in parallel starts at the same column: the eye reads a ragged left edge as a
  difference that is not there.
- **Every label hangs off what it names**, by a `│` down to a `└─`. A number
  floating between two boxes gets read against the wrong one, and nothing in
  the drawing tells the reader which was meant.
- **Bare labels on the line; a closed box only when it earns three lines.**
  `worker ──> cache` is already a drawing, and the same two things inside
  `┌──────┐` frames cost six lines for the same content — the fifteen-line
  budget is five boxes deep. A closed box is for a node holding two lines, a
  name and what it costs, or for the block being compared in a before/after.
  One box style per drawing, the way there is one glyph set.
- **The happy path stays on the main line, failure drops below it.** With the
  error route inline, the reader has to work out which of the two is normal
  before the drawing tells them anything. And the failure arrow carries what
  the reader loses — `timeout: order charged, not confirmed` — never `error`.
- **Repetition is a count, not boxes.** Eight identical consumers are one box
  and `×8`; whatever differs between them goes in the label, and when nothing
  differs the count is the whole content. Drawing all eight spends the budget
  proving they are the same.
- **No legend, no key.** A drawing that needs a line explaining what a glyph
  means has already failed — fold the meaning into the labels, or drop the
  distinction it was carrying. A `×8` or a unit is a label, not a legend.
- **ASCII in a fenced block** always works, and it is the default. `mermaid`
  has its own conditions and its own rules, below.
- **One line under it, only if the drawing doesn't already say it** — the
  finding it points at, the box where the problem lives.

Mermaid instead of ASCII, and only under two conditions, both required. **The
surface renders it** — a GitHub comment, issue or PR description does; a
terminal reply, a commit body and a plain-text field do not, and there the
reader gets the source instead of a picture. **And the graph is genuinely
two-dimensional** — a node with two arrows coming in, a cycle, a mesh. A chain
is a chain, and ASCII carries it while surviving the copy into a terminal, a
commit, or a chat that renders nothing.

When it is mermaid, these replace the alignment rules and nothing else:

- **`flowchart LR` for a flow, `flowchart TD` for a branch or a tree** — the
  same direction rule ASCII takes, for the same reason.
- **The visible label is what the reader reads, never the node id.**
  `auth["/auth/refresh"]` — the id is bookkeeping, and a cryptic id left bare
  becomes a box the reader has to decode before the drawing starts working.
- **Every edge labelled**, `-->|every app resume|`. A bare `-->` is the same
  empty claim in mermaid that it is in ASCII.
- **A node shape means something or stays default.** `{...}` for a real
  decision, `[(...)]` for a store, `([...])` for the entry point, `[...]` for
  everything else. A shape picked for variety is noise the reader tries to
  read as meaning.
- **No `style`, no `classDef`, no colour.** A colour that carries meaning needs
  a legend, and a drawing that needs a legend has already failed; on top of
  that, the reader's theme may be the one you did not test.
- **Ten nodes is the cap**, the mermaid equivalent of fifteen lines. Past it,
  cut to the nodes that carry the finding, or split it into two drawings.
- **You cannot render it before delivering, so stay in the subset that always
  parses.** Quote any label holding a bracket, a parenthesis, a colon or a
  quote; never `end` as a bare node id; no markdown inside a label. A block
  that fails to parse renders as an error box, which is worse than no drawing.

Draw it in this order, because alignment is not something you fix afterwards:

1. Write the main line whole first — the boxes and the labelled arrows, left
   to right. Every column below it is measured from this line, so nothing gets
   drawn under it until it is final.
2. Count the column each box starts at. The `│` sits under a character of its
   box, not near it; an elbow one column off reads as pointing at the arrow
   instead of the box.
3. Hang the labels top down, the leftmost one closing first, so no `└─`
   crosses a `│` that is still open. A crossing is the drawing telling the
   reader two things connect that don't.
4. Measure the longest line before delivering. Past seventy-two columns, cut
   the labels or stack the blocks — never ship it and hope the panel is wide.

Before delivering, audit the draft yourself — every arrow labelled, every hop
verified or marked, no box named after something the reader will never touch,
under fifteen lines and under seventy-two columns, one glyph set, every label
hanging off its own box, no legend, the failure route below the main line,
repetition counted rather than drawn, and no line under it that repeats the
picture — and fix what fails. If it came out as mermaid, audit that it earned both
conditions, that no edge is bare, and that nothing in a label would fail to
parse. Deliver only the clean version.

Delivery: the drawing in a fenced block, tagged for what it is. Nothing
before it except the one sentence it illustrates, when that sentence isn't
already in the conversation.
