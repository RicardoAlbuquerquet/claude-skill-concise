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

## Bumping the version

Every PR that changes a `SKILL.md` bumps `version` in that plugin's
`.claude-plugin/plugin.json`. Both ports move together, so they stay comparable.

Without the bump, an installed copy never updates. `claude plugin update
concise@claude-skill-concise` compares version numbers, not content, and answers
`✔ concise is already at the latest version (1.0.0)` while the cached copy under
`~/.claude/plugins/cache/` stays on whatever commit it was installed from. Three
merged PRs went unnoticed that way before anyone checked.

`claude plugin marketplace update` does not cover for it: that refreshes the
catalogue, not the installed plugin.

## Testing a change

There is no test suite; the subject is prose. What works instead:

- Install your edited skill and run a week of ordinary work with it.
- Keep the responses that got **worse**. A rule that makes answers shorter but
  less useful is a regression, and dogfooding is the only way to catch it.
- Add the convincing pairs to `examples/before-after.md`.
