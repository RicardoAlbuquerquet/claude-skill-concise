Write one plan for approval, following the "Recommendations, choices and
plans" section of the `concise` ruleset. Read `.cursor/rules/concise-full.mdc` first if the full
ruleset is absent from the context.

The subject is the text below. If it is empty, the subject is the work most
recently under discussion in this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

This drafts the *text* of a plan; plan mode and step one stay off until the
reader approves it — the reader is deciding whether to let you spend their
time, and that decision happens after they read it.

Rules of the plan:

- **It opens with what you will do**; what you found out getting here stays
  in your notes. The first line is step one and the last line is the last
  step.
- **Numbered steps you will actually run**, in order, each naming the file it
  touches or the command it runs. `src/auth/refresh.rs` and
  `npm test -- auth` are steps; "investigate the auth flow" is what you
  already did to write this.
- **One step, one action.** A step carrying "and then" is two steps, and the
  reader approving it needs to see which half is which.
- **The risk, named** — what could break, what is irreversible, what you are
  unsure of and would find out only by starting. The risk section is what
  shows the plan was stress-tested. Anything that rewrites shared state — a
  force-push, a migration, a deleted branch — gets its own line, apart from
  the step it belongs to.
- **What it leaves out**, when a reader could reasonably expect it in scope.
- **What you need from them before step 1** — an access, a decision, a value
  you lack — goes in its own block, apart from what merely informs them.
- **Ground it before you write it.** Read the files the steps name. A step
  pointing at a function that is missing is found by the reader, after they
  approved it. Say which steps you left unverified.
- **Draw it when it branches** — a plan with three or more hops, a retry, or
  a rollback path gets the ASCII in a fenced block, arrows labelled.

Check the draft against the rules above and fix what fails before delivering.

Delivery: the plan as prose in the conversation, since it is read here to be
approved. Put it in a fenced block only when the invocation says it goes
somewhere else — a card, a doc, a message — and pick that surface's register
from the ruleset. After it, only what you need from the reader.

Draft only: step 1 starts on the reader's approval, given in a later turn.
