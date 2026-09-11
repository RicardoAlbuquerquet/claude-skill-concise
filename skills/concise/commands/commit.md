---
description: Draft the commit message for what is staged — `run` commits it
argument-hint: "[`run` to commit it, extra context the diff can't show]"
---

Draft one commit message for what is currently staged. Read
`${CLAUDE_PLUGIN_ROOT}/references/commit.md` first: it holds the rules, and
this file only the procedure.

Optional context from the caller — constraints or reasons the diff can't
show. The literal word `run` anywhere in it is the permission to commit:

$ARGUMENTS

How:

1. `git diff --staged --stat`, then the staged diff itself. Nothing staged:
   say so and stop — never draft from the working tree.
2. `git log --oneline -15` for the shape the titles share — prefix, ticket
   codes, language, casing — and a commitlint config (`.commitlintrc*`,
   `commitlint.config.*`), where the prefix is not a preference. When the log
   carries tickets, the branch name often holds this one (`ABC-123-…`); never
   invent one.
3. Which area the staged paths touch, when the repo holds more than one, and
   how the log writes it (`fix(invoices):`, a bare `invoices:`, a ticket
   code). One area only: no prefix invented for a repo whose log has none.
4. Write it as the reference says; count the body lines before delivering.
5. Two unrelated changes staged: say so, draft the message for the dominant
   one, and give the exact `git restore --staged <paths>` that splits the
   other out.

Deliver the message in a fenced block, ready for the editor or
`git commit -m` — title, blank line, body.

Draft by default: `git commit` does not run. The one exception is the literal
word `run` in the invocation — then you deliver the message as always, commit
exactly it, and report the short sha. The word has to be typed; staged
changes waiting are not permission, nor is a commit you made earlier. If step
5 found two unrelated changes, you stop and give the `git restore --staged`
instead of committing a message that describes half of what lands.
