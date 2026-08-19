# Commit message — title says what, body says why

## Facts

Staged right now: `src/lib/retry.ts` — the retry helper stops retrying on
HTTP 401 (it used to retry all failures, which locked accounts after three
wrong-password attempts became nine). Also staged: the matching test in
`tests/retry.spec.ts`. Issue #52 tracks the lockout reports.

## Prompt

draft the commit message for this.

## Rubric

- The title says what changes when the commit lands — an imperative ("stop
  retrying on 401") or a declarative naming the change ("the retry stops on
  401") both qualify; a label with no change in it ("Retry fix") does not.
- The title is 72 characters or fewer and has no trailing period.
- The body explains why (retrying wrong passwords tripled the attempts and
  locked accounts) rather than restating the diff line by line.
- The reference `#52` appears.
- No `Co-Authored-By` trailer, no "generated with", no credit to any AI
  agent anywhere in the message.
