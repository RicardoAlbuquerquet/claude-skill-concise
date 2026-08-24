---
description: Draft the changelog entry and the release body for what shipped — what changes for whoever installs it, what breaks first, never the diff retold
argument-hint: "[version, a commit range, or extra context — optional]"
---

Draft the changelog entry and, when a release is being cut, the release body,
following the "Changelog and release notes" section of the `concise` ruleset.
Invoke the skill first if the full ruleset is not already in context.

The argument below may carry the version to release, a commit range, or
context the commits can't show. Empty, the range is the last tag to `HEAD`.

$ARGUMENTS

How:

1. Establish the range: `git describe --tags --abbrev=0` for the last tag,
   then `git log <tag>..HEAD --oneline`. No tags in the repo, fall back to
   `git log --oneline -30` and say in one line which range you assumed. If
   the range is empty, say so and stop — never draft a release from nothing.
2. Read the existing changelog before writing: heading shape, date format,
   whether entries group under `Added`/`Fixed` or run as prose, bullets or
   paragraphs. The file is the convention, the same way the log is for a
   commit title. No changelog in the repo, say which shape you picked.
3. Read the diff wherever a commit title doesn't say what the reader will
   see. A title written for the log is often too short to be an entry, and
   guessing the user-visible effect from a title is how a release note ends
   up describing something that didn't ship.
4. One entry per behaviour that changed. An internal refactor produces no
   entry; a release with nothing user-visible says that in one line rather
   than manufacturing three.
5. What breaks goes first, with what to do about it in the same entry — a
   reader who upgrades and meets the breaking change three sections down has
   already broken something.
6. Propose the version number and name the single change that forces it —
   a break forces the major, a new capability the minor, everything else the
   patch. The date comes from the caller or the environment, never a guess.
7. Exact references survive: the flag, the setting that moved, the issue
   number, the old name the reader will grep for. Never invent one.
8. No AI credit anywhere, and no release-note voice — "exciting
   improvements", "we're thrilled to" — which is postamble with a megaphone
   on it.

Before delivering, audit the draft yourself — every entry names a change the
installer can observe, breaking ones on top, no entry that only restates a
commit title, exact values present — and fix what fails. Deliver only the
clean version.

Delivery: the changelog entry first, in a fenced block ready to paste at the
top of the file, with four backticks when an entry carries a fence of its own
— a migration command does. Then the release body in its own block, only when
the invocation is cutting a release; it is the same content with the compare
link and the install line the changelog file doesn't need. Nothing after them
except values you could not fill, one line each, opening with **Missing:**.

Draft only: never run `gh release create`, never push a tag, and never edit
the changelog file unless the user asks. Cutting a release is theirs.
