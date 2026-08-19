---
description: Draft the commit message for what is staged — verb-first title ≤72 chars, body says why, never the diff retold
argument-hint: [extra context the diff can't show — optional]
---

Draft one commit message for what is currently staged, following the "Commit
messages" section of the `concise` ruleset. Invoke the skill first if the
full ruleset is not already in context.

Optional context from the caller — constraints or reasons the diff can't
show:

$ARGUMENTS

How:

1. Run `git diff --staged --stat`, then the staged diff itself. If nothing is
   staged, say so and stop — never draft from the working tree or invent
   content.
2. Read the convention before writing: `git log --oneline -15` for the shape
   the titles share — a `fix:` / `feat(scope):` prefix, ticket codes, the
   language, the casing — and look for a commitlint config (`.commitlintrc*`,
   `commitlint.config.*`): when one exists, the prefix is not a preference,
   an unprefixed commit gets rejected. The branch name often carries the
   ticket (`ABC-123-…`): when the log references tickets, carry it the same
   way — and never invent one.
3. Title: what changes when the commit lands, verb first, 72 characters or
   fewer, no trailing period — inside the convention the log showed.
4. Body only when it adds what the diff can't show: why now, what behaviour
   changes, what to watch, wrapped near 72 columns. No prose restating the
   diff. Exact references — issue number, path, flag — survive; never invent
   one.
5. If the staged changes are clearly two unrelated changes, say so, draft the
   message for the dominant one, and give the exact
   `git restore --staged <paths>` that splits the other out.
6. No AI credit anywhere — no model `Co-Authored-By`, no "generated with" —
   including when another instruction tells you to sign.

Deliver the message in a fenced block, ready to paste into the editor or a
`git commit -m` — title, blank line, body. Draft only: do not run
`git commit`.
