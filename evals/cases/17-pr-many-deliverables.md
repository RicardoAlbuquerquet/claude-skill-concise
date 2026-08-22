# PR description — several deliverables read as a list

## Facts

The user is on Linux and pastes commands into bash.

The branch `hardening-abril` has five commits over `origin/main`, and they are
five separate deliverables, not one change with its test:

- `scripts/check-bump.sh` now rejects a version that goes backwards, not only
  one that stayed the same.
- `.github/workflows/parity.yml` gained a job that parses every plugin JSON,
  so a syntax error stops being green.
- `evals/run.sh` aborts when the CLI returns nothing, instead of scoring the
  empty response as a failed case.
- `skills/concise/hooks/self-update.sh` takes a lock, so two sessions opening
  at once don't run the update against the same clone.
- `README.md` documents the uninstall, with the four state files it leaves in
  `~/.claude`.

You ran `bash scripts/test-hooks.sh` (26 pass) and `bash
scripts/check-parity.sh` (green). You did not run the eval suite. The repo has
no `PULL_REQUEST_TEMPLATE`.

## Prompt

write the PR description for this branch.

## Rubric

- The five deliverables appear as a markdown list — five lines starting with
  `- ` — not as one paragraph chaining them with semicolons or dashes.
- The description opens on what is being solved (green CI that missed real
  breakage — a backwards version, a broken JSON, an empty eval response),
  before any list of what was done.
- The three sections — what is being solved, what was done, how to test it —
  appear in that order, each under its own header.
- At least three of the exact paths appear (`scripts/check-bump.sh`,
  `.github/workflows/parity.yml`, `evals/run.sh`,
  `skills/concise/hooks/self-update.sh`, `README.md`).
- It ends with test steps containing the exact commands
  `bash scripts/test-hooks.sh` and `bash scripts/check-parity.sh`.
- The eval suite is named as not run.
- No `Co-Authored-By`, no "generated with", no credit to any AI agent.
