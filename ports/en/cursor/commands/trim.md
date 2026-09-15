Remove text that adds no value: comments, docstrings, logs, errors, and
user-facing copy. First read `.cursor/rules/concise-code.mdc`;
it defines the rules.

(Your arguments: whatever you typed after the command name, when there was any.)

Process:

1. Determine the target:
   - paths from `(Your arguments: whatever you typed after the command name, when there was any.)`; directories mean their source files;
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
