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

## Removing a rule

Removals are as welcome as additions. If you can show that a rule never fires,
or fires so constantly it has become noise, open a PR that deletes it.

## Ports to other languages

Copy the whole `skills/concise/` directory to `skills/<name>/` — `SKILL.md` and
`.claude-plugin/plugin.json` both — translate the body, and set `name:` to match
the new directory in both files. A port that ships only `SKILL.md` installs as
nothing: a plugin directory with no `.claude-plugin/plugin.json` is rejected.

Keep the structure identical — the rules describe the shape of a response, not
its vocabulary, so a port should be recognisably the same document.

Then register it, in both places:

- an entry in `.claude-plugin/marketplace.json` carrying `name`, `source`
  (`./skills/<name>`) and `description`
- a row in the language table in the README

Both manifests have a validator. Run it before opening the PR:

```bash
claude plugin validate . && claude plugin validate ./skills/<name>
```

It prints `Validation passed` twice. Neither check verifies that the `source`
directory exists or that your port is listed at all — confirm that part by eye.

A new port also gets added to `scripts/check-parity.sh` — it compares the
ports pairwise and only knows the ones named in it.

## Keeping the hook core in sync

Each plugin ships the style twice: the full ruleset in `SKILL.md`, and a
~20-line core in `hooks/core.md` (`hooks/nucleo.md` in the PT port) that a
`SessionStart` hook injects into every session. A PR that changes a rule
checks whether the core states that rule — and moves it too, in both ports.
The core drifting from the skill is worse than either alone: the model reads
one in context and the other on invocation, and follows whichever it saw
last.

CI enforces the mechanical half of this: `scripts/check-parity.sh` compares
the structure of the two ports — section, bullet, and table counts in
`SKILL.md`, bullets in the hook core, versions, file counts under `commands/`
and `agents/` — and the `parity` workflow fails the PR on any drift. It
counts structure, not meaning: a translation that keeps the bullet count but
drops the rule still gets through, so the by-eye check above stays.

## Bumping the version

Every PR that changes anything inside a plugin — `SKILL.md`, the hook core,
`hooks.json`, a command, an agent — bumps `version` in that plugin's
`.claude-plugin/plugin.json`. Both ports move together, so they stay
comparable.

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

- **Parity**, free: `bash scripts/check-parity.sh` — CI runs it on every PR.
- **Evals**, ~12 API calls: `bash evals/run.sh` sends six prompts from
  `examples/before-after.md` through the skill and grades the responses
  against rubrics — see [`evals/README.md`](evals/README.md). Run it before
  and after a `SKILL.md` edit and compare; the judge is a model grading
  prose, so read a FAIL before believing it. On PRs touching `SKILL.md` the
  `evals` workflow runs them as an advisory job — it needs the repo secret
  `ANTHROPIC_API_KEY` and skips cleanly without it, and it never blocks a
  merge.
- **Dogfooding**, still the real test: install your edited skill and run a
  week of ordinary work. Keep the responses that got **worse** — a rule that
  makes answers shorter but less useful is a regression, and this is the only
  layer that catches it. Add the convincing pairs to
  `examples/before-after.md`.
