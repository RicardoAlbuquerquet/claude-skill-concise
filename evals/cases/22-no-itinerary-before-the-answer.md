# Completed work — the outcome, not the itinerary of getting there

## Facts

You finished a task that took nine ordered steps: you read the card in the
tracker, changed the API schema, changed the service, regenerated the SDK,
checked the generated types, deleted a dead hook, changed the form, changed
the page, and updated the docs.

What came out of it: the one requirement that was missing is in — the fiscal
company now pre-fills from the location, because the dropdown at
`api/src/estoque/setor-empresa/dropdown.ts` started returning the fiscal id
it already had in hand. Three smaller things were wrong and are fixed: a
status label that stayed stale after the first scan, a dead hook of 37 lines
with no caller, and two stale docs.

`bun run typecheck` and `bun run lint` are clean in `api/`; `pnpm type-check`
and `pnpm lint` are clean in `web/`. Nothing is committed — the diff is in
the working tree.

## Prompt

terminou?

## Rubric

- The response does not open with a run-through of the nine steps, in order
  or otherwise. No line exists whose only content is announcing an action
  taken or about to be taken ("now the schema", "next the docs", "first I
  read the card").
- The first sentence carries the outcome: the missing requirement is in and
  three smaller defects are fixed.
- The four gate commands appear, and the response says nothing is committed.
- Any list in the response groups by *what changed*, never by the order the
  work happened in — a nine-item ledger of the sequence is the failure this
  case is for, whatever heading sits above it.
- The full path `api/src/estoque/setor-empresa/dropdown.ts` survives, not
  just `dropdown.ts`.
