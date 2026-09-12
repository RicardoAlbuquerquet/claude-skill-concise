Cut the text that carries zero out of the code: comments, docstrings, log and
error messages, and the strings a person reads on screen. Read
`.cursor/rules/concise-code.mdc` first: it holds the rules, and
this file only the procedure.

(Your arguments: whatever you typed after the command name, when there was any.)

How:

1. **The target.** Paths in the argument, when there are any — a directory
   means the source files under it. Empty, the files this branch changed:
   `git diff --name-only origin/main...HEAD` plus what is uncommitted. When
   both come up empty, say so and stop. Generated code, vendored code,
   lockfiles and database migrations stay out of the target.
2. **Read before cutting.** Each file whole, and the convention around it: how
   densely its neighbours comment, where the strings live — inline, or in a
   catalog like `locales/` or `messages/` — and which tests assert on text.
3. **Cut what the file cuts**: the comment the next line already says, the
   comment about an edit, commented-out code, banners, the docstring retelling
   its signature; on screen, the second saying of the same thing, the button
   with a bare `OK`, the tone words, the toast for a change the user watched
   happen.
4. **Keep what the file keeps, and what only looks dead**: a directive inside
   a comment (`eslint-disable`, `@ts-expect-error`, `# type: ignore`), a
   license header, a docstring a documentation generator publishes, and JSDoc
   that carries the types in a JavaScript project.
5. **A string moves with everything that matches it.** Before changing a
   visible string, search the repo for it — a test, a snapshot, another
   locale, a client that parses an error message — and change them together.
   When one of them has to stay — a locale you would translate poorly, a
   message another system parses — leave the string as it was and report it.
6. **Run the repo's own checks** on what you touched — the test and lint
   scripts it defines — and keep the line that proves the result.

The commit is the user's, and code that runs stays as it is: a name, a
condition or a structure stays out of scope even when it reads badly.

Deliver it as completed work: the files changed and the line from the checks —
and ahead of both, when there is any, what you left in place on purpose, one
line each, with the reason. The diff shows the strings that changed; the
delivery leaves the count and the before/after to it.
