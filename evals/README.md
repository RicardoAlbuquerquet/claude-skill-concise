# Evals

Twenty cases. Each gives the model the facts it would have discovered, sends
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

**Cost:** two API calls per case per run, so the default suite is 40 calls
and a few minutes; `RUNS=3` triples that. The judge is a model grading prose:
a FAIL is a signal to read the printed verdict, not a verdict by itself.

## Rule → case

The map is what makes an edited rule regress instead of silently drifting: if
you change a rule here, change the rubric that tests it.

| Rule (SKILL.md) | Case | Discriminates |
|---|---|---|
| Answer in the first sentence; no preamble | 01, and every other rubric | no |
| Completed work ≤5 lines, gate result | 02 | no |
| Investigation: finding + consequence | 03 | no |
| Never cut: caveat that changes what the user does | 04 | no |
| Recommendation carries its cost | 05 | no |
| The user's choice: options side by side + a recommendation | 06 | **yes** |
| A runnable command gets its own `bash` fence | 07 | **yes** |
| Overloaded opening: verdict first, support second | 08 | no |
| Commit message: title says what changes, body says why | 09 | **yes** |
| PR description: test steps, unverified named | 10 | no |
| Card: stands alone, narrow-panel structure | 11 | **yes** |
| Status update: only the delta | 12 | no |
| Bad news; the second question in a two-question message | 13 | no |
| Draw the shape; gloss by consequence | 14 | **yes** |
| Correcting yourself: no story of the mistake, no re-announcing | 15 | no |
| Commit lands inside the repo log's convention | 16 | no |
| Several deliverables read as a markdown list | 17 | **yes** |
| A list item stays an item, not a packed paragraph | 18 | **yes** |
| What waits on the reader sits apart from what informs them | 19 | **yes** |
| A name out of the code stays only if the reader will use it | 20 | **yes** |

**Measured 2026-08-19, on `claude-opus-5`: 18/18 with the skill, 11/18 at
baseline** (cases 19 and 20 measured separately: 3/3 with the skill against
1/3 and 0/3 without). So eight cases measure what the plugin adds; the other eleven
describe behaviour Claude Code already has by default, and would keep passing
if the rule vanished. They are not worthless — a default can regress, and a
rule that matches the default still documents it — but the suite's real
discriminating power is those seven, and a new case should aim to fail at
baseline.

The baseline run needs an isolated config, or it grades the skill against
itself: a global `CLAUDE.md` carrying the style, and the plugin's own hook,
both reach `claude -p`. Copy `~/.claude/.credentials.json` and a
plugin-less `settings.json` into a scratch directory and point
`CLAUDE_CONFIG_DIR` at it — an empty directory alone loses the login.

Not covered yet: plans, review comments, the expand-on-request valve, and the
PT-only wording rules. Those are the next cases to write.

**Case 18 was unstable at about 2 of 3 from the day it was written until
1.23.0, and the cause was not the rule it tests.** A dozen claims against a
≤5-line budget left no layout that satisfied both, so each run broke somewhere
different — a packed item, then stacked parentheticals, then the tail of the
list folded back into prose. Rewording the list rule moved the failure around
three times; fixing the budget row fixed the case. When a case fails
*differently* every run, look for two rules colliding before rewording either
of them.

A single-run suite line of 20/20 also means each case drew well once, not that
each rule holds. `RUNS=3` is what tells them apart.

A rubric can be miscalibrated as easily as a rule can drift. Case 10 asked a
single-change PR for a list of deliverables it did not have — the response
was right and the rubric was wrong. When a case fails, read the quoted
violation before assuming the skill moved.

## Adding one

A new case earns its place the same way a rule does: it encodes a real
failure the skill exists to prevent, and its rubric items are checkable
against a finished response. A rubric line the judge can't verify by quoting
the response is decoration. Run `BASELINE=1 RUNS=3 ONLY=<your case>` before
committing it — if it passes without the skill, it isn't testing the skill,
and one attempt is not enough to tell: case 19 passed its first baseline run
and then failed two of the next three.
