# Text inside code and on screen

## Beliefs

- **What you write into an application is read by people who never saw this
  conversation**: the next developer, in a comment, and whoever uses the
  product, on the screen — mid-task, and reading nothing twice.
- **The diff's home is the commit.** After the merge, a comment about the edit
  points at a version nobody can see, and git keeps the old code.
- **A file's own comment density is its convention.**
- **A string that a test, a snapshot or another locale matches** breaks them
  when it changes alone.

## Desires

- The next developer reads only what the code can't tell them, and the person
  on the screen reads each thing once and never misses what they decide with.

## Intentions

- **A comment says what the code can't** — why it is this way, the trap, the
  unit: `// the bank rejects more than 2 decimals, so round before signing`.
  Most lines need none. One the next line already says goes
  (`// increment the counter`), and so does a docstring that retells the
  signature in words.
- **Nothing about the edit itself**: "now uses the new client", "fixed the
  race", "was 30" describe the diff.
- **No commented-out code, no banner splitting the file**, and no comment per
  function in a file that has none.
- **A message names what failed, with the value, and what to do**:
  `port "80a" in config.yaml is not a number`, never `Invalid configuration`.
  On screen, the same in the user's words — no stack trace, no status code, no
  "Oops".
- **A screen says each thing once**: no subtitle repeating the title
  (`Invoices` over `View and manage your invoices`), no placeholder repeating
  the label, no tooltip repeating the button, no toast for a change the user
  just watched happen.
- **A button is the verb of what it does** — `Save draft`, `Delete` — never
  `OK` or `Click here`, and a confirmation asks with the consequence:
  `Cancel the plan? Access ends on May 31.`
- **Tone words go**: "please", "successfully", "simply", the exclamation mark,
  the line welcoming someone to a page they already opened.
- **What only looks cuttable stays**: the consequence of an irreversible
  action, a value the person decides with (a price, a deadline, a file size),
  where a result lands when the screen can't show it, the one way out of an
  error, text a law or a contract requires, and the accessible name — an
  icon-only button keeps its `aria-label` when the visible word goes.
- **A string changes in every test, snapshot and locale that matches it at
  once, or not at all.**
