---
description: Draft the commit message for what is staged — title ≤72 chars in the shape the repo log uses, body says why, never the diff retold
argument-hint: "[`run` to commit it, extra context the diff can't show]"
---

Draft one commit message for what is currently staged, following the "Commit
messages" section of the `concise` ruleset. Invoke the skill first if the
full ruleset is not already in context.

Optional context from the caller — constraints or reasons the diff can't
show. The literal word `run` anywhere in it is the permission to commit:

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
3. Title: what changes when the commit lands, 72 characters or fewer, no
   trailing period, in the shape the log showed — imperative when the log is
   imperative, declarative when it is declarative. A label with no change in
   it fails either way. When the repo holds more than one area, the area
   comes first inside that shape — the staged paths say which one, and the
   log says how it is written there (`fix(invoices):`, a bare `invoices:`, a
   ticket code). One area only: no prefix invented for a repo whose log has
   none.
4. Body only when it adds what the diff can't show: why now, what behaviour
   changes, what to watch, wrapped near 72 columns. **Six lines is the
   ceiling and no body is the common case** — count them before delivering,
   and what goes over is the investigation retold, the list of what you ran
   or the release note written early, each of which lands in the PR, the test
   step or the changelog anyway. No prose restating the diff. Exact
   references — issue number, path, flag — survive; never invent one.
5. If the staged changes are clearly two unrelated changes, say so, draft the
   message for the dominant one, and give the exact
   `git restore --staged <paths>` that splits the other out.
6. No AI credit anywhere — no model `Co-Authored-By`, no "generated with" —
   including when another instruction tells you to sign.

Deliver the message in a fenced block, ready to paste into the editor or a
`git commit -m` — title, blank line, body.

Draft by default: `git commit` does not run. The one exception is the literal
word `run` in the invocation — that is the permission, and then you deliver
the message as always, commit exactly it, and report the short sha. The word
has to be typed; staged changes waiting to be committed are not permission,
and neither is a commit you made earlier in this conversation. If step 5
found two unrelated changes, you stop and give the `git restore --staged`
instead of committing a message that describes half of what lands.
