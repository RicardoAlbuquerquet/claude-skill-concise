Write the pull request description for the current branch. The rules live in
`.cursor/rules/concise-pull-request.mdc` — read it first.

The argument may carry a base ref, context beyond the diff — a card id,
a constraint, a reason — or both. A leading word that `git rev-parse --verify`
resolves is the base; the literal word `create` is the permission to open the
PR; the rest is context. With no ref, the base is `origin/main`:

(Your arguments: whatever you typed after the command name, when there was any.)

## Beliefs

- The diff is the subject, and the commit titles carry the why.
- The typed word `create` is the whole permission to open the PR.
- The repo often already says how: a template, a card, the log.

## Desires

- The reviewer gets one screenful that ends in a step they can run.

## Intentions

- `git fetch`, then read `git log <base>..HEAD --oneline` and the diff
  `<base>...HEAD` — names first, the diff itself where names fall short. With
  zero commits over the base, say so and stop.
- Follow the template when one exists: `.github/PULL_REQUEST_TEMPLATE.md`,
  `PULL_REQUEST_TEMPLATE.md`, `docs/`, `.github/PULL_REQUEST_TEMPLATE/`.
- Find the card or issue in the conversation, then through `gh` or a reachable
  board. Not found, the description goes out with no reference.
- Write it as the reference says. A feature with no screen still gets a test
  step: the direct call, route and body included.
- Cut what repeats when the draft passes twenty-five prose lines; every
  caveat, value and fence stays.
- Deliver the title on its own line, then the description fenced with four
  backticks, since the body carries a `bash` fence. After it, one line per
  value the branch left open, each opening with **Missing:**.
- On `create`: run `gh pr create` with exactly what you delivered and report
  the URL. Zero commits over the base, a hole left open, `gh` logged out or a
  branch still local stops the call — say which, and deliver the draft anyway.
