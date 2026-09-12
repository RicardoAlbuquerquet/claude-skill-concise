# Ports

The same ruleset, for the tools that are not Claude Code. Everything here
except this file, its Portuguese twin and the four ChatGPT files is generated
from `skills/` by [`scripts/build-ports.sh`](../scripts/build-ports.sh), and
CI fails when a generated file falls behind the skill it came from.

Two languages, `en/` and `pt-BR/` — pick one, the way you pick one plugin.
Every command below is written for `en/`; swap the directory for the other.

## Cursor

```bash
mkdir -p .cursor/rules .cursor/commands && cp ports/en/cursor/rules/*.mdc .cursor/rules/ && cp ports/en/cursor/commands/*.md .cursor/commands/
```

```powershell
New-Item -ItemType Directory -Force .cursor\rules, .cursor\commands | Out-Null; Copy-Item ports\en\cursor\rules\*.mdc .cursor\rules\; Copy-Item ports\en\cursor\commands\*.md .cursor\commands\
```

`concise.mdc` carries `alwaysApply: true`, so the core sits in every request —
the same job the forced output style does in Claude Code. The other seven wait
for their description to match what you are doing: `concise-full.mdc` for the
whole ruleset, and one file per surface that leaves the conversation
(`concise-pull-request.mdc`, `concise-commit.mdc`, and four more).

The thirteen commands appear when you type `/` in the chat input, under their
bare names: `/pr`, `/card`, `/commit`, `/comment`, `/release`, `/plan`,
`/decide`, `/draw`, `/status`, `/handoff`, `/rewrite`, `/trim`, `/audit`.

Cursor also reads `AGENTS.md`, so the section below works there as a lighter
install — rules and commands are the fuller one.

## AGENTS.md

Read by Codex, Copilot's coding agent, Zed, Gemini CLI, Windsurf, Aider, Jules
and the rest of the `AGENTS.md` family, and by Cursor:

```bash
cp ports/en/AGENTS.md . && cp -r ports/en/concise .
```

```powershell
Copy-Item ports\en\AGENTS.md .; Copy-Item -Recurse ports\en\concise .
```

`AGENTS.md` holds the core and a table saying which file to read for anything
longer — `concise/full.md` for the whole ruleset, `concise/pull-request.md`
and its five siblings for the surfaces. Copying `AGENTS.md` alone still leaves
a working style; the folder is what the table points at.

A repo that already has an `AGENTS.md` gets the contents appended instead,
under a heading of its own.

## ChatGPT

Two files, because ChatGPT has two places to put them:

| File | Where it goes | Cap |
|---|---|---|
| `ports/en/chatgpt/custom-instructions.md` | Settings → Personalization → Custom instructions, in the box about how ChatGPT should answer | 1,500 characters |
| `ports/en/chatgpt/project-instructions.md` | a project's instructions, or a custom GPT's | 8,000 characters |

The first is a compression of the core — 1,500 characters is a quarter of what
the core needs, so it is written by hand rather than generated, and it keeps
the answer-first rule, both lists and the cost of a recommendation. The second
carries the full style, the thirteen commands as typed triggers (`/pr`,
`/commit`, …) and the six surfaces in brief.

The build fails if either file grows past its cap, so a rule added upstream
gets fitted here rather than silently truncated by the box.

## What stays behind

The forced output style, the turn reminder, the credit guard, the PR route
hint and the daily self-update are Claude Code plugin machinery, and they stay
there. In Cursor the always-on half survives as `alwaysApply: true`; in
ChatGPT as the instructions box; in `AGENTS.md` as the file the tool loads on
its own. The `audit` agent has no subagent to run in, so the portable
`/audit` carries the checklist inline instead of handing it over.

## Changing a rule

Edit the skill under `skills/`, then:

```bash
bash scripts/build-ports.sh
```

Commit what it rewrites. `bash scripts/build-ports.sh --check` is what CI
runs, and it also fails when the plugin's own names — `${CLAUDE_PLUGIN_ROOT}`,
the `/concise:` prefix, `$ARGUMENTS` — survive into a file whose reader has
none of them.
