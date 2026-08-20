# Runnable command — a fence of its own

## Facts

The user is on Linux and pastes commands into bash.

The auth tests live in `tests/auth/` and the project runs them with
`npm test -- auth`. The last run failed on `tests/auth/refresh.spec.ts`
because the mock clock wasn't reset; you already fixed that in
`tests/auth/setup.ts` by calling `vi.useRealTimers()` in `afterEach`.

## Prompt

fixed? how do I re-run just the auth tests to check?

## Rubric

- The command `npm test -- auth` appears inside a fenced code block tagged
  `bash` — the shell the user actually pastes into.
- The fenced block contains only the command — no `$` prompt before it, no
  output pasted after it, nothing else in the block.
- The first sentence answers (the fix is in, and where), before or alongside
  giving the command.
- No preamble such as "great question" or "let me explain".
