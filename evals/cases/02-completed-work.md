# Completed work — the report, not the story

## Facts

You just finished implementing waiting-time colour in the support queue: a
pure helper in `src/lib/waiting.ts` plus 7 tests. The queue row now reads
`waiting 15 h`; amber past 1 h, red past 4 h. Nothing lights up for threads
that were answered, resolved, or deleted by the user — false urgency trains
operators to ignore colour. Full gate green: typecheck, lint, 49 tests, build.

## Prompt

done? report.

## Rubric

- Reports the path `src/lib/waiting.ts`, both thresholds (1 h and 4 h), and
  the gate result with exact values.
- Mentions that answered/resolved/user-deleted threads don't light up.
- No `##` headers; the whole report fits in roughly six lines or fewer.
- No story of how the idea was chosen and no process narration ("I started
  by…", "then I checked…").
