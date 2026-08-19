# Evals

Eighteen cases. Each gives the model the facts it would have discovered, sends
a prompt, and grades the response against a rubric of checkable properties —
answer in the first sentence, exact values kept, cost stated, bad news not
softened.

```bash
bash evals/run.sh
```

On Windows, run it from **Git Bash** — typed into PowerShell, `bash` is the
WSL stub, which answers that no distribution is installed. From PowerShell
the long form works:

```powershell
& "C:\Program Files\Git\bin\bash.exe" evals/run.sh
```

## What you can vary

| Variable | What it does |
|---|---|
| `SKILL=respostas-curtas` | runs the PT port (rubrics check structure, not language) |
| `CORE=1` | judges the ~20-line core the hook injects, not the full skill |
| `BASELINE=1` | no style at all — see below |
| `RUNS=3` | three attempts per case; anything short of all-pass reports `FLAKY` |
| `MODEL=claude-sonnet-5` | pins the model, so two runs are comparable |
| `ONLY=07` | a single case, by filename fragment |
| `CLAUDE_BIN=./stub` | swaps the CLI — how the harness itself is tested, free |

**`BASELINE=1` is the one that tells you whether a case is worth having.** It
runs the same prompts with no style attached. A case that passes at baseline
measures the model's own habits, not the rules, and proves nothing when it
passes with the skill. Its exit code is always 0 — the pass count is the
signal, and a *low* one is the good news.

**Cost:** two API calls per case per run, so the default suite is 36 calls
and a few minutes; `RUNS=3` triples that. The judge is a model grading prose:
a FAIL is a signal to read the printed verdict, not a verdict by itself.

## Rule → case

The map is what makes an edited rule regress instead of silently drifting: if
you change a rule here, change the rubric that tests it.

| Rule (SKILL.md) | Case |
|---|---|
| Answer in the first sentence; no preamble | 01, and every other rubric |
| Completed work ≤5 lines, gate result | 02 |
| Investigation: finding + consequence | 03 |
| Never cut: caveat that changes what the user does | 04 |
| Recommendation carries its cost | 05 |
| The user's choice: options side by side + a recommendation | 06 |
| A runnable command gets its own `bash` fence | 07 |
| Overloaded opening: verdict first, support second | 08 |
| Commit message: verb-first title ≤72, body says why | 09 |
| PR description: test steps, unverified named | 10 |
| Card: stands alone, narrow-panel structure | 11 |
| Status update: only the delta | 12 |
| Bad news; the second question in a two-question message | 13 |
| Draw the shape; gloss by consequence | 14 |
| Correcting yourself: no story of the mistake, no re-announcing | 15 |
| Commit lands inside the repo log's convention | 16 |
| Several deliverables read as a markdown list | 17 |
| A list item stays an item, not a packed paragraph | 18 |

Not covered yet: plans, review comments, the expand-on-request valve, and the
PT-only wording rules. Those are the next cases to write.

A rubric can be miscalibrated as easily as a rule can drift. Case 10 asked a
single-change PR for a list of deliverables it did not have — the response
was right and the rubric was wrong. When a case fails, read the quoted
violation before assuming the skill moved.

## Adding one

A new case earns its place the same way a rule does: it encodes a real
failure the skill exists to prevent, and its rubric items are checkable
against a finished response. A rubric line the judge can't verify by quoting
the response is decoration. Run `BASELINE=1 ONLY=<your case>` before
committing it — if it passes without the skill, it isn't testing the skill.
