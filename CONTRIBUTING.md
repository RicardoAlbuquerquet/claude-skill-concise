# Contributing

The failure mode for a style guide is growth: it fills up with advice that reads
well, contradicts nothing, and changes no output. Please help keep it small.

## Adding or changing a rule

A rule gets in if it clears both tests:

1. **Checkable.** You can hold a finished response next to the rule and say
   whether it complied. "Cut headers under ~6 lines" passes. "Write clearly"
   does not.
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

Copy `skills/concise/SKILL.md` to `skills/<name>/SKILL.md`, translate the body,
and set `name:` in the frontmatter to match the new directory. Keep the structure
identical — the rules describe the shape of a response, not its vocabulary, so a
port should be recognisably the same document. Add a row to the language table in
the README.

## Testing a change

There is no test suite; the subject is prose. What works instead:

- Install your edited skill and run a week of ordinary work with it.
- Keep the responses that got **worse**. A rule that makes answers shorter but
  less useful is a regression, and dogfooding is the only way to catch it.
- Add the convincing pairs to `examples/before-after.md`.
