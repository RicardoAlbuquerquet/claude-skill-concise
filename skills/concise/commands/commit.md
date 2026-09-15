---
description: Draft a commit for staged changes — `run` commits it
argument-hint: "[`run`, extra context]"
---

Draft one commit message for the currently staged changes. First read
`${CLAUDE_PLUGIN_ROOT}/references/commit.md`; it defines the writing rules.

`$ARGUMENTS` may provide extra context. The literal word `run` grants
permission to commit.

$ARGUMENTS

Process:

1. Inspect `git diff --staged --stat` and the staged diff.
   If nothing is staged, say so and stop.
2. Inspect `git log --oneline -15` and any commitlint config to infer title
   conventions: prefix, scope, ticket, language, and casing.
   Add a ticket only when supplied by the branch name or caller.
3. Infer the affected area from staged paths and follow the repository's
   existing scope style.
4. Write the message according to the reference and validate body length.
5. If staged changes contain two unrelated concerns, stop: draft for the
   dominant one and provide the exact `git restore --staged <paths>` needed
   to separate the other.

Output the complete message in a fenced block: title, blank line, body.

By default, only draft. Run `git commit` only when `$ARGUMENTS` contains the
literal word `run`, using exactly the generated message, then report the short
SHA.

Do not commit when unrelated changes must first be split.
