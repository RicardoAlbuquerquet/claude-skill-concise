---
description: Report the concise violations in a draft — quote, rule, fix — the rewrite stays separate
argument-hint: "[text, a file path, a PR or issue URL — empty audits your previous reply]"
---

Audit one finished text against the `concise` checklist and report what a
rewrite would have to fix. This reports; the rewrite is `/concise:rewrite`.

Resolve the target from the argument below, in this order: a path to a file
that exists is read and audited; a PR or issue reference a tool can reach
(`gh`, an MCP board) has its body fetched and audited — the body, in place of
the diff; anything else is the text itself; empty targets your own previous
response in this conversation.

$ARGUMENTS

How:

1. **Get the text first.** If the path is missing or the reference is out of
   reach, say which one failed and stop — a reconstructed text carries
   violations of its own.
2. **Name the destination** — chat reply, PR description, task or issue card,
   commit message, comment — because it decides which checks apply. With the
   destination unsaid and unclear from the text, audit it as a chat reply and
   say you assumed that.
3. **Hand it to the `audit` agent** with the text inline and the destination
   named. The agent holds the checklist; running it there keeps the audit
   apart from the conversation that produced the draft.
4. **Relay the report as it comes back.** The agent's output is the answer —
   the verdict line, the numbered violations, the holes — whole and in its
   order, every violation included. When you think the agent is wrong about
   one, say so in one line after the report, with the reason.

Delivery: the report alone. It opens with the verdict — `N violations, M
holes` or `clean` — and a clean text ends there, in one line.

After the report, one line only: the exact `/concise:rewrite` invocation that
would fix what it found. The rewrite, the file edit and the correction on the
PR or the card are separate calls, and the user's to make.
