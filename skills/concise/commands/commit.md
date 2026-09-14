---
description: Draft the commit message for what is staged — `run` commits it
argument-hint: "[`run` to commit it, context beyond the diff]"
---

Draft one commit message for what is currently staged. The rules live in
`${CLAUDE_PLUGIN_ROOT}/references/commit.md` — read it first.

Context from the caller, where the literal word `run` is the permission to
commit:

$ARGUMENTS

## Beliefs

- The stage is the whole subject: what is not staged is not in the message.
- The repo's log is the convention the title has to land inside.
- Only the typed word `run` is permission; staged changes waiting are not.

## Desires

- The message arrives ready to paste, and the commit happens only when asked.

## Intentions

- Read `git diff --staged --stat` and then the diff. With the stage empty, say
  so and stop.
- Take the title's shape from `git log --oneline -15` and any commitlint
  config. A ticket goes in only when the branch or the caller gave it.
- Open with the area, written as the log writes it, where the repo holds more
  than one.
- Deliver title, blank line and body in one fenced block, body lines counted.
- Two unrelated changes staged: say so, draft the dominant one, and give the
  `git restore --staged <paths>` that splits the other out. The commit waits.
- On `run`: commit exactly the delivered message and report the short sha.
