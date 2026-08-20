---
description: Draft the plan you are proposing — the numbered steps you will run, the risk named, what it leaves out. Text only; it runs nothing
argument-hint: [what the plan is for — empty uses the work under discussion]
---

Write one plan for approval, following the "Plans you propose" section of the
`concise` ruleset. Invoke the skill first if the full ruleset is not already
in context.

The subject is the text below. If it is empty, the subject is the work most
recently under discussion in this conversation.

$ARGUMENTS

This drafts the *text* of a plan. It does not enter plan mode, and it does not
execute a step — the reader is deciding whether to let you spend their time,
and that decision happens after they read it.

Rules of the plan:

- **It opens with what you will do**, not with what you found out getting
  here. No restating the request before the steps, no summary of the plan
  after them.
- **Numbered steps you will actually run**, in order, each naming the file it
  touches or the command it runs. `src/auth/refresh.rs` and
  `npm test -- auth` are steps; "investigate the auth flow" is what you
  already did to write this.
- **One step, one action.** A step carrying "and then" is two steps, and the
  reader approving it can't tell which half you'll get wrong.
- **The risk, named** — what could break, what is irreversible, what you are
  unsure of and would find out only by starting. A plan with no risk section
  reads as a plan nobody stress-tested. Anything that rewrites shared state —
  a force-push, a migration, a deleted branch — is called out as its own line,
  not folded into a step.
- **What it leaves out**, when a reader could reasonably expect it in scope.
- **What you need from them before step 1** — an access, a decision, a value
  you don't have — goes in its own block, apart from what merely informs them.
- **Ground it before you write it.** Read the files the steps name. A step
  pointing at a function that isn't there is found by the reader, after they
  approved it. Say which steps you could not verify.
- **Draw it when it branches** — a plan with three or more hops, a retry, or
  a rollback path gets the ASCII in a fenced block, arrows labelled.

Before delivering, audit the draft yourself — first line says what you will
do, every step names a file or a command, risk present, out-of-scope stated,
nothing that is exploration wearing a step number — and fix what fails.
Deliver only the clean version.

Delivery: the plan as prose in the conversation, since it is read here to be
approved. Put it in a fenced block only when the invocation says it goes
somewhere else — a card, a doc, a message — and pick that surface's register
from the ruleset. Nothing after it except what you need from the reader.

Draft only: do not start step 1, and do not treat approval of the plan as
having been given inside the same turn that proposed it.
