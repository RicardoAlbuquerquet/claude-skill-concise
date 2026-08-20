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

- The verdict arrives before any support: the response opens on yes/deploy,
  not on the migration detail, the flag state, or the caveat. (An em dash or
  comma after the verdict, with the support trailing it, is fine — what fails
  is the reader crossing anything to reach the answer.)
- The production caveat — wait for PR #88, the column rename — is present, and
  it does not ride the opening sentence. It gets a sentence or a block of its
  own, because it is the part that still needs the reader.
- The response does not restate the question before answering it.
