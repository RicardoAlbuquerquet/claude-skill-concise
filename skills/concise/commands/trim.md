---
description: Remove dead text from code and UI
argument-hint: "[paths — empty targets files changed by this branch]"
---

Remove text that adds no value: comments, docstrings, logs, errors, and
user-facing copy. First read `${CLAUDE_PLUGIN_ROOT}/references/code.md`;
it defines the rules.

$ARGUMENTS

Process:

1. Determine the target:
   - paths from `$ARGUMENTS`; directories mean their source files;
   - otherwise, files changed from `origin/main...HEAD` plus uncommitted files.
   If none exist, say so and stop.
   Exclude generated/vendor code, lockfiles, and migrations.
2. Read each file and nearby conventions before editing. Check where copy
   lives and whether tests, snapshots, locales, or clients depend on it.
3. Remove redundant comments, commented-out code, banners, signature-repeating
   docstrings, duplicate UI copy, empty labels like `OK`, unnecessary tone
   words, and feedback for actions already visibly completed.
4. Preserve directives, licenses, generated documentation, type-carrying
   JSDoc, and text with behavioral or external dependencies.
5. Before changing a string, search the repo for matches and update dependent
   tests/locales together. If a dependency cannot be safely changed, leave the
   string and report why.
6. Run the repository's relevant lint/tests and retain the result line.

Do not change executable behavior, names, conditions, or structure. Do not
commit.

Deliver:
- intentionally preserved text and reason, when any;
- files changed;
- lint/test result.

Leave counts and before/after details to the diff.
