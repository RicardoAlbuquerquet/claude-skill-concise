Draft one commit message for what is currently staged. Read
`.cursor/rules/concise-commit.mdc` first: it holds the rules, and
this file only the procedure.

Optional context from the caller — constraints or reasons beyond the diff.
The literal word `run` anywhere in it is the permission to commit:

(Your arguments: whatever you typed after the command name, when there was any.)

How:

1. `git diff --staged --stat`, then the staged diff itself. With the stage
   empty, say so and stop — the draft comes from the stage alone.
2. `git log --oneline -15` for the shape the titles share — prefix, ticket
   codes, language, casing — and a commitlint config (`.commitlintrc*`,
   `commitlint.config.*`), where the prefix is a requirement. When the log
   carries tickets, the branch name often holds this one (`ABC-123-…`); a
   ticket goes in only when the branch or the caller gave it.
3. Which area the staged paths touch, when the repo holds more than one, and
   how the log writes it (`fix(invoices):`, a bare `invoices:`, a ticket
   code). One area only: the title stays bare in a repo whose log is bare.
4. Write it as the reference says; count the body lines before delivering.
5. Two unrelated changes staged: say so, draft the message for the dominant
   one, and give the exact `git restore --staged <paths>` that splits the
   other out.

Deliver the message in a fenced block, ready for the editor or
`git commit -m` — title, blank line, body.

Draft by default: `git commit` runs only on the literal word `run` in the
invocation — then you deliver the message as always, commit exactly it, and
report the short sha. The word has to be typed; staged changes waiting, or a
commit you made earlier, count as context, and only the word counts as
permission. If step 5 found two unrelated changes, you stop and give the
`git restore --staged`, and the commit waits for a message that describes all
of what lands.
