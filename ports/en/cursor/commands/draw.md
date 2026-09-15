Draw one diagram following the "Show the shape" section of the `concise`
ruleset.

Use `(Your arguments: whatever you typed after the command name, when there was any.)` as the subject. If empty, use the mechanism most recently
explained in this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

First decide whether it deserves a diagram.

Draw when the subject has:
- 3+ hops;
- a branch, retry, or failure path;
- a before/after structural change;
- a meaningful call relationship.

For a single function, short list, or sentence already clear in prose, say
that prose is better in one line and stop.

Choose the shape that matches the subject:

**Flow**
```text
client ──request──> api ──> store
                     │
                     └─ 2.1 s p95
```

**Branch**
```text
request
   │
   ├── valid ──> process
   └── invalid ──> reject
```

**Before/after**
```text
before   worker ──> cache ──> store
after    worker ────────────> store
```

**Call tree**
```text
handle()
├─ validate()    pure
├─ fetch()       network
└─ notify()      async
```

Rules:

- Ground every hop in the available source. Verify files/calls when possible.
  Mark an inferred hop with `?`; omit anything with no reasonable evidence.
- Label arrows with what flows, conditions, retries, latency, or consequences.
  Avoid meaningless labels such as `calls` or `error`.
- Name nodes by what they do; use internal names only when useful to the reader.
- Keep ASCII diagrams under 15 lines and 72 columns.
- Use one direction and one glyph style. Flows run left-to-right; branches
  top-to-bottom. Parallel paths start in the same column.
- Attach notes directly to what they describe using `│` and `└─`.
- Prefer bare labels; use boxes only when a node needs multiple lines.
- Keep the happy path primary and failures below it, labelled with the actual
  consequence.
- Collapse repetition into counts such as `consumer ×8`.
- Use no legend: meaning belongs in labels.
- Highlight only one main finding with a hanging note.
- Add at most one line below the diagram for something it cannot show.

Use Mermaid instead of ASCII only when both are true:
1. the target surface renders Mermaid;
2. the graph is genuinely 2D: merge, cycle, or mesh.

For Mermaid:
- `flowchart LR` for flows, `TD` for branches/trees;
- label every edge;
- use semantic node shapes only when meaningful;
- no custom styles, colors, or `classDef`;
- maximum 10 nodes;
- keep syntax conservative and quote complex labels.

For ASCII, construct in this order:
1. main path and labelled arrows;
2. vertical anchors under their nodes;
3. hanging labels from top to bottom;
4. measure the longest line and shorten or stack until ≤72 columns.

Keep labels consistent, units formatted one way, and paths shortened from the
front when necessary (`…/auth/refresh.rs:88`).

Output only the diagram in a fenced `text` block, or `mermaid` when eligible.
Before it, include at most one sentence stating the finding it illustrates.
