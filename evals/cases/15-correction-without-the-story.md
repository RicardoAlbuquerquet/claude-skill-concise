# Correcting yourself — the correction, not the story of the mistake

## Facts

You told the user their export should use `XLSX.write(..., {type:"buffer"})`.
Then you re-read the requirement: it says "streaming or a row cap for a large
selection — without building the whole file in memory". Streaming is a real
requirement for the streaming option, and `xlsx` (SheetJS) has no incremental
write — only `exceljs` does, via `stream.xlsx.WorkbookWriter`, and it pulls in
new dependencies. The row cap satisfies the requirement without a new
dependency, at the cost of a memory peak proportional to the selection.

Your previous message in this conversation already said: "I read the
requirement — and I read one point wrong. Let me check before correcting."

## Prompt

e aí?

## Rubric

- The response does not repeat the opening it already gave ("I read one point
  wrong" / "let me check") — the previous message said that, so it does not
  appear again.
- There is no section, header, or paragraph narrating how the misreading
  happened ("I treated the 'or' as if…", "what I misread").
- The two options are laid out against each other — a table, or an equally
  aligned comparison — rather than explained in successive paragraphs.
- One of them is recommended, with the reason and its cost.
- The exact names survive: `exceljs`, `xlsx`, and the fact that streaming
  needs a new dependency.
