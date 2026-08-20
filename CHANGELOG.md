# Changelog

Every `version` bump in the two ports gets an entry here. The number is what
propagates a release: the self-update hook and `claude plugin update` both
compare versions, so a change without a bump reaches nobody — and a bump
without an entry tells nobody what it brought.

## 1.25.0 — 2026-08-20

- **The commit command still promised a verb-first title**, in its own
  description and in four places across the two READMEs — the rule 1.18.1
  replaced with "the log decides the shape, never the substance". The command
  body had been right since then; the shop window had not, and this repo's own
  log is declarative, so the promise contradicted the product.
- **The marketplace card had fallen behind the plugin's own description** and
  nothing was checking it: the sentence naming what the style governs — chat
  replies, plans, commits, PRs, cards, review comments — reached anyone
  reading `plugin.json` and nobody browsing the marketplace. Fixed, and
  `check-parity.sh` now compares the two, so it cannot drift again quietly.
- The READMEs said the injected core is ~20 lines. It is 36.
- **The fence rule shipped in 1.24.0 had no answer for "platform unknown", and
  case 07 caught it** — the suite scored a `powershell` fence as a violation
  because its rubric hard-coded `bash` while its facts named no platform, so
  the case was really grading the machine the suite happened to run on. Two
  fixes: the rule now defaults to `bash` when neither the hook nor the
  environment says otherwise, because guessing `powershell` at a reader who
  turns out to be on Linux costs more than the reverse; and cases 07 and 17
  state the platform in their facts, the way case 21 already did.
- **A path is the whole path the first time it appears.** The name rule from
  1.22.0 was still leaking into paths at about one run in three, shortening
  `web/src/modules/estoque/movimento/movimento-pdf.ts` to the bare filename.
  Saying "a file path is a value" in the cut list was not enough; the rule now
  sits in the exact-values entry, where what counts as the value is decided,
  and says the basename is a different and weaker one. Later mentions may
  still be short.
- **Three green eval checks on every PR were measuring nothing.** Without
  `ANTHROPIC_API_KEY` the job ran its skip branch and reported `pass`, which
  reads as "the rules were checked" on a run that never called the model — a
  green check that proves nothing is worse than no check. A gate job now turns
  the secret into an output, so the eval jobs report `skipped` instead, and
  say why in the run summary.
- The audit agent had not kept up with two rules it can check: a fence tagged
  for the wrong shell or chaining two commands, and a path shortened to its
  basename on first mention.
- **The opt-in `stop-audit` extra was grading responses against a copy of the
  rules, not the rules.** Four lines written by hand inside the script, frozen
  wherever they were when it shipped — an auditor holding last month's
  checklist is worse than none. It reads `hooks/core.md` now, with
  `CONCISE_CORE` for installs where the plugin root is not in the hook's
  environment and the user's own override winning over both. Four tests cover
  the wiring, which had none: the core reaching the prompt, a violation
  becoming a warning, `OK` staying silent, and a missing core falling back
  instead of dying.
- **A name that is the decision stays, and the first full PT run since 1.21.0
  is what found that.** The Portuguese port dropped the route it had called —
  reporting "it calls a different route depending on the type", which leaves
  the reader unable to say which decision was taken, let alone whether it was
  right. The rule already spared the knob you ask someone to turn; it now
  spares the name that *is* the decision you are reporting.
- **Writing a case's own vocabulary into a rule contaminates the case.** The
  first draft of that clause used the route names from case 19. Portuguese
  went to 3 of 3 and English fell to 1 of 3 — the model optimised for that one
  rubric item and compressed the false premise and the gate warnings out of
  the answer. Replaced with a neutral example, both ports hold. Case 19 in
  Portuguese is still the closest to the edge in the suite: one failure in
  nine attempts.
- **The eval harness had grown a ceiling it was about to hit everywhere.** It
  handed the whole skill to the CLI on the command line, which Windows caps at
  32767 characters; the PT skill reached 31 KB and the full PT run died at
  case 17 with "Argument list too long" — the first run of that suite since
  1.21.0. It uses `--append-system-prompt-file` now, so the limit is gone
  rather than postponed, with a warning and the old path for a CLI too old to
  have the flag.
- `CONTRIBUTING.md` told contributors to run the evals and compare, without
  saying that one run per case is not evidence. It now says to use `RUNS=3`,
  and why: the suite read 21/21 for weeks while two cases were failing about
  one run in three.
- `evals/README.md` claimed 18/18 against a suite of 21, and said the
  discriminating power was "those seven" two lines under a sentence counting
  ten.
- **The first full `RUNS=3` sweep is what surfaced both**, and it is the
  headline of this release: all 21 cases now hold three times each, in place
  of a 21/21 line that meant each case drew well once. Cases 10 and 14 looked
  unstable in that sweep and were not — 14 had hit the session limit, and 10
  passed 3 of 3 on re-measurement.

## 1.24.0 — 2026-08-20

- **The session hook now says which machine this is, and the fence tag follows
  it.** A command block tagged for the wrong shell does not run: `&&` is a
  parser error in Windows PowerShell 5.1 rather than a warning, and `bash`
  typed there reaches the WSL stub instead of Git Bash. `inject-core.sh`
  detects the platform through `uname` and appends one line naming it —
  `powershell` fences on Windows, `bash` on macOS and Linux, with a note on
  macOS that BSD `sed`, `date` and `readlink` take different flags from GNU.
- The rule sits in the fence bullet too, for the output-style path that has no
  hook: the tag names the shell the reader will paste into, not the one you
  ran the command in, and two steps are two fences rather than a chain.
- `CONCISE_OS=windows|macos|linux` overrides detection, for a Windows machine
  whose terminal is Git Bash or WSL. Seven new hook tests cover the branches,
  including a `hooks.json` with no platform strings, which prints nothing and
  still exits 0.
- Case 21 measures it: 3 of 3 with the skill in both ports, 1 of 3 without.
- The rule→case map said eight discriminating cases where the column had nine.

## 1.23.0 — 2026-08-20

- **A completed-work report stops buying its ≤5 lines by packing.** The budget
  row now says the item count follows the work rather than the number, and
  names the shortcut it was licensing: folding the tail of the list — the
  dependency, the docs, the smaller file — back into a sentence to land on
  five.
- That was the real cause of case 18 being unstable at about 2 of 3 since the
  day it was written, which 1.22.0 recorded as unfixed. The rule it tests was
  never the problem: a dozen claims against a ≤5-line budget left no layout
  that satisfied both, so each run broke somewhere different — four claims in
  one item, then three parentheticals stacked, then prose. Rewording the list
  rule three times only moved the failure. The case now holds 3 of 3 in both
  ports and still fails at baseline.
- **Grouping by file is what forces the packing**, so the list rule says the
  grouping is what gives: one subject with four claims hanging off it is four
  items, or a table with the subject in the first column.
- A drawing is no exemption from the name rule shipped in 1.22.0. A box
  labelled with a table's name teaches nothing; the same box labelled "daily
  copy" is the diagram doing its job.
- Case 18's rubric demanded a list where the skill offers a list *or* a table
  for that content. It accepts either now, and only prose fails — the same
  miscalibration case 10 had.
- **The overloaded-opening test described a failure it could not detect.** It
  asked whether the reader crosses a comma chain before reaching the answer;
  the failure that actually happens is "Yes" followed by three reasons in one
  breath, where the answer comes first and the chain comes after. The test is
  now mechanical: put a full stop after the verdict, and if the sentence was
  still going it was overloaded. The headline rule says it too — the answer
  goes in the first sentence, and nothing else goes in there with it.
- Case 08 was grading punctuation. An em dash after "yes" with the support
  trailing reads the same as a full stop; what the rule protects is the caveat
  getting a sentence of its own. Recalibrated to that, it passes 3 of 3 — and
  3 of 3 at baseline as well, which confirms in measurement what the rule→case
  map already claimed: case 08 documents what Claude Code does by default
  rather than what the plugin adds.

## 1.22.0 — 2026-08-19

- **A name lifted out of the code stays only if you can say what the reader
  does with it.** An investigation came back carrying the job class, the
  table, the repository method and the constant, one per sentence — and the
  person who asked why a total was wrong will open none of them. Replaced by
  the behaviour they stood for, those sentences got shorter and clearer at the
  same time, which is why this cut is worth a pass of its own.
- It lands in three places because it collides with two existing rules.
  **Never cut** now says the exact value is the value, not the name of the
  constant holding it; **Always cut** carries the item; and the final
  checklist has a third step for it. Written once, in the audience section,
  the rule lost every run — the same placement lesson as 1.20.0 and 1.21.0.
- The setting you are asking the reader to approve changing is the exception:
  name it, because approving the change means approving that specific thing.
  Shas, paths, branches, versions and numbers they will check are untouched.
- Case 20 measures it: 3 of 3 with the skill, 0 of 3 without — the cleanest
  discriminator in the suite. Case 19's rubric used to demand the error
  constant in the response; it no longer does.
- Two boundaries were added because the first draft over-cut in measurement: a
  file path stays whole, directory and all, and a library version stays even
  while the name beside it goes. Both were caught by case 18 dropping them.
- **Case 18 is flaky at about 2 of 3, and was before this release** — on its
  own rule, the packed list item. Checked against the 1.21.0 skill to be sure
  this change was not the cause. The rule behind it is not fixed here; the
  finding is recorded in `evals/README.md`.

## 1.21.0 — 2026-08-19

- **What waits on the reader never shares a block with what merely informs
  them.** A delivery report put one open question — an API change only the
  reader can authorise — in the same list as two decisions already made and
  committed, under a heading that joined the jobs with "or": "three things
  to decide or know". The reader had to hunt for the part needing an
  answer. Splitting it is the rule; a heading with "or" in it is the tell.
- The completed-work budget now says it too, which is where the shape of
  the answer is decided — the same placement lesson as 1.20.0.
- Case 19 measures it: 3 of 3 with the skill, 1 of 3 without.

## 1.20.0 — 2026-08-19

- **A list item is an item, not a paragraph with a dash.** One item carries
  one claim, in one line or two; four helpers with a gloss each are four
  items, not one line holding four parentheses. The failure hid in plain
  sight because it looks like a list — the rule the semicolon ban already
  covered in prose, escaping through the format that promised a scan.
- **First baseline run, in an isolated config: 11 of the 18 cases pass with
  no style at all.** Seven measure what the plugin adds; the rest describe
  what Claude Code already does. The suite says 18/18 with the skill, and
  that number was hiding how much of it the skill is responsible for — the
  rule → case map now carries the answer per case.
- Where the rule sits turned out to matter more than how it was worded.
  Stated only as a prohibition, it held in 1 of 3 runs; moved to where a
  list is decided — the definition of what a list is for — it held in 3 of
  3. Case 18 is what measured both.

## 1.19.0 — 2026-08-19

- **A PR description opens with two sentences: what it does, and what was
  wrong without it.** The ruleset asked for the change and never for the
  symptom, so a reviewer got "fixes the fence handling" where they needed
  "the export truncated its own output whenever the description contained a
  code block". Knowing the symptom is what lets someone judge whether the
  fix is the right one. The second sentence goes when the first already
  carries the problem.
- `/concise:pr` takes the problem from the commits, the linked card or the
  branch name — never invented — and the audit agent checks the opening.
- Cases 10 and 17 check it, so the rule regresses instead of drifting.

## 1.18.1 — 2026-08-19

- **The log decides the shape of a title, never its substance.** Adding the
  convention rule created a contradiction with "verb first", and the first
  real eval run found it: this repo's own titles are declarative ("A
  correção entra no núcleo"), so the two rules could not both hold. What a
  title must do — name what changes, inside 72 characters, no AI credit —
  stands; imperative or declarative is the log's call. A bare label
  ("Invoice filter") still fails.
- First real run of the suite, judge and all. It found two things, both
  ours: a miscalibrated rubric (case 10 demanded a deliverables list from a
  single-change PR — the list check moved to case 17) and the title
  contradiction above.

## 1.18.0 — 2026-08-19

Commit messages learn the repo they land in, and two PR fixes from a
real screenshot.

- **The repo's log is the commit convention.** A `fix(scope):` prefix, a
  ticket code, another language — whatever the recent titles do
  consistently, the new message does too, and a commitlint config makes
  the prefix mandatory. `/concise:commit` reads `git log --oneline -15`
  and the commitlint config before writing, and carries the ticket from
  the branch name the way the log does — never invented.
- `/concise:commit` also gives the exact `git restore --staged <paths>`
  when the staged diff is two unrelated changes, and wraps the body near
  72 columns.
- **PR deliverables must be a real markdown list** — `- ` at the start of
  the line. A real PR came out with the changes chained by dashes inside
  one paragraph: the same wall of text the semicolon rule banned, with
  different punctuation.
- **A feature with no screen is not excused from the test step.** The same
  PR said the route was "reachable by direct call" without giving the
  call; the step is the call itself, route and body included.
- Case 16 (commit convention) and case 17 (a PR with five deliverables)
  keep both from regressing.

## 1.17.0 — 2026-08-19

Shorter corrections, from a real reply that ran three times its budget.

- **The correction rule moved into the always-on core.** It was in the full
  ruleset and being skipped, because most turns run on the core alone — so a
  reply that found its own mistake spent a headed section explaining what it
  had misread, which is the account of the error the rule already banned.
- **Re-announcing after a check is now cut explicitly.** Saying the answer,
  going to verify, then opening the next message with the same sentence is a
  shape the ruleset had no name for.
- Case 15 tests both, so the rules regress instead of drifting.

## 1.16.0 — 2026-08-19

Reach: the same rules, in places they could not go before.

- **The core also ships as an output style.** It lives in the system prompt
  instead of being printed by a shell hook — so it works on Windows without
  Git Bash, where the hook fails silently, and it is cached rather than
  re-sent every session. Pick it in `/config` → Output style. The plugin
  does not force it: forcing would override the output style you chose.
  `check-parity` fails if the style and the hook core ever drift apart.
- **A version bump on `main` now tags and publishes a release**, with that
  version's CHANGELOG section as the notes — twelve versions had shipped
  with no tag to pin, roll back to, or watch.
- **The ruleset installs into other agents** — Cursor, Copilot, Codex,
  Windsurf — via `npx skills add`. Only the document travels; the README says
  plainly what stays behind.

## 1.15.0 — 2026-08-19

Measurement that discriminates. No rule changed; what changed is what can
catch a rule breaking.

- **`BASELINE=1` runs the cases with no style at all.** A case that passes
  there measures the model's habits, not the rules — the suite could not tell
  the difference before, and the maintainer's own `CLAUDE.md` was leaking the
  skill into every comparison.
- **`RUNS=3` reports `FLAKY`** instead of letting one lucky attempt read as a
  pass, and `MODEL=` pins the model so two runs are comparable.
- **`CORE=1` judges the always-on core** — the ~20 lines injected into every
  session, the most-used surface of the product, previously untested.
- **Five cases:** PR description, card that stands alone, status delta,
  bad news plus the second question, and draw-the-shape. Nine to fourteen.
- **A rule → case map** in `evals/README.md`, with the gaps named rather than
  implied.
- CI runs the suite for both ports and for the core, and a maintainer can
  launch it by hand on a fork PR, where secrets never reach the job.

## 1.14.0 — 2026-08-19

The surfaces the ruleset didn't reach, and the escape it never had.

- **Plans you propose** get a budget row and a section: the numbered steps
  you will run, the risk named, what it leaves out — and no retelling of the
  exploration that got you there. It is the text a user reads before
  authorising work.
- **Comments and replies** — review comments, issue replies, notes on a card
  — get a section: the claim then the line that proves it, what would change
  your mind instead of a hedged claim, no praise as filler, one point per
  comment. The credit guard now covers `gh pr review` too.
- **Asked to expand, expand.** "Explain in detail" turns the budgets off for
  that turn and the next turn is concise again, unasked — the padding never
  comes back with the length. It is the objection every always-on terse style
  has to answer.
- **Changelog entries** get two lines of rule: what changes for whoever
  installs, not the diff retold.
- Both descriptions now name every surface the ruleset governs, which is what
  the model reads when deciding to load it.

## 1.13.0 — 2026-08-19

Correctness pass over the whole plugin, from an audit of every surface.

- **`/concise:pr` stopped truncating its own output.** The delivery block is
  fenced with four backticks now: a PR description carries a `bash` block by
  rule, and the old three-backtick wrapper ended at that inner fence — on
  nearly every invocation. Same fix in `card` and `rewrite`.
- **The credit guard grew from two commands to eight**, reads the message
  when it comes from a file (`-F`, `--body-file`), and names Copilot, Gemini,
  Cursor and Codex besides Claude. It also gained two escapes, because a
  deterministic guard has false positives: `CONCISE_ALLOW_CREDIT=1` and
  `~/.claude/.concise-no-credit-guard`.
- **The hook logic moved into four versioned scripts** — `credit-guard.sh`,
  `inject-core.sh`, `self-update.sh`, `notices.sh` — byte-identical across
  ports, with the language passed in from `hooks.json`. The guard regex
  existed in four copies that could drift with CI green; now it exists once.
- **Self-update stamps before it runs**, so a permanent failure retries
  tomorrow instead of at every session start forever; takes a lock, so two
  sessions don't update the same clone at once; and announces the version it
  moved to. Opt out with `~/.claude/.concise-no-self-update`.
- **The welcome note is a `systemMessage`** — it reaches the user's screen
  instead of the model's context, which the style itself tells the model to
  cut.
- `/concise:pr` takes extra context besides a base ref, and states it never
  runs `gh pr create`. `/concise:rewrite` reads a file when the argument is a
  path.
- Rules: the `yes/no` opening yields to a false premise or real uncertainty;
  the hook core stopped banning headers the skill allows; two rules that
  failed the repo's own bar were removed. PT gained "antítese" in the
  rhetorical-flourish cut and the sharp reader in its core; EN gained
  "Required" in the description, which is what makes the model reach for the
  skill.
- The audit agent now knows commit messages and the stands-alone test.
- Tooling: `scripts/test-hooks.sh` (26 offline cases, in CI), CI validates
  every plugin JSON, `check-bump` rejects a version that goes backwards,
  `check-parity` compares hook behaviour instead of counting lines, and the
  eval runner aborts on an empty response, a missing rubric or a dead CLI
  instead of scoring them.
- Docs: install says the style starts next session, a quick-start sits at the
  top, uninstall is documented with its state files, the port guide lists
  what a third port must rename, and the stale "six evals" claim is gone.

## 1.12.0 — 2026-08-19

- Status updates carry only the delta: a new budget row and an always-cut
  entry ban re-summarising work an earlier message already reported — "CI
  green, ready to merge" is a whole turn. Both hook cores name it.

## 1.11.0 — 2026-08-19

- The PR description carries the card or issue that motivated the work, as
  a link — `Closes #N` on GitHub, the card's link or id on a board — when
  it exists in the conversation or a tracker tool can find it, and never
  otherwise. `/concise:pr` (`/respostas-curtas:pr`) gained the lookup step.

## 1.10.0 — 2026-08-19

- Self-update checks once per day instead of every session start — a stamp
  in `~/.claude`, written only when the update pair succeeds, so an offline
  day retries next session.
- The first session after install prints a one-line map of the commands
  and the agent, once.
- Repo side, no plugin change: the repo now practises the templates the
  skill preaches (`.github/PULL_REQUEST_TEMPLATE.md` and two issue forms,
  comment-guided so nothing renders as boilerplate), and the eval suite
  grows to nine cases — the `bash` fence, the overloaded opening, and
  commit messages join the six from the examples.

## 1.9.0 — 2026-08-19

- Cards grow three rules: what the conversation settled goes into the
  destination's fields, not the body and not silently the default; the
  tracker's issue template is a contract to fill; and creation starts by
  looking for the card that already exists.
- `/concise:card` (`/respostas-curtas:card`) creating at a destination now
  searches for duplicates first, honours GitHub issue templates, discovers
  and sets fields, links named blockers or parents, and reports what it set
  and what stayed at default.

## 1.8.0 — 2026-08-19

- PR descriptions grow four rules: the repo's `PULL_REQUEST_TEMPLATE` is a
  contract to fill in the register — no boilerplate sections, no checkbox
  ticked that isn't true; a many-file diff says where to start reading; the
  title follows the commit-title rule; and "and also" means two PRs.
- `/concise:pr` (`/respostas-curtas:pr`) reads the branch's commits for the
  why, fills the repo template when one exists, and delivers the title
  ready for `gh pr create --title` alongside the body.

## 1.7.1 — 2026-08-18

- The credit guard also covers the `PowerShell` tool — on Windows, a commit
  made through it used to walk past the 1.7.0 guard.
- The guard now catches compound commands. The 1.7.0 filter matched by
  prefix, so `git add -A && git commit …` — the most common real shape —
  never triggered it; detection moved into the guard itself, which runs as a
  tiny grep on every shell call. Known limit documented: a message passed
  via `git commit -F <file>` stays out of reach.

## 1.7.0 — 2026-08-18

- Credit guard, enabled by default: a `PreToolUse` hook denies `git commit`
  and `gh pr create` whose text carries AI credit — deterministic string
  match, no API call. The ruleset's hardest rule becomes a system rule.
- "Commit messages" section in the skill, and `/concise:commit`
  (`/respostas-curtas:commit`): drafts the message for what is staged —
  verb-first title ≤72 chars, body says why, draft only.
- The `pr` and `card` commands self-audit against their checklists before
  delivering.

## 1.6.0 — 2026-08-18

- Four aesthetic rules for what the model outputs, at zero budget cost: a
  runnable command gets a `bash` fence of its own (and every fence a
  language tag); table cells hold values with the prose staying outside; a
  PR that ships several deliverables lists them one per line instead of
  chaining semicolons; and the overloaded opening joins "Before sending" —
  verdict in sentence one, support from sentence two.
- Both hook cores name the `bash` fence.

## 1.5.1 — 2026-08-18

- Catalogue and manifest descriptions catch up with 1.5.0: three commands and
  the self-update hook, not just `rewrite`.
- Changelog dates corrected to the real merge dates (every release so far
  landed on 2026-08-18).

## 1.5.0 — 2026-08-18

- `/concise:pr` (`/respostas-curtas:pr`): drafts the pull request description
  for the current branch from the real diff, test steps at the end.
- `/concise:card` (`/respostas-curtas:card`): drafts a task/issue card that
  stands alone, and creates it when a reachable destination is named.
- Local core override: `~/.claude/concise-core-override.md`
  (`~/.claude/respostas-curtas-nucleo-override.md`) replaces what the
  `SessionStart` hook injects, and survives auto-updates — editing the cached
  `core.md` no longer does.
- Opt-in Stop auditor in `extras/stop-audit/`: warns when a turn's final
  response clearly violates the core. One API call per turn; off unless you
  install it.
- CI: `check-bump.sh` fails any PR that changes a plugin without bumping its
  version; evals run as an advisory job on PRs that touch `SKILL.md`.
- README: before/after figure, badges, and a full Portuguese translation
  (`README.pt-BR.md`), with structural parity checked in CI.

## 1.4.0 — 2026-08-18

- `/concise:rewrite` (`/respostas-curtas:reescrever`): rewrites a finished
  text to the ruleset without losing information.
- `audit` (`auditar`) agent: returns only the violations — quote, rule,
  one-line fix — plus required content that is missing.
- Self-update: a second `SessionStart` hook updates the plugin in the
  background at each session start (requires a version bump to move).
- CI parity check between the EN and PT ports; eval harness with six judged
  cases in `evals/`.

## 1.3.0 — 2026-08-18

- `SessionStart` hook injects a ~20-line core of the style into every
  session, making the style always-on without depending on invocation.

## 1.2.0 — 2026-08-18

- Tasks and issues: everything a card carries, what enters under condition,
  and the structure a narrow panel holds (no headers, no tables, bold only
  as item labels).

## 1.1.0 — 2026-08-18

- Tasks and issues as a destination surface; the version-bump rule that makes
  `claude plugin update` actually move.

## 1.0.0 — 2026-08-18

- First plugin release: install via marketplace in two commands instead of
  clone and copy.
