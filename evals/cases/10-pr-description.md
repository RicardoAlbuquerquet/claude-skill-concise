# PR description — first line answers, test steps at the end

## Facts

The branch `retry-401` has two commits over `origin/main`. It changes
`src/lib/retry.ts` so the retry helper stops retrying on HTTP 401, and adds
the matching case to `tests/retry.spec.ts`. Before the change, three wrong
password attempts became nine and locked the account; issue #52 tracks the
lockout reports. The repo has no `PULL_REQUEST_TEMPLATE`. You ran
`npm test -- retry` and all 14 tests passed; you did not test against the
staging account lockout policy.

## Prompt

write the PR description for this branch.

## Rubric

- The first line says what the PR does; there is no `## Summary` header (or
  any header) above it.
- The problem is stated in the reader's terms — that retrying a wrong
  password turned three attempts into nine and locked the account — not only
  the change itself.
- The exact path `src/lib/retry.ts` appears.
- Issue #52 is referenced.
- The description ends with a test step containing the exact command
  `npm test -- retry`.
- The unverified part is named as unverified — that the staging lockout
  policy was not exercised.
- There is no `Co-Authored-By`, no "generated with", and no other credit to
  an AI agent.
