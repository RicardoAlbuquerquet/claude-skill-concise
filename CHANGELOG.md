# Changelog

Every `version` bump in the two ports gets an entry here. The number is what
propagates a release: the self-update hook and `claude plugin update` both
compare versions, so a change without a bump reaches nobody — and a bump
without an entry tells nobody what it brought.

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
