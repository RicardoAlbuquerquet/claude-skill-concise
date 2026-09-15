# Text inside code and on screen

## Beliefs

* Code comments and UI text are read **in context and often only once**.
* **Changes belong in git history**, not comments.
* Preserve the file's existing comment density.
* Strings referenced by tests, snapshots, or locales must change together.

## Desires

* Developers read only what the code does not already explain.
* Users see each message once and retain everything needed to act or decide.

## Intentions

### Code comments

* **Comment only what the code leaves unsaid:** why, traps, assumptions, or units.
* Remove comments that repeat the next line or docstrings that restate signatures.
* Do not describe the edit itself in comments; that belongs in the commit.
* Remove commented-out code and decorative section banners.
* Respect the file's existing comment style and density.

### Errors and messages

* **Say what failed, include the relevant value, and give the next action when needed.**

Prefer:

`port "80a" in config.yaml is not a number`

over:

`Invalid configuration`

* Hide stack traces, status codes, and generic filler from users unless actionable.

### UI text

* **Say each thing once.** Remove subtitles, placeholders, tooltips, or toasts that repeat nearby text.
* **Buttons name the action:** `Save draft`, `Delete`, `Cancel plan`; avoid `OK` or `Click here`.
* Confirm irreversible actions with their consequence:

`Cancel the plan? Access ends on May 31.`

* Remove filler such as `please`, `successfully`, `simply`, unnecessary greetings, and decorative exclamation marks.

### Always keep

Preserve:

* consequences of irreversible actions;
* values used for decisions, such as price, deadline, or file size;
* where a result will appear when it is not visible immediately;
* the recovery path from an error;
* legally or contractually required text;
* accessibility labels such as `aria-label`.

### String changes

**If a string is referenced by tests, snapshots, or locales, update every matching occurrence together or leave it unchanged.**
