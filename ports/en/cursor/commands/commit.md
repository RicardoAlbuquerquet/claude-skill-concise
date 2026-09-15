Draft one commit message for the currently staged changes. First read
`.cursor/rules/concise-commit.mdc`; it defines the writing rules.

`(Your arguments: whatever you typed after the command name, when there was any.)` may provide extra context. The literal word `run` grants
permission to commit.

(Your arguments: whatever you typed after the command name, when there was any.)

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

By default, only draft. Run `git commit` only when `(Your arguments: whatever you typed after the command name, when there was any.)` contains the
literal word `run`, using exactly the generated message, then report the short
SHA.

Do not commit when unrelated changes must first be split.
