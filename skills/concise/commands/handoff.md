---
description: Hand the work over — the complete state, every standing caveat back in full, the traps, and the exact command that resumes it
argument-hint: "[who picks it up, or what part of the work — optional]"
---

Write one handoff, following the "Never cut" list of the `concise` ruleset —
in particular the clause that says a standing caveat comes back **in full**
when you hand the work over. Invoke the skill first if the full ruleset is not
already in context.

The argument below says who picks this up — a person, your future self, the
next session — or narrows it to one part of the work. Empty, write it for
someone competent who was not in this conversation.

$ARGUMENTS

A handoff is the opposite of a status update, and confusing the two is the
whole failure mode. A status update is the delta since the last one and drops
what the reader already has. A handoff assumes the reader has **nothing**: no
memory of this conversation, no caveat you stated three messages ago, no idea
which of the four things you touched is finished. Everything a status update
earns the right to leave out, a handoff has to put back.

How:

1. **Read the state, don't recall it.** `git status`, `git log --oneline` on
   the branch and against its base, `gh pr list --head <branch>` or the
   tracker for what is open. What you remember doing and what is actually
   committed diverge exactly where a handoff hurts most.
2. **Where it stands, in exact values**: the branch, the last commit's short
   sha, the PR number and its state, the card or issue. Never "on the feature
   branch" — the name.
3. **Done against left**, as two separated things. Done means done and
   verified; something you wrote but never ran is not done, and saying which
   is the point. What is left carries its done criterion, so the reader knows
   when to stop.
4. **Every standing caveat, in full.** The constraint you stated once and then
   referred to by a clause, the assumption the work rests on, the thing you
   decided not to handle. A handoff is where "as I mentioned" costs the reader
   an hour, because they were not there when you mentioned it.
5. **The traps**, which is the part only you can write: what looks finished
   and is not, what the tests do not cover, the command that has to run in a
   particular order, the state you left dirty on purpose. If nothing surprised
   you, say that instead of inventing one.
6. **What was decided and why**, one line each — enough that the reader does
   not reopen a settled question, or silently undo it. An option you rejected
   gets its line here rather than a section.
7. **The exact command that resumes the work** — the checkout, the install,
   the test run — in a runnable block, in the shell the reader uses.
8. **What is blocked and on whom**, with what stalls if it does not come.

Before delivering, audit the draft yourself — nothing that only makes sense to
someone who read this conversation, every caveat back in full rather than
referenced, done and left kept apart, exact values instead of descriptions of
them, no process narration, and the resume command actually runnable — and fix
what fails. Deliver only the clean version.

Delivery: as prose when the handoff stays in this conversation; in a fenced
block when it goes into a card, a document or a message, with four backticks
when it carries a fence of its own — the resume command does. Headers earn
their place here the way they do anywhere: the state, what is left, the traps
and the resume command are different jobs, and a handoff long enough to have
all four is long enough to have them named.

Nothing after it except what you could not establish from the repo or the
conversation, one line each, opening with **Unknown:**.

Draft only: never post it, never open or move anything, even when the argument
names a person or a destination a tool can reach. Naming who picks it up says
where it goes; it is not permission to send it.
