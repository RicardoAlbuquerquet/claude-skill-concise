# Commit messages

## Beliefs

* `git log --oneline` shows the title first, so it must carry the change clearly.
* The diff already shows implementation details.
* Commit style should match the repository's existing convention.

## Desires

* Someone scanning the log understands **what changed**.
* Someone opening the commit understands **why**.

## Intentions

### Title

* Describe the change introduced by the commit.
* Keep it to **≤72 characters**.
* End with a letter.
* Include the area first when useful.
* Match the repository's existing format, such as:

  * `fix(scope): ...`
  * ticket prefixes;
  * `scope: ...`;
  * the repository's language and wording style.

Avoid vague titles such as:

`Fixes`

`Invoice filter`

Prefer:

`Fix the invoice filter dropping the timezone`

### Body

* Usually leave it empty.
* When needed, explain **why**, not what the diff already shows.
* Keep it to **≤6 lines** and wrap near 72 columns.
* Do not include investigation history, test logs, file-by-file summaries, or release notes.

### References

Keep exact references when useful:

* issue or ticket IDs;
* paths;
* flags;
* versions or other exact values.

### Scope

**One commit should represent one change.**

If the message needs “and also” for unrelated work, split the commit.
