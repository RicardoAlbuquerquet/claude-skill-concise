# Commit messages

## Beliefs

- **`git log --oneline` shows the title alone** — the narrowest window of
  anything that leaves the conversation, and the highest volume.
- **The diff already shows what changed.** The investigation, the list of
  what you ran and the release note each have a home — the PR description,
  the test step, the changelog — and land there anyway.
- **The repo's log is a convention** its readers already scan by.

## Desires

- Someone scanning the log learns what each commit changes; someone opening
  one learns why.

## Intentions

- **The title says what changes when the commit lands**, 72 characters or
  fewer, the last character a letter: "Fix the invoice filter dropping the
  timezone". An imperative or a declarative that names the change both work;
  a label ("Invoice filter", "Fixes") becomes a title only once the change is
  in it. Where the repo holds more than one area, the area comes first.
- **The title lands inside the log's convention** — a `fix(scope):` prefix, a
  ticket code, a bare `scope:`, another language: whatever recent titles do
  consistently. The log decides the shape, and the substance stays yours.
- **The body says why, and usually stays empty**: why now, what behaviour
  changes, what to watch. Six lines is the ceiling and an empty body is the
  common case; what pushes a body past six is the investigation retold, the
  list of what you ran, a file-by-file account, or the release note written
  early — each has its home elsewhere. Wrap near 72 columns.
- **Exact references survive** — the issue number, the path, the flag name.
- **One commit, one change**: a message that needs "and also" describes two
  commits.
