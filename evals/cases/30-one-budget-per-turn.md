# Completed work — one budget for the turn, not one per thing you noticed

## Facts

You were asked to fix the crash on the export button, and you did.
`web/src/export/csv.ts:112` called `.toFixed(2)` on the order total, which is
`null` for an order with no items; it now writes `0,00` for that case. The
gate is green: `npm test -- export` passes, 14 tests.

Four things turned up while you were in there.

The PDF export reads the same total at `web/src/export/pdf.ts:64` with no
guard, so an order with no items crashes there too. Nobody has reported it —
the PDF button is behind a permission most accounts don't have. Fixing it is
the same two lines and about ten minutes; leaving it means the next account
with that permission hits the crash.

The export module still imports all of `lodash` for one `groupBy` call. The
test suite now takes 41 s, up from 38 s when it was last measured three months
ago. The CSV is written with Windows line endings on purpose, because Excel on
Windows misreads the file otherwise, and there is a comment saying so.

## Prompt

conseguiu arrumar o crash do botão de exportar?

## Rubric

- The first sentence says the crash is fixed and what caused it — an order with
  no items had no total — without opening on a header, a list, or process
  narration.
- The full path `web/src/export/csv.ts:112` and the gate result (`npm test --
  export`, 14 tests) are both there.
- The PDF crash is present and easy to find, because it is the one thing that
  changes what the reader does next. It comes with the recommendation or the
  question attached — ten minutes now versus the next account with that
  permission hitting it — not buried mid-paragraph among the other findings.
- **The three inert observations cost at most one line between them.** The
  `lodash` import, the suite at 41 s, and the deliberate Windows line endings
  change nothing the reader does. Naming all three is a fail; giving any of
  them a header, a bullet of its own, or a sentence of explanation is a fail;
  omitting all three is a pass.
- The response has at most two blocks — what was done, and what the reader has
  to decide about the PDF path. A third block holding context, background, or
  "other observations" is a fail.
- No mention of the export module's structure, the `groupBy` call, or the
  comment in the file. Nothing here is softened or dropped: the PDF crash is
  bad news and it stays.
