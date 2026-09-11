# Commit messages

## Beliefs

- **`git log --oneline` shows the title and nothing else** — the narrowest
  window of anything that leaves the conversation, and the highest volume.
- **The diff already shows what changed.** The investigation, the list of
  what you ran and the release note each have a home — the PR description,
  the test step, the changelog — and land there anyway.
- **The repo's log is a convention** its readers already scan by.

## Desires

- Someone scanning the log learns what each commit changes; someone opening
  one learns why.

## Intentions

- **The title says what changes when the commit lands**, 72 characters or
  fewer, no trailing period: "Fix the invoice filter dropping the timezone".
  An imperative or a declarative that names the change both work; a label with
  no change in it ("Invoice filter", "Fixes") never does. Where the repo holds
  more than one area, the area comes first.
- **The title lands inside the log's convention** — a `fix(scope):` prefix, a
  ticket code, a bare `scope:`, another language: whatever recent titles do
  consistently. The log decides the shape, never the substance.
- **The body says why, and often nothing**: why now, what behaviour changes,
  what to watch. Six lines is the ceiling and no body is the common case; what
  pushes a body past six is never a second reason — it is the investigation
  retold, the list of what you ran, a file-by-file account, or the release
  note written early. Wrap near 72 columns.
- **Exact references survive** — the issue number, the path, the flag name.
- **One commit, one change**: a message that needs "and also" describes two
  commits.
