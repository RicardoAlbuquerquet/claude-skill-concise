Write one plan for approval, following the "Recommendations, choices and
plans" section of the `concise` ruleset. Read `.cursor/rules/concise-full.mdc` first if the full
ruleset is absent from the context.

The subject is the text below; empty, it is the work most recently under
discussion:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- The reader is deciding whether to let you spend their time, and decides
  after reading — plan mode and step one stay off until they approve.
- What you found out getting here belongs in your notes.
- A step carrying "and then" is two steps.
- A step pointing at a function that is missing gets found by the reader,
  after they approved it.

## Desires

- The reader approves knowing the risk, the cost and what is out of scope.

## Intentions

- Open on step one and close on the last step.
- Number the steps you will actually run, each naming the file it touches or
  the command it runs: `src/auth/refresh.rs` and `npm test -- auth` are steps.
- Name the risk — what could break, what is irreversible, what you would learn
  only by starting. Anything that rewrites shared state, a force-push, a
  migration, a deleted branch, gets its own line.
- Say what the plan leaves out, where the reader could expect it in scope.
- Put what you need before step 1 — an access, a decision, a value you lack —
  in its own block, apart from what merely informs them.
- Ground it first by reading the files the steps name, and say which steps you
  left unverified.
- Draw it when it branches: three or more hops, a retry or a rollback path get
  ASCII in a fenced block, arrows labelled.
- Check the draft against these rules, then deliver it as prose here, since it
  is read here to be approved; a fenced block in that surface's register only
  when the invocation sends it elsewhere.
- Draft only: step 1 starts on the reader's approval, in a later turn.
