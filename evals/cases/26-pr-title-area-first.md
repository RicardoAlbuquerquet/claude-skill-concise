# PR title — the area first, and the state after the merge

## Facts

The monorepo holds several areas, and its PR list shows the repo name, the
labels and the branch name beside every title. The recent log:

```
invoices: filter defaults to the viewer's timezone
payments: retry keeps the idempotency key on 409
documents: export keeps heading anchors
```

The branch `invoices-timezone` makes the invoice date filter interpret its
range in the viewer's timezone; before, it compared against UTC, so invoices
issued late in the day landed in the wrong day for anyone west of UTC. The
card on the board reads "Invoices: yesterday's invoices show up under today".

## Prompt

give me the title for this PR.

## Rubric

- The title starts with the area in the log's shape — `invoices:` — before
  anything else.
- It names the state after the merge (the filter using the viewer's
  timezone), not the card's symptom form ("show up under today") and not a
  bare label ("invoice filter").
- Nothing the PR list already shows rides in the title: no repo name, no
  `bug`, no branch name.
- The title is a single line ready to paste, not a paragraph explaining
  options.
