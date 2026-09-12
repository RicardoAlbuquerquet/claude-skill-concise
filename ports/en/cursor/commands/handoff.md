Write one handoff, following the "Always keep" list of the `concise` ruleset —
in particular the clause that says a standing caveat comes back **in full**
when you hand the work over. Read `.cursor/rules/concise-full.mdc` first if the full ruleset is
absent from the context.

The argument below says who picks this up — a person, your future self, the
next session — or narrows it to one part of the work. Empty, write it for
someone competent who was away from this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

A handoff is the opposite of a status update, and telling the two apart is
the whole job. A status update is the delta since the last one and drops what
the reader already has. A handoff assumes the reader starts from zero: the
conversation, the caveat you stated three messages ago, and which of the four
things you touched is finished all have to be in it. Everything a status
update earns the right to leave out, a handoff puts back.

How:

1. **Read the state from the repo**: `git status`, `git log --oneline` on the
   branch and against its base, `gh pr list --head <branch>` or the tracker
   for what is open. What you remember doing and what is actually committed
   diverge exactly where a handoff hurts most.
2. **Where it stands, in exact values**: the branch, the last commit's short
   sha, the PR number and its state, the card or issue — the name itself, in
   place of "the feature branch".
3. **Done against left**, as two separated things. Done means done and
   verified; something you wrote and left unrun is still open, and saying
   which is the point. What is left carries its done criterion, so the reader
   knows when to stop.
4. **Every standing caveat, in full.** The constraint you stated once and then
   referred to by a clause, the assumption the work rests on, the thing you
   decided to leave alone. A handoff is where "as I mentioned" costs the
   reader an hour, because they were away when you mentioned it.
5. **The traps**, which is the part only you can write: what looks finished
   and is still open, what the tests leave uncovered, the command that has to
   run in a particular order, the state you left dirty on purpose. When every
   trap is already listed, say so.
6. **What was decided and why**, one line each — enough that the reader keeps
   a settled question closed and the decision in place. An option you
   rejected gets its line here rather than a section.
7. **The exact command that resumes the work** — the checkout, the install,
   the test run — in a runnable block, in the shell the reader uses.
8. **What is blocked and on whom**, with what stalls while it is missing.

Check the draft against the rules above and fix what fails before delivering.

Delivery: as prose when the handoff stays in this conversation; in a fenced
block when it goes into a card, a document or a message, with four backticks
when it carries a fence of its own — the resume command does. Headers earn
their place here the way they do anywhere: the state, what is left, the traps
and the resume command are different jobs, and a handoff long enough to have
all four is long enough to have them named.

After it, only what the repo and the conversation left open, one line each,
opening with **Unknown:**.

Draft only: it stays in the conversation, even when the argument names a
person or a destination a tool can reach. Naming who picks it up says where
it goes, and sending waits for the user's word.
