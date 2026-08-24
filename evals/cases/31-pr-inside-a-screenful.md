# PR description — one screenful, and the cut comes out of what repeats

## Facts

The user is on Linux and pastes commands into bash. The project is a web app
for order management, unrelated to whatever repository the working directory
holds; take these facts as given and do not go looking for them.

The branch `exportacao-pedido-vazio` has three commits over `origin/main`, and
they are two deliverables:

- `web/src/export/csv.ts` no longer crashes on an order with no items. The
  total was read straight into a currency formatter, and an order with nothing
  in it has no total; the export now writes `0,00` for that case. Support has
  been closing these tickets as "cannot reproduce" for two months, because the
  order looks fine on screen and only the download fails.
- `web/tests/export.spec.ts` gained a case for the empty order, so the crash
  cannot come back unnoticed.

You verified the test by breaking the fix on purpose: you reverted the guard in
`csv.ts`, ran the export tests, watched them come back `1 failed | 13 passed`,
then restored the guard.

`npm test -- export` now prints `14 passed`. `npm run lint` is green. You did
not run the full suite: it takes about nine minutes and you ran only the export
project.

One thing this branch does not fix, and you found it while in there: the PDF
export reads the same total at `web/src/export/pdf.ts:64` with no guard, so it
crashes the same way. It is behind a permission most accounts don't have, which
is why nobody has reported it.

The repo has no `PULL_REQUEST_TEMPLATE`.

## Prompt

escreva a descrição da PR dessa branch.

## Rubric

- **The description is at most 25 non-empty lines of prose**, counting its
  headers and not counting the fenced command blocks.
- The three sections — what is being solved, what was done, how to test —
  appear in that order, each under its own header.
- **Each deliverable is stated once.** If a list or table carries the two
  deliverables, no paragraph underneath re-explains a row of it; a response
  that states the same deliverable in both a list and the prose fails, even
  though each statement is accurate.
- **What you already ran is reported in at most one sentence, with the output
  that proves it** — `1 failed | 13 passed`. The fail is a step-by-step
  narration of your own trip, spread over two or more sentences or numbered
  steps: reverted the guard, then ran the tests, then watched them fail, then
  restored it. Handing the reviewer that same sequence to run, as the step that
  would prove the test catches the crash, is not a violation — nor is a short
  note attached to it saying that is how you verified it.
- Both caveats survive the length limit, because neither is padding: the full
  suite was not run, and the PDF export at `web/src/export/pdf.ts:64` still
  crashes. A response that came in short by dropping either one fails.
- The test steps are the last section, carrying the exact commands `npm test --
  export` and `npm run lint`, each in its own `bash` fence — two commands
  sharing one fence is a fail. A single trailing line naming something that
  could not be filled from the branch, such as a missing card reference, is
  not a violation. The expected result is named for both: `14 passed` for the first,
  and for the second anything that says green, since the facts give no output
  line for it.
- No `Co-Authored-By`, no "generated with", no credit to any AI agent.
