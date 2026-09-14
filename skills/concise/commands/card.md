---
description: Draft a card that stands alone, and create it when a destination is named
argument-hint: "[what the card is about, and optionally where to create it]"
---

Produce one task or issue card. The rules live in
`${CLAUDE_PLUGIN_ROOT}/references/task.md` — read it first.

The subject is the text below; empty, it is the most recent problem or piece
of work in this conversation:

$ARGUMENTS

## Beliefs

- The card is read by someone who arrives from outside this conversation.
- A value the conversation left out is a hole, and the card names it as one.
- Only a destination named in the invocation is permission to create.

## Desires

- The card stands on its own, and lands where its readers already look.

## Intentions

- Gather the exact values from the conversation and the repo — path, command,
  error line, number, environment — and name what is missing as a hole.
- Say so and draft the first when the subject is two cards.
- Write it as the reference says, then check the draft against it.
- Deliver the title on the first line and the body in a fenced block, ready to
  paste — four backticks when the body carries a fence, as repro commands do.
- With no destination named, deliver the draft alone and say where it can go.

With a destination named and a tool for it reachable (MCP, `gh`), create it
there after drafting:

- Search the destination first: a likely match gets linked and reported, and
  the card stays a draft.
- On GitHub, fill the matching form under `.github/ISSUE_TEMPLATE/`, headers
  kept and "none" where a section is empty.
- Put what the conversation settled into the destination's own fields —
  labels, members, status, priority. What stayed unsettled keeps the default.
- Wire a named blocker or parent as a real link: a relation or subtask on a
  board, a `#number` on GitHub.
- Report the id or link, the fields you set and the ones left at default.
