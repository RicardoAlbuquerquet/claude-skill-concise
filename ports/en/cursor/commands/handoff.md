Write one handoff, following the "Always keep" list of the `concise` ruleset —
in particular the clause that says a standing caveat comes back **in full**
when you hand the work over. Read `.cursor/rules/concise-full.mdc` first if the full ruleset is
absent from the context.

The argument says who picks this up — a person, your future self, the next
session — or narrows it to one part of the work. Empty, write it for someone
competent who was away from this conversation:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- The reader starts from zero, so everything a status update earns the right
  to drop, a handoff puts back.
- What you remember doing and what is actually committed diverge exactly where
  a handoff hurts most.
- "As I mentioned" costs the reader an hour, because they were away when you
  mentioned it.
- Naming who picks it up says where it goes; sending waits for the user.

## Desires

- The reader resumes without asking you anything.

## Intentions

- Read the state from the repo: `git status`, `git log --oneline` on the
  branch and against its base, `gh pr list --head <branch>` or the tracker.
- Say where it stands in exact values: the branch, the last short sha, the PR
  number and its state, the card — the name itself, not "the feature branch".
- Separate done from left. Done means done and verified; something written and
  left unrun is open. What is left carries its done criterion.
- Restate every standing caveat in full, with the assumptions the work rests
  on and what you decided to leave alone.
- Write the traps, the part only you can write: what looks finished and is
  open, what the tests leave uncovered, the command that needs a particular
  order, the state you left dirty on purpose. All listed already, say so.
- Give what was decided and why, one line each, a rejected option included.
- Give the exact command that resumes the work — checkout, install, test run —
  in a runnable block, in the reader's shell.
- Say what is blocked and on whom, with what stalls meanwhile.
- Check the draft, then deliver: prose when it stays here; a fenced block for
  a card, a document or a message, four backticks since the resume command is
  a fence. Headers earn their place — state, what is left, traps and resume
  command are different jobs.
- Close with one line per thing the repo and the conversation left open, each
  opening with **Unknown:**.
