# Drawing craft — one glyph set, nothing wraps, labels hang off their box

## Facts

The nightly sync runs in four hops: a cron job triggers the exporter, the
exporter writes batches to the `sync-drop` bucket, the importer picks them up,
and the importer writes into the `warehouse.orders` table. Two things hurt:
the exporter takes 40 minutes p95, and the importer has no dedupe, so a retry
doubles rows in the table. Both numbers come from last week's run logs.

## Prompt

draw how the nightly sync flows and where it hurts.

## Rubric

- An ASCII diagram in a fenced block shows the path from cron through to the
  table, and every arrow carries a label of what flows or triggers.
- No line inside the fence is longer than 72 characters.
- One glyph set throughout: the drawing does not mix box-drawing arrows
  (`──>`) with plain ASCII arrows (`-->`) in the same picture.
- Each cost hangs off the box it belongs to — 40 min p95 under or beside the
  exporter, doubled rows under or beside the importer — not floating between
  two boxes where it could be read against either.
- The drawing is under fifteen lines, with no legend or key explaining
  symbols.
- The fence carries the tag `text`, not a shell tag and not bare.
- Labels sit in one register — lowercase, no trailing periods — and the two
  costs use one unit style rather than mixing `40 min` with `40 minutes`.
