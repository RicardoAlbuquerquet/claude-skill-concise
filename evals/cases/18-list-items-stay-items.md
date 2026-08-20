# Completed work — a list item is an item, not a paragraph with a dash

## Facts

You finished a PDF stack for the web app and nothing is committed yet. What
exists:

`web/src/shared/lib/pdf/` is the base. It exports `downloadPdf`, `printPdf`
and `getPdfBlob`, all sharing one page pattern: A4 portrait, footer "Página X
de Y" plus date and time on every page. It also exports `pdfTable`, which
repeats the header across pages and never splits a row; `pdfQr`, which forces
a 25×25 mm minimum; and `withPageBreaks`, which turns a batch into one PDF
with one document per page. The `pdfmake` dependency (version 0.3.11) is
loaded through a dynamic `import()`, keeping ~1.5 MB out of the initial
bundle.

`web/src/modules/estoque/movimento/movimento-pdf.ts` is the data layer: it
fetches `GET /:id`, `/:id/itens` and `/:id/pedido-itens`, and exposes
`exportarMovimentosDetalhesPdf(ids)` and `imprimirMovimentosDetalhesPdf(ids)`.

Docs: `web/docs/ai/conventions/pdf.md` is new; `movimento.md` and `README.md`
were updated.

`make test-web` is green — typecheck and lint pass, with 3 pre-existing `<img>`
warnings that predate this work. A node smoke test rendered 120 rows into 6 A4
pages, with the header repeated on page 3 and "Página 6 de 6" on the last.

## Prompt

terminou? me conta o que ficou pronto e como eu testo.

## Rubric

- The work is reported as a scannable structure — a list, or a table with the
  file or the helper in the first column — and not as prose paragraphs. No
  single item or cell runs past two lines of text. (The skill offers both
  shapes for content like this; only prose fails here.)
- No item stacks three or more parenthetical asides inside itself; details
  that don't fit are split into their own item or dropped.
- These exact values survive: `pdfmake` 0.3.11, ~1.5 MB out of the initial
  bundle, 25×25 mm, and the smoke test numbers (120 rows, 6 pages).
- The gate result is reported including the 3 pre-existing warnings — not
  presented as fully clean.
- The paths `web/src/shared/lib/pdf/` and
  `web/src/modules/estoque/movimento/movimento-pdf.ts` appear.
- No preamble before the answer.
