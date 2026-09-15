---
description: Draft a comment or message — claim first, evidence second
argument-hint: "[subject, optionally destination]"
---

Draft one comment or message. First read
`${CLAUDE_PLUGIN_ROOT}/references/comment.md`; it defines the writing rules.

Use `$ARGUMENTS` as the subject. If empty, use the most recent relevant
context.

$ARGUMENTS

Process:

1. Read the exact thing being commented on: line, thread, card, or message.
   If the relevant context is unavailable, say so and stop.
2. Determine the kind: review comment, thread reply, card note, or direct
   message. If unclear, assume review comment and state the assumption.
3. Write according to the reference:
   - review comments state whether they block;
   - replies answer in the first sentence;
   - trivial fixes include the exact replacement or suggestion.
4. Keep it ≤3 lines where possible. Preserve the anchor, claim, evidence,
   and exact values; move broader reasoning elsewhere.

Output each comment in its own fenced block, ready to paste. Use four
backticks when the comment contains a fence. For multiple comments, put the
anchor above each block, e.g. `api/src/auth/retry.ts:88`.

Afterward, include only unresolved information as `Missing: ...`, one per
line.

Draft only by default. If a reachable destination is provided, show the
draft and exact target. Post only after explicit user approval in this
conversation.
