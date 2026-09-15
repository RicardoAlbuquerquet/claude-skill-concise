---
description: Hand off the work — full state, caveats, and resume command
argument-hint: "[who picks it up or scope — optional]"
---

Write a complete handoff using the `concise` ruleset. If it is absent from
context, invoke it first. Standing caveats must be restated in full.

The argument identifies the recipient or narrows the scope. If empty, write
for a competent reader with no conversation context.

$ARGUMENTS

A handoff starts from zero context: unlike a status update, it must restore
all state needed to continue safely.

Process:

1. Read the real repo state: `git status`, branch/log against its base, and
   open PR/tracker state. Prefer repository truth over memory.
2. Record exact identifiers: branch, latest short SHA, PR/state, card/issue.
3. Separate:
   - **Done** — completed and verified.
   - **Left** — remaining work plus its completion criterion.
4. Restate every active caveat, assumption, constraint, or intentional
   non-change in full.
5. Capture traps: misleadingly finished work, untested paths, required command
   order, intentional dirty state, or other continuation hazards.
6. Record settled decisions and why, including important rejected alternatives.
7. Provide the exact runnable command(s) needed to resume.
8. State blockers, ownership, and what remains stalled.

Validate the handoff before delivering.

Use prose when it stays in this conversation. Use a fenced block when intended
for a card, document, or message; use four backticks if it contains fenced
commands. Use headers when needed for state, remaining work, traps, and resume.

Afterward, include only unresolved information as:

`Unknown: ...`

Draft only. Naming a recipient or destination does not authorize sending it.
