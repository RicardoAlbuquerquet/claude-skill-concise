# Changelog

Every `version` bump in the two ports gets an entry here. The number is what
propagates a release: the self-update hook and `claude plugin update` both
compare versions, so a change without a bump reaches nobody — and a bump
without an entry tells nobody what it brought.

## 1.11.0 — 2026-08-19

- The PR description carries the card or issue that motivated the work, as
  a link — `Closes #N` on GitHub, the card's link or id on a board — when
  it exists in the conversation or a tracker tool can find it, and never
  otherwise. `/concise:pr` (`/respostas-curtas:pr`) gained the lookup step.

## 1.10.0 — 2026-08-19

- Self-update checks once per day instead of every session start — a stamp
  in `~/.claude`, written only when the update pair succeeds, so an offline
  day retries next session.
- The first session after install prints a three-line map of the commands
  and the agent, once.
- Repo side, no plugin change: the repo now practises the templates the
  skill preaches (`.github/PULL_REQUEST_TEMPLATE.md` and two issue forms,
  comment-guided so nothing renders as boilerplate), and the eval suite
  grows to nine cases — the `bash` fence, the overloaded opening, and
  commit messages join the six from the examples.

## 1.9.0 — 2026-08-19

- Cards grow three rules: what the conversation settled goes into the
  destination's fields, not the body and not silently the default; the
  tracker's issue template is a contract to fill; and creation starts by
  looking for the card that already exists.
- `/concise:card` (`/respostas-curtas:card`) creating at a destination now
  searches for duplicates first, honours GitHub issue templates, discovers
  and sets fields, links named blockers or parents, and reports what it set
  and what stayed at default.

## 1.8.0 — 2026-08-19

- PR descriptions grow four rules: the repo's `PULL_REQUEST_TEMPLATE` is a
  contract to fill in the register — no boilerplate sections, no checkbox
  ticked that isn't true; a many-file diff says where to start reading; the
  title follows the commit-title rule; and "and also" means two PRs.
- `/concise:pr` (`/respostas-curtas:pr`) reads the branch's commits for the
  why, fills the repo template when one exists, and delivers the title
  ready for `gh pr create --title` alongside the body.

## 1.7.1 — 2026-08-18

- The credit guard also covers the `PowerShell` tool — on Windows, a commit
  made through it used to walk past the 1.7.0 guard.
- The guard now catches compound commands. The 1.7.0 filter matched by
  prefix, so `git add -A && git commit …` — the most common real shape —
  never triggered it; detection moved into the guard itself, which runs as a
  tiny grep on every shell call. Known limit documented: a message passed
  via `git commit -F <file>` stays out of reach.

## 1.7.0 — 2026-08-18

- Credit guard, enabled by default: a `PreToolUse` hook denies `git commit`
  and `gh pr create` whose text carries AI credit — deterministic string
  match, no API call. The ruleset's hardest rule becomes a system rule.
- "Commit messages" section in the skill, and `/concise:commit`
  (`/respostas-curtas:commit`): drafts the message for what is staged —
  verb-first title ≤72 chars, body says why, draft only.
- The `pr` and `card` commands self-audit against their checklists before
  delivering.

## 1.6.0 — 2026-08-18

- Four aesthetic rules for what the model outputs, at zero budget cost: a
  runnable command gets a `bash` fence of its own (and every fence a
  language tag); table cells hold values with the prose staying outside; a
  PR that ships several deliverables lists them one per line instead of
  chaining semicolons; and the overloaded opening joins "Before sending" —
  verdict in sentence one, support from sentence two.
- Both hook cores name the `bash` fence.

## 1.5.1 — 2026-08-18

- Catalogue and manifest descriptions catch up with 1.5.0: three commands and
  the self-update hook, not just `rewrite`.
- Changelog dates corrected to the real merge dates (every release so far
  landed on 2026-08-18).

## 1.5.0 — 2026-08-18

- `/concise:pr` (`/respostas-curtas:pr`): drafts the pull request description
  for the current branch from the real diff, test steps at the end.
- `/concise:card` (`/respostas-curtas:card`): drafts a task/issue card that
  stands alone, and creates it when a reachable destination is named.
- Local core override: `~/.claude/concise-core-override.md`
  (`~/.claude/respostas-curtas-nucleo-override.md`) replaces what the
  `SessionStart` hook injects, and survives auto-updates — editing the cached
  `core.md` no longer does.
- Opt-in Stop auditor in `extras/stop-audit/`: warns when a turn's final
  response clearly violates the core. One API call per turn; off unless you
  install it.
- CI: `check-bump.sh` fails any PR that changes a plugin without bumping its
  version; evals run as an advisory job on PRs that touch `SKILL.md`.
- README: before/after figure, badges, and a full Portuguese translation
  (`README.pt-BR.md`), with structural parity checked in CI.

## 1.4.0 — 2026-08-18

- `/concise:rewrite` (`/respostas-curtas:reescrever`): rewrites a finished
  text to the ruleset without losing information.
- `audit` (`auditar`) agent: returns only the violations — quote, rule,
  one-line fix — plus required content that is missing.
- Self-update: a second `SessionStart` hook updates the plugin in the
  background at each session start (requires a version bump to move).
- CI parity check between the EN and PT ports; eval harness with six judged
  cases in `evals/`.

## 1.3.0 — 2026-08-18

- `SessionStart` hook injects a ~20-line core of the style into every
  session, making the style always-on without depending on invocation.

## 1.2.0 — 2026-08-18

- Tasks and issues: everything a card carries, what enters under condition,
  and the structure a narrow panel holds (no headers, no tables, bold only
  as item labels).

## 1.1.0 — 2026-08-18

- Tasks and issues as a destination surface; the version-bump rule that makes
  `claude plugin update` actually move.

## 1.0.0 — 2026-08-18

- First plugin release: install via marketplace in two commands instead of
  clone and copy.
