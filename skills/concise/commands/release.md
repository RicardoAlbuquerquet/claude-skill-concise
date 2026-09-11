---
description: Draft the changelog entry and release body — what breaks first
argument-hint: "[version, a commit range, or extra context — optional]"
---

Draft the changelog entry and, when a release is being cut, the release body.
Read `${CLAUDE_PLUGIN_ROOT}/references/changelog.md` first: it holds the
rules, and this file only the procedure.

The argument below may carry the version to release, a commit range, or
context the commits can't show. Empty, the range is the last tag to `HEAD`.

$ARGUMENTS

How:

1. The range: `git describe --tags --abbrev=0` for the last tag, then
   `git log <tag>..HEAD --oneline`. No tags, `git log --oneline -30` and one
   line saying which range you assumed. Empty range: say so and stop.
2. The existing changelog, for its shape — heading, date format, grouping
   under `Added`/`Fixed` or prose, bullets or paragraphs. No changelog: say
   which shape you picked.
3. The diff, wherever a commit title doesn't say what the reader will see —
   a title written for the log is often too short to be an entry.
4. Write it as the reference says. The version number is proposed with the
   single change that forces it — a break the major, a new capability the
   minor, everything else the patch; the date comes from the caller or the
   environment, never a guess. No release-note voice ("we're thrilled to"),
   which is postamble with a megaphone on it.
5. Check the draft against the reference and fix what fails.

Delivery: the changelog entry first, in a fenced block ready to paste at the
top of the file — four backticks when an entry carries a fence of its own, as
a migration command does. Then the release body in its own block, only when
the invocation is cutting a release: the same content plus the compare link
and the install line the file doesn't need. Nothing after them except values
you could not fill, one line each, opening with **Missing:**.

Draft only: never run `gh release create`, never push a tag, and never edit
the changelog file unless the user asks.
