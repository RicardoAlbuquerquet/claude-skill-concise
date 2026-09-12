---
description: Draw the shape in ASCII — says so when the subject reads better as prose
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
- **It wraps in the reader's panel, where you see only your draft** — and a
  line that wraps stops being a drawing.
- **The eye reads alignment as meaning**: a ragged left edge as a difference,
  a long arrow as slow, a floating number against the wrong box, a crossing
  as a connection.
- **A legend is the drawing admitting it failed**, and a box named after a
  table teaches only the readers who query that table.
- **Annotate every box and the mark is gone**: the reader reads it as a
  reference table, where a claim has one mark.

## Desires

- The reader sees the shape and the finding at a glance, and can trust every
  hop in it.

## Intentions

First, whether it earns a drawing — and say so when prose serves better: a
path with three or more hops, a branch, a retry or a failure route, the
before and after of a structure you changed, or who calls whom, gets drawn;
one function's behaviour, a three-item list, or a picture of a sentence
already on screen stays as prose — one line saying so, and stop.

Then the layout the subject already has. Four starting points, each open to
the real shape:

**A flow** — one path, left to right, everything else hanging under it:

```text
PWA ──every app resume──> /auth/refresh ──> sessions
                           │
                           └─ 2.1 s p95, token_hash unindexed
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
                           └─ the buyer stays uninformed
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
├─ charge()        network, timeout unset
│  └─ retry()      ×3, backoff unset
└─ notify()        fire and forget
```

The drawing:

- **Every hop grounded in the source** — open the files, follow the call. A
  hop left unverified carries a trailing `?` on its label, the one form
  (`webhook retried ×3 ?`); a hop beyond even a guess is left out and named
  under the drawing.
- **Arrows labelled with what flows and what it costs** — `every app resume`,
  `2.1 s p95`, `retry ×3` — where `calls` or a bare arrowhead says only that
  two boxes relate.
- **Boxes named by what they do** — `daily copy` — and by their internal name
  only when the reader will open it: a path, a route, a service. And named
  with the words the prose around it uses.
- **Under fifteen lines, and under seventy-two columns** — the hard limit.
  When a before/after outgrows side by side, stack it.
- **One glyph set, one arrowhead, one direction** — left to right for a
  flow, top to bottom for a branch — and what runs in parallel starts at the
  same column.
- **Every label hangs off what it names**, by a `│` down to a `└─`.
- **Bare labels on the line; a closed box only for a node holding two lines**
  or the block compared in a before/after — `┌──────┐` frames cost six lines
  for what `worker ──> cache` already says. One box style per drawing.
- **The happy path on the main line, failure below it**, and the failure
  arrow carries what the reader loses — `timeout: order charged, left
  unconfirmed` — where `error` says only that something failed.
- **Repetition is a count**: eight identical consumers are one box and `×8`.
- **Every meaning lives in a label**: a `×8` or a unit is a label, and the
  legend stays out.
- **One mark, on the finding**: the box the finding lives in is the only one
  carrying a hanging note. Two boxes deserving it is two findings, probably
  two drawings.
- **One line under it, only for what the drawing leaves unsaid.**

Mermaid in place of ASCII only under two conditions, both required: the
surface renders it — a GitHub comment, issue or PR does, while a terminal
reply, a commit body and a plain-text field show the source — and the graph
is genuinely two-dimensional: a node with two arrows in, a cycle, a mesh.
Then, replacing only the alignment rules: `flowchart LR` for a flow, `TD` for
a branch or a tree; the visible label is what the reader reads, and the node
id is bookkeeping (`auth["/auth/refresh"]`); every edge labelled,
`-->|every app resume|`; a node shape means something or stays default —
`{...}` a real decision, `[(...)]` a store, `([...])` the entry point; the
default look, free of `style`, `classDef` and colour; ten nodes is the cap;
and stay in the subset that always parses — quote a label holding a bracket,
parenthesis, colon or quote, a bare id other than `end`, labels in plain
text.

In this order, because alignment is fixed at drawing time:

1. The main line whole first — boxes and labelled arrows; every column below
   is measured from it.
2. The column each box starts at: the `│` sits under a character of its box.
3. Labels hung top down, the leftmost closing first, so every `└─` closes
   before it meets an open `│`.
4. The longest line measured: past seventy-two columns, cut labels or stack
   blocks — the draft ships only once it fits.

The finish: labels in one register — lowercase, the last character a letter
or a digit, phrased alike; one unit style per drawing; arrow length is a
spacer only; a cost column starts at one column and stays there; shorten from
the head, keeping the tail (`…/auth/refresh.rs:88`); the fence tagged `text`
— a shell tag colours the glyphs as syntax — or `mermaid`; a blank line only
between stacked blocks.

Delivery: the drawing in a fenced block tagged `text` — or `mermaid` when it
earned both conditions. Before it, at most the one sentence it illustrates,
when the conversation still lacks that sentence.
