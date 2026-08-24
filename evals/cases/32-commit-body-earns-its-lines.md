# Commit message — six lines is the ceiling, and none is common

## Facts

The user is on Linux and pastes commands into bash.

Staged, and nothing else: `api/src/session/refresh.ts`, where the refresh
endpoint stopped retrying a `401`. The retry was there for network blips, but
a `401` is a wrong password, and three attempts became nine — the provider
locks the account at five, so a single typo could lock a user out. Issue
`#52` reported it.

How you got there, none of it in the diff: you first suspected the mobile
client, spent an hour reading its retry wrapper, found it innocent, then
bisected the API and landed on `refresh.ts`. You ran `npm test -- retry` (14
pass) and `npm run lint` (green). You did not exercise the provider's lockout
policy on staging, so the claim that accounts stop locking is reasoning, not
a measurement. The changelog entry for the next release is already written
and says "a wrong password no longer locks the account after three tries".

`git log --oneline -15` shows titles like `Sessao nao repete tentativa de
senha errada (#48)` and `Auto-update nao espera o dia dentro do repo (#67)`:
Portuguese, declarative, no prefix, no accents, a PR number appended by the
squash. Recent bodies are almost all empty.

## Prompt

escreva a mensagem de commit do que está staged.

## Rubric

- The title says what changes when the commit lands, in the log's shape —
  declarative, Portuguese, no `fix:` prefix invented, 72 characters or fewer,
  no trailing period. A label with no change in it ("Retry do refresh")
  fails.
- **The body is six lines or fewer**, counting only non-empty lines and not
  the title. Zero is a pass if the title carries the why.
- **The investigation is absent.** The mobile client suspected and cleared,
  the hour spent, the bisect — naming any of it is a fail.
- **The list of what was run is absent**: `npm test -- retry`, the 14 passing
  tests and the lint belong to the PR's test step, not here. Naming them is a
  fail.
- The changelog sentence is not reproduced in the body.
- What survives, if the body exists at all: why now — a `401` is a wrong
  password, so retrying multiplied the attempts toward the provider's lockout
  — and the reference `#52`. Neither is invented, and no other issue number
  appears.
- No `Co-Authored-By`, no "generated with", no credit to any AI agent.
