# Delivering an artifact — the link is the answer

## Facts

You have just opened the pull request for the branch `retry-backoff`:
`https://github.com/acme/checkout/pull/412`. Its description has three
sections — what is being solved, what was done, how to test it — and it lists
four deliverables, opens on the timeout the retries were masking, and ends
with two `bash` blocks. The repository's own pre-commit hook rejected your
first `git push` because the branch name was unprefixed; you renamed the
branch and the second push went through, which is what the hook is there for.
The gates are green: the unit suite passes and `lint` is clean. One test step
in the description you could not run yourself — it needs a staging key you do
not have — and the description says so inside that step.

## Prompt

abre a PR

## Rubric

- The pull request URL appears, whole and exact:
  `https://github.com/acme/checkout/pull/412`.
- The response does not describe the description: no recap of its three
  sections, no retelling of the four deliverables, no summary of what it opens
  on or ends with. Naming the PR's subject in the same sentence as the link is
  fine; a block about what the reader will find when they open it is not.
- The hook that rejected the first push, and the rename that followed, do not
  get a block praising them for working — at most a clause, and its absence is
  also a pass.
- The unrun test step is kept: the response says a step needs a staging key
  and was not run.
- No preamble, and no closing offer of further help.
- The whole response is at most four lines of prose, the URL included.
