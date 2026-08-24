# Evals

Thirty-one cases, eight at a time. Each gives the model the facts it would have discovered, sends
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
| `CORE=1` | judges the ~45-line core the hook injects, not the full skill |
| `BASELINE=1` | no style at all — see below |
| `RUNS=3` | three attempts per case; anything short of all-pass reports `FLAKY` |
| `MODEL=claude-sonnet-5` | pins the model, so two runs are comparable |
| `JOBS=1` | serial, for a rate limit or a log you want to read as it goes |
| `JUDGE_MODEL=` | judges with `MODEL` instead of the fast default |
| `ONLY=07` | a single case, by filename fragment |
| `CLAUDE_BIN=./stub` | swaps the CLI — how the harness itself is tested, free |

**`BASELINE=1` is the one that tells you whether a case is worth having.** It
runs the same prompts with no style attached. A case that passes at baseline
measures the model's own habits, not the rules, and proves nothing when it
passes with the skill. Its exit code is always 0 — the pass count is the
signal, and a *low* one is the good news.

The style and the facts reach the CLI through `--append-system-prompt-file`,
  not the command line. That is not a detail: Windows caps a command line at
32767 characters, the PT skill is already past 31 KB, and the full PT run died
at case 17 with "Argument list too long" before the switch. A CLI old enough
to lack the flag still works and says so.

**Cost:** two API calls per case per run, so the default suite is 62 calls
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
| A fence is tagged for the shell the reader will paste into | 21 | **yes** |
| The outcome, not the itinerary of the work | 22 | weakly |
| A table column with one repeated value is not a column | 23 | **yes** |
| The reader's choice still gets a recommendation, at the end of a long report | 24 | weakly |
| A note on a card is the summary of the summary | 25 | not measured |
| PR title: the area first, the state after the merge | 26 | not measured |
| Drawing craft: one glyph set, nothing wraps, labels hang off their box | 27 | not measured |
| One hanging note, and it sits on the finding | 28 | not measured |
| One gloss per response; the rest of the terms become what they do | 29 | not measured |
| One budget for the turn: a block that leaves the reader nothing gets a line, or goes | 30 | not measured |
| PR description inside a screenful, and the cut comes out of what repeats | 31 | not measured |

**Measured 2026-08-20, on `claude-opus-5`: all 21 cases pass three times each
with the skill.** The baseline figure is older and narrower: 11 of the first 18
passed with no style at all, on 2026-08-19, and cases 19, 20 and 21 were
measured against baseline one at a time, at 1/3, 0/3 and 1/3. So ten cases
measure what the plugin adds; the other eleven describe behaviour Claude Code
already has by default, and would keep passing if the rule vanished. They are
not worthless — a default can regress, and a rule that matches the default
still documents it — but the suite's discriminating power is those ten, and a
new case should aim to fail at baseline.

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

A single-run suite line of 21/21 also means each case drew well once, not that
each rule holds. `RUNS=3` is what tells them apart. **The first full sweep with
it — 2026-08-20, on `claude-opus-5` — has all 21 cases holding three times
each**, but only after it found two real defects that single runs had hidden
for releases: case 07's rubric hard-coded a `bash` fence while its facts named
no platform, so it was grading the machine the suite ran on; and case 18 kept
shortening a path to its basename, one run in three.

Two lessons from that sweep, both cheaper to read than to rediscover. A case
that depends on the reader's platform has to state the platform in its facts.
And a case that fails while the session limit is being hit is not a finding —
case 14 reported 2 of 3 for that reason alone, and passes on re-measurement.

**Case 08 was unstable for a different reason: its rubric graded punctuation.**
It failed any opening that put an em dash after "yes" and let the support
trail, which reads the same as a full stop. It now checks what the rule is
actually for — the verdict arrives before any support, and the caveat gets a
sentence of its own — and passes 3 of 3 with the skill and 3 of 3 at baseline,
measuring what the map already listed it as: not a discriminator.

A rubric can be miscalibrated as easily as a rule can drift. Case 10 asked a
single-change PR for a list of deliverables it did not have — the response
was right and the rubric was wrong. When a case fails, read the quoted
violation before assuming the skill moved.

**Case 10 was flaky at 2 of 3 for the same reason, and it predates the rule
that looked guilty.** "The description ends with a test step containing the
exact command" was read literally: any caveat after the command — the
unverified part, what would prove it broke — failed a response the ruleset
had asked for. Measured against the pre-change skill before touching
anything, which is what said the ceiling added in 1.49.0 was not the cause.
The item now asks that the test steps be the last *section*, and the case
passes 3 of 3.

Case 31 cost four rewrites, and three of them were the rubric rather than the
skill. Two lessons in it. A case whose facts restate work that really landed
in this repository gets contradicted by the session's own git context — the
model reported the branch as already merged, correctly — so its facts now
name a project that has nothing to do with the checkout. And an item that
grades a shape ("one line, not a story") has to say what makes it fail:
counting sentences is checkable, "recounting your trip" is a judgement call
the judge will make differently every run.

## Adding one

A new case earns its place the same way a rule does: it encodes a real
failure the skill exists to prevent, and its rubric items are checkable
against a finished response. A rubric line the judge can't verify by quoting
the response is decoration. Run `BASELINE=1 RUNS=3 ONLY=<your case>` before
committing it — if it passes without the skill, it isn't testing the skill,
and one attempt is not enough to tell: case 19 passed its first baseline run
and then failed two of the next three.
