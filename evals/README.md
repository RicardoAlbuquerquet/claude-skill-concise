# Evals

Six cases, each derived from a pair in
[`examples/before-after.md`](../examples/before-after.md). A case gives the
model the facts it would have discovered, sends the prompt, and grades the
response against a rubric of checkable style properties — answer in the first
sentence, exact values kept, cost stated, caveat surviving a "confirm in one
word".

```bash
bash evals/run.sh
```

`SKILL=respostas-curtas` runs the PT port (the rubrics check structure, not
language, so they grade either). `ONLY=03` runs a single case by filename
fragment. `CLAUDE_BIN` swaps the CLI binary, which is how the harness itself
is tested without spending API calls.

**Cost and noise, before you run it:** each case is two `claude -p` calls —
one to answer, one to judge — so the full suite is 12 calls and a few minutes.
The judge is a model grading prose: a FAIL is a signal to read the printed
verdict, not a verdict by itself, and a run is not perfectly reproducible. Use
it to compare a SKILL.md edit against `main`, not as a gate that must be
green.

A new case earns its place the same way a rule does: it encodes a real failure
the skill exists to prevent, and its rubric items are checkable against a
finished response. A rubric line the judge can't verify by quoting the
response is decoration.
