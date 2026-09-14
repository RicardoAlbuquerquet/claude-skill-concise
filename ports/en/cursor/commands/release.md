Draft the changelog entry and, when a release is being cut, the release body.
The rules live in `.cursor/rules/concise-changelog.mdc` — read it
first.

The argument may carry the version to release, a commit range, or context
beyond the commits. Empty, the range is the last tag to `HEAD`:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- A commit title was written for the log and is usually too short to be an
  entry.
- The existing changelog is the shape this one has to land inside.
- One change forces the version number: a break the major, a new capability
  the minor, everything else the patch.
- Publishing is the user's: the tag, the release and the file edit.

## Desires

- The reader sees what breaks before what was added.

## Intentions

- Take the range from `git describe --tags --abbrev=0` and
  `git log <tag>..HEAD --oneline`. With no tags, use `git log --oneline -30`
  and say which range you assumed; with an empty range, say so and stop.
- Read the existing changelog for its shape — heading, date format, grouping
  under `Added` and `Fixed` or prose, bullets or paragraphs. Absent, say which
  shape you picked.
- Read the diff wherever a commit title leaves out what the reader will see.
- Write it as the reference says, propose the version with the single change
  that forces it, and take the date from the caller or the environment. Plain
  voice: "we are thrilled to" is postamble with a megaphone on it.
- Check the draft against the reference and fix what fails.
- Deliver the changelog entry first, fenced and ready to paste at the top of
  the file — four backticks when an entry carries a fence, as a migration
  command does. Then the release body in its own block, only when a release is
  being cut: the same content plus the compare link and the install line.
- Close with one line per value the range left open, opening with **Missing:**.
