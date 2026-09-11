# Changelog and release notes

## Beliefs

- **An entry is read by someone deciding whether to install**, and later by
  the person who did and is now debugging. Neither of them is reading the diff.
- **A reader who meets the breaking change three sections down** has already
  broken something.

## Desires

- Each reader learns what changes for them, what breaks first, and what to do
  about it.

## Intentions

- **An entry says what changes for whoever installs the release**, not what
  the diff did: "The PR command stopped truncating its own output" is an
  entry; "refactored the delivery block" is the diff talking.
- **What breaks goes first, with what to do in the same entry.**
- **One entry per behaviour that changed.** An internal refactor gets none,
  and a release with nothing user-visible says so in one line rather than
  manufacturing three.
- **The file's own shape is the convention** — its headings, its date format,
  its grouping.
- **Exact references survive, and the version names the change that forced
  it** — the flag, the setting that moved, the old name the reader will grep
  for: "Breaking: `--fence` is now `--fence-style`".
