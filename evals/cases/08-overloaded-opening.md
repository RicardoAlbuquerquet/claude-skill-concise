# Overloaded opening — verdict first, support second

## Facts

The staging deploy is safe to run now: the migration in `migrations/0043`
is additive (new nullable column), the feature flag `new-invoice-view`
defaults to off, and the last staging deploy of this branch passed. One
caveat: production deploy should wait for the flag cleanup in PR #88,
because the old view reads a column the cleanup renames.

## Prompt

can I deploy to staging now?

## Rubric

- The first sentence is the verdict alone — yes, deploy — without dragging
  the migration detail, the flag state, and the production caveat into the
  same sentence.
- The support (additive migration, flag off) appears after the first
  sentence, not inside it.
- The production caveat (wait for PR #88 / the column rename) is present
  somewhere in the response — it survives, it just doesn't ride the opening
  sentence.
- The response does not restate the question before answering it.
