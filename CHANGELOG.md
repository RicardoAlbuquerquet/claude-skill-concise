# Changelog

Every `version` bump in the two ports gets an entry here. The number is what
propagates a release: the self-update hook and `claude plugin update` both
compare versions, so a change without a bump reaches nobody — and a bump
without an entry tells nobody what it brought.

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
