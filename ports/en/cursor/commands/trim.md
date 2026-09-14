Cut the text that carries zero out of the code: comments, docstrings, log and
error messages, and the strings a person reads on screen. The rules live in
`.cursor/rules/concise-code.mdc` — read it first.

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- Code that runs stays as it is: a name, a condition or a structure is out of
  scope even when it reads badly.
- A visible string lives in more than one place — a test, a snapshot, another
  locale, a client that parses it.
- Some text only looks dead: a directive in a comment, a license header, a
  published docstring.
- The commit is the user's.

## Desires

- The file loses the text that carries nothing and keeps every consequence.

## Intentions

- Take the target from the paths in the argument, a directory meaning the
  source under it. Empty, take the files this branch changed —
  `git diff --name-only origin/main...HEAD` plus what is uncommitted — and
  with both empty, say so and stop. Generated code, vendored code, lockfiles
  and database migrations stay out.
- Read each file whole before cutting, with the convention around it: how
  densely its neighbours comment, where the strings live — inline or in a
  catalog like `locales/` — and which tests assert on text.
- Cut what the file cuts: the comment the next line already says, the comment
  about an edit, commented-out code, banners, the docstring retelling its
  signature; on screen, the second saying of the same thing, the bare `OK`
  button, the tone words, the toast for a change the user watched happen.
- Keep what only looks dead: `eslint-disable`, `@ts-expect-error`,
  `# type: ignore`, a license header, a docstring a generator publishes, and
  JSDoc carrying the types in a JavaScript project.
- Search the repo for a visible string before changing it and change every
  match together; where one has to stay — a locale you would translate
  poorly, a message another system parses — leave the string and report it.
- Run the repo's own test and lint scripts on what you touched, and keep the
  line that proves the result.
- Deliver it as completed work: what you left in place on purpose first, one
  line each with the reason, then the files changed and the line from the
  checks. The diff shows the strings; the delivery leaves them to it.
