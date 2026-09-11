---
description: Draft a card that stands alone, and create it when a destination is named
argument-hint: "[what the card is about, and optionally where to create it]"
---

Produce one task/issue card. Read `${CLAUDE_PLUGIN_ROOT}/references/task.md`
first: it holds the rules, and this file only the procedure.

The subject is the text below. If it is empty, the subject is the most recent
problem or piece of work discussed in this conversation.

$ARGUMENTS

How:

1. Gather the exact values the card needs — path, command, error line,
   number, environment — from the conversation and the repo. A value the
   conversation didn't produce is a hole to name, never a guess.
2. When the subject is two cards ("and also"), say so and draft the first.
3. Write it as the reference says, then check the draft against it and fix
   what fails.

Delivery: title on the first line, body in a fenced block, ready to paste —
four backticks when the body carries a fence of its own, as repro commands
do.

When the invocation names a destination — a board, a repo, a project — and a
tool for it is available (MCP, `gh`), create it there after drafting:

1. **Search the destination for the symptom or subject first.** A likely
   match gets linked and reported instead of a duplicate created beside it.
2. **On GitHub, use the matching form under `.github/ISSUE_TEMPLATE/`**: its
   headers kept, filled in this register, "none" where there is nothing to
   say.
3. **Fields, not text**: discover what the destination offers — labels,
   members, statuses, priority — and put what the conversation settled into
   the fields. What nobody settled stays at the default, and you say so.
4. **Wire what's connected**: a named blocker or parent gets the real link —
   a relation or subtask on a board, a `#number` on GitHub.
5. Create, then report the id or link, the fields you set and the ones left
   at default.

Without a destination, deliver the draft alone and say where it can go.
Never create anywhere that wasn't named.
