# Contributing

The failure mode for a style guide is growth: it fills up with advice that reads
well, contradicts nothing, and changes no output. Please help keep it small.

## Adding or changing a rule

A rule gets in if it clears both tests:

1. **Checkable.** You can hold a finished response next to the rule and say
   whether it complied. "One bold claim per block" passes. "Write clearly" does
   not.
2. **Names a real failure.** It exists because something specific goes wrong
   without it. Quote the bad output in your PR description — a real one you saw,
   not a hypothetical.

A rule already implied by the model's own instructions ("be concise", "avoid
repetition") earns nothing by being restated here, and dilutes the rules that do
work.

**Where it goes.** A rule for one surface — a PR, a card, a commit, a changelog,
a comment, text in code — goes in that surface's file under `references/`.
`SKILL.md` keeps only what applies to every reply, as beliefs, desires and
intentions, and stays under 500 lines: `test-hooks.sh` fails past that, and
after compaction Claude Code brings back only the first 5,000 tokens of a skill
— which is why Always keep and Always cut sit right after the budgets.

**Affirmative wording.** Every rule is written as what to do — "always
keep", "a header only where a second block follows" — since a model follows
a positive instruction more reliably than a negated one. A negation has an
affirmative form with the same truth value; write that form. Quoted examples
of bad output keep their wording: they are data.

## How long a command may get

A command file is loaded whole on every invocation, so its length is a cost
paid before any output exists. A command holds only the procedure — the
commands it runs, the delivery, the permission word — and the rules live in
the reference file it reads, stated once. `commands/draw.md` is the outlier at
148 lines against 68 for the next largest, and it is closed to further
content: a new drawing rule has to replace one, not join it. If a rule
genuinely does not fit that trade, the answer is a second command, not a
longer one.

The same test applies everywhere else, with more room: past roughly 100 lines,
say in the PR description which existing lines the new ones buy.

## Removing a rule

Removals are as welcome as additions. If you can show that a rule never fires,
or fires so constantly it has become noise, open a PR that deletes it.

## Languages

The plugin ships in English only, and the core tells the model to answer in
the language the user writes in. A translated copy of the ruleset is a second
place for every rule to drift, so ports go to other tools, not to other
languages.

## Keeping the hook core in sync

The plugin ships the style twice: the full ruleset in `SKILL.md` and
`references/`, and a short core in `hooks/core.md` that the forced output
style carries in the system prompt — the `SessionStart` hook prints it too
only under `CONCISE_INJECT_CORE=1`. A PR that changes a rule checks whether
the core states that rule, and moves it too. The core drifting from the skill
is worse than either alone: the model reads one in context and the other on
invocation, and follows whichever it saw last.

`scripts/test-hooks.sh` enforces the mechanical half: it fails when the output
style stops matching `hooks/core.md`, and when the marketplace card stops
matching the plugin's own description. Whether the core still says what the
skill says is the by-eye half.

## Keeping the ports in sync

[`ports/`](../ports/README.md) carries the same rules for Cursor, for ChatGPT
and for every tool that reads `AGENTS.md`. Everything there except the README
and the two ChatGPT files is generated, so a rule edited in the skill
reaches all of them through one command:

```bash
bash scripts/build-ports.sh
```

Commit what it rewrites. `bash scripts/build-ports.sh --check` fails when a
generated file is behind, and the `checks` workflow runs it on every PR. It
also fails when the plugin's own names — `${CLAUDE_PLUGIN_ROOT}`, the
`/concise:` prefix, `$ARGUMENTS` — survive into a file whose reader has none
of them, since each one is an instruction that reader cannot follow.

The two ChatGPT files are written by hand: a 1,500-character box holds a
compression of the core rather than the core itself, and the wording differs
because the medium does — no shell to paste into, no diff on screen. A rule
that changes the core changes them too, and the build holds each to its cap.

`ports/` changes nothing inside a plugin, so it carries no version bump of its
own.

## Bumping the version

Every PR that changes anything inside a plugin — `SKILL.md`, the hook core,
`hooks.json`, a command, an agent — bumps `version` in that plugin's
`.claude-plugin/plugin.json`.

Since 1.4.0 the self-update hook rides on this: it runs `claude plugin
update`, which compares version numbers, so an unbumped change lands on
`main` and never reaches a single installed copy.

Since 1.5.0 the rule is executable: `bash scripts/check-bump.sh` compares
your branch against `origin/main` and fails when a plugin changed without its
version moving — CI runs it on every PR. Each bump also gets a line in
[CHANGELOG.md](CHANGELOG.md): the number is what propagates, the entry is
what tells people what it brought.

Without the bump, an installed copy never updates. `claude plugin update
concise@claude-skill-concise` compares version numbers, not content, and answers
`✔ concise is already at the latest version (1.0.0)` while the cached copy under
`~/.claude/plugins/cache/` stays on whatever commit it was installed from. Three
merged PRs went unnoticed that way before anyone checked.

`claude plugin marketplace update` does not cover for it: that refreshes the
catalogue, not the installed plugin.

## Testing a change

The subject is prose, so the test suite is partial by nature. On Windows, run
every `bash …` command below from **Git Bash** — typed into PowerShell,
`bash` is the WSL stub, which fails asking for a distribution; the long form
`& "C:\Program Files\Git\bin\bash.exe" <script>` works from PowerShell too.
Three layers, cheapest first:

- **Hooks**, free and offline: `bash scripts/test-hooks.sh` runs every hook
  script against a fake `$HOME` and a fake `claude` — the credit guard's
  allow and deny cases, the daily throttle, the notices, the platform line,
  and the opt-in `stop-audit` extra. CI runs it too.
- **Evals**, two API calls per case: `bash evals/run.sh` sends each case in
  `evals/cases/` through the skill, with every reference file appended, and
  grades the response against its
  rubric — see [`evals/README.md`](evals/README.md) for the count and cost.
  Run it before
  and after a `SKILL.md` edit and compare; the judge is a model grading
  prose, so read a FAIL before believing it.

  **Never illustrate a rule with a case's own vocabulary.** A clause written
  with the route names from case 19 took that case to 3 of 3 in one port and
  down to 1 of 3 in the other, because the model optimised for the item the
  example named and compressed the rest of the answer away. Examples in
  `SKILL.md` should come from outside the suite.

  **One run per case is not evidence.** Use `RUNS=3`, which passes a case only
  when all three attempts pass. The suite reported 21/21 for weeks while two
  cases were failing about one run in three, and both turned out to be real
  defects. A case that fails *differently* on each attempt is usually two
  rules colliding rather than one rule worded badly; a case that fails while
  the session limit is being hit is not a finding at all.

  On PRs touching `SKILL.md` the `evals` workflow runs them as an advisory
  job that never blocks a merge. It needs the repo secret
  `ANTHROPIC_API_KEY`, and without it the jobs report `skipped` rather than
  green — a passing check that measured nothing reads as coverage that does
  not exist. Fork PRs never get the secret; run the workflow by hand from the
  Actions tab with the branch name.
- **Dogfooding**, still the real test: install your edited skill and run a
  week of ordinary work. Keep the responses that got **worse** — a rule that
  makes answers shorter but less useful is a regression, and this is the only
  layer that catches it. Add the convincing pairs to
  `examples/before-after.md`.
