---
description: Draw the shape in ASCII — refuses a subject that earns no drawing
argument-hint: "[what to draw — empty uses what was just explained]"
---

Draw one diagram, following the "Show the shape" section of the `concise`
ruleset.

The subject is the text below. If it is empty, the subject is the mechanism
most recently explained in this conversation.

$ARGUMENTS

## Beliefs

- **A drawing is believed more than a sentence**, so a hop you inferred is
  fiction the reader will act on.
- **It wraps in the reader's panel, not in your draft** — you never see it
  happen, and a line that wraps stops being a drawing.
- **The eye reads alignment as meaning**: a ragged left edge as a difference
  that isn't there, a long arrow as slow, a floating number against the wrong
  box, a crossing as a connection.
- **A drawing that needs a legend has already failed**, and a box named after
  a table the reader will never query teaches nothing.
- **Every box annotated is no box marked**: the reader reads it as a
  reference table, not as a claim.

## Desires

- The reader sees the shape and the finding at a glance, and can trust every
  hop in it.

## Intentions

First, whether it earns a drawing — and say no when it doesn't: a path with
three or more hops, a branch, a retry or a failure route, the before and
after of a structure you changed, or who calls whom, yes; one function's
behaviour, a three-item list, or a picture of a sentence already on screen,
no — one line saying so, and stop.

Then the layout the subject already has. Four starting points, not moulds:

**A flow** — one path, left to right, everything else hanging under it:

```text
PWA ──every app resume──> /auth/refresh ──> sessions
                           │
                           └─ 2.1 s p95, no index on token_hash
```

**A branch** — top to bottom, the condition on the arrow, both outcomes
starting at the same column:

```text
POST /orders
     │
     ├── stock ok ──────> charge ──> confirmation mail
     │
     └── out of stock ──> backorder queue
                           │
                           └─ nothing tells the buyer
```

**A before/after** — two stacked blocks, same left column and box order, so
the difference is the only thing that moves:

```text
before   worker ──> cache ──> reports_daily
after    worker ────────────> reports_daily
                               │
                               └─ 3 stale reads/day gone
```

**A call tree** — indentation for depth, a second column for what each call
costs:

```text
handleOrder()
├─ validate()      pure
├─ charge()        network, no timeout
│  └─ retry()      ×3, no backoff
└─ notify()        fire and forget
```

The drawing:

- **Every hop grounded in the source** — open the files, follow the call. A
  hop you could not verify carries a trailing `?` on its label, the one form
  (`webhook retried ×3 ?`); a hop you can't even guess is left out and named
  under the drawing.
- **Arrows labelled with what flows and what it costs** — `every app resume`,
  `2.1 s p95`, `retry ×3` — never `calls` or a bare arrowhead.
- **Boxes named by what they do** — `daily copy`, not the table's name —
  unless the name is one the reader will open: a path, a route, a service.
  And named with the words the prose around it uses.
- **Under fifteen lines, and under seventy-two columns** — the hard limit.
  When a before/after won't fit side by side, stack it.
- **One glyph set, one arrowhead, one direction** — left to right for a
  flow, top to bottom for a branch — and what runs in parallel starts at the
  same column.
- **Every label hangs off what it names**, by a `│` down to a `└─`.
- **Bare labels on the line; a closed box only for a node holding two lines**
  or the block compared in a before/after — `┌──────┐` frames cost six lines
  for what `worker ──> cache` already says. One box style per drawing.
- **The happy path on the main line, failure below it**, and the failure
  arrow carries what the reader loses — `timeout: order charged, not
  confirmed`, never `error`.
- **Repetition is a count**: eight identical consumers are one box and `×8`.
- **No legend, no key.** A `×8` or a unit is a label.
- **One mark, on the finding**: the box the finding lives in is the only one
  carrying a hanging note. Two boxes deserving it is two findings, probably
  two drawings.
- **One line under it, only if the drawing doesn't already say it.**

Mermaid instead of ASCII only under two conditions, both required: the
surface renders it — a GitHub comment, issue or PR does; a terminal reply, a
commit body and a plain-text field don't — and the graph is genuinely
two-dimensional: a node with two arrows in, a cycle, a mesh. Then, replacing
the alignment rules and nothing else: `flowchart LR` for a flow, `TD` for a
branch or a tree; the visible label is what the reader reads, never the node
id (`auth["/auth/refresh"]`); every edge labelled, `-->|every app resume|`; a
node shape means something or stays default — `{...}` a real decision,
`[(...)]` a store, `([...])` the entry point; no `style`, `classDef` or
colour; ten nodes is the cap; and stay in the subset that always parses —
quote a label holding a bracket, parenthesis, colon or quote, never `end` as a
bare id, no markdown inside a label.

In this order, because alignment is not fixed afterwards:

1. The main line whole first — boxes and labelled arrows; every column below
   is measured from it.
2. The column each box starts at: the `│` sits under a character of its box,
   not near it.
3. Labels hung top down, the leftmost closing first, so no `└─` crosses an
   open `│`.
4. The longest line measured: past seventy-two columns, cut labels or stack
   blocks — never ship it and hope the panel is wide.

The finish: labels in one register — lowercase, no trailing punctuation,
phrased alike; one unit style per drawing; arrow length is a spacer, never a
signal; a cost column starts at one column and stays there; shorten from the
head, never the tail (`…/auth/refresh.rs:88`); the fence tagged `text` —
untagged loses the rule, a shell tag colours the glyphs — or `mermaid`; a
blank line only between stacked blocks.

Delivery: the drawing in a fenced block tagged `text` — or `mermaid` when it
earned both conditions. Nothing before it except the one sentence it
illustrates, when that sentence isn't already in the conversation.
