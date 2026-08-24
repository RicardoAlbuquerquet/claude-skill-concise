---
description: Audit a draft against the concise checklist and report only the violations — quoted line, rule broken, one-line fix. Diagnosis, never surgery
argument-hint: "[text, a file path, a PR or issue URL — empty audits your previous reply]"
---

Audit one finished text against the `concise` checklist and report what a
rewrite would have to fix. This reports; it does not rewrite.

Resolve the target from the argument below, in this order: a path to a file
that exists is read and audited; a PR or issue reference a tool can reach
(`gh`, an MCP board) has its body fetched and audited — the body, not the
diff; anything else is the text itself; empty targets your own previous
response in this conversation.

$ARGUMENTS

How:

1. **Get the text first.** If the path doesn't exist or the reference can't be
   fetched, say which one failed and stop — auditing a text you had to
   reconstruct reports violations the real text may not have.
2. **Name the destination** — chat reply, PR description, task or issue card,
   commit message, comment — because it decides which checks apply. When the
   invocation didn't say and the text doesn't make it obvious, audit it as a
   chat reply and say you assumed that.
3. **Hand it to the `audit` agent** with the text inline and the destination
   named. The agent holds the checklist; running it there keeps the audit from
   being coloured by the conversation that produced the draft.
4. **Relay the report as it comes back.** The agent's output is the answer —
   the verdict line, the numbered violations, the holes. Do not soften it, do
   not re-order it, do not add a paragraph agreeing with it, and do not
   quietly drop a violation you disagree with. When you think the agent is
   wrong about one, say so in one line after the report, with the reason.

Delivery: the report and nothing else. It opens with the verdict —
`N violations, M holes` or `clean` — and a clean text ends there, in one
line, with no summary of what it got right.

After the report, one line only: the exact `/concise:rewrite` invocation that
would fix what it found. Never rewrite the text here, never edit the file, and
never post a correction to the PR or the card. The fix is a separate call, and
it is the user's to make.
