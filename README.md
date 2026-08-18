# concise

A Claude Code skill that makes Claude answer in the register a terminal actually
wants: the answer first, nothing padding it, and no sacrifice in correctness.

## The problem

Claude's default writing register is expansive. It's a good default for a chat
window and a bad one in a terminal, where it shows up as:

- a preamble before the answer (`"Great question — let me look at that."`)
- `##` headers over a three-line reply
- justification nobody asked for, after the answer was already given
- narration of the search — which files were read, in what order
- a menu of four options when one recommendation was wanted
- a closing aphorism, because the paragraph felt like it needed a landing

None of that is wrong. All of it is between you and the answer.

## What it does

The skill installs one rule — **the answer goes in the first sentence, and after
it only what changes a decision** — plus explicit budgets per situation, a list
of constructs to always cut, and a shorter list to *never* cut.

That second list is the part that matters. Compression is easy to overdo, and a
one-line answer that dropped the caveat about production data is worse than the
bloated version. The skill states outright that bad news, a risk, an exact path
or version, a false premise in the question, and an unverified assumption all
survive the edit.

Three rules run the other way and *add* text, because what was missing was
information rather than words:

- **A recommendation always ships with its cost.** Recommendation, ≤3 lines of
  why, ≤3 lines of what gets worse or what you give up. A recommendation with no
  stated downside either has one nobody looked for or is hiding it — and from the
  reader's side, an empty slot is indistinguishable from "I examined it and it's
  cheap".
- **When the decision is the user's, the options go side by side**, then you
  still recommend one and say why it beats *the others specifically*. Deciding a
  money or risk question silently is shorter and not yours to do.
- **Draw the shape.** When the answer is a sequence or a branch, a five-line
  ASCII diagram beats the paragraph the reader would have to assemble in their
  head.

Structure is judged by content, not by length. An earlier version cut headers and
bullets from any response under six lines; that test was wrong, because it
measured the response instead of what's in it. The rule now: separate what is
genuinely separate — two jobs get two blocks, comparisons get a table, paths and
technical terms get code spans — and never fragment a single thought. If you can
say what each block is *for*, the structure is real; if the blocks are "part one,
part two", it's decoration.

It also fixes the audience. The skill is written for a reader who owns the
product but is not deep in the stack: keep the precise term, then pay for it once
by glossing it **through its consequence** rather than its definition — not
"`timestamptz` is a timezone-aware type" but "the column stores UTC, so a filter
built in local time asks for a window that hasn't started yet". An answer the
reader can't act on isn't concise, it's just short.

See [`examples/before-after.md`](examples/before-after.md) for nine real
transformations. Four come out longer.

## Install

Two commands, typed inside a running Claude Code session:

```
/plugin marketplace add RicardoAlbuquerquet/claude-skill-concise
```

```
/plugin install concise@claude-skill-concise
```

**Those are Claude Code commands, not shell commands.** Pasted into PowerShell,
bash, or zsh they fail with `command not found` — the leading `/` is the giveaway.
From a terminal, use the `claude` CLI instead. Same effect, and the same on
macOS, Linux, and Windows:

```bash
claude plugin marketplace add RicardoAlbuquerquet/claude-skill-concise
```

```bash
claude plugin install concise@claude-skill-concise
```

The CLI form installs to user scope and takes effect the next time you start
Claude Code, or when you run `/reload-plugins` in a session that's already open.

Swap `concise` for `respostas-curtas` to get the Portuguese port. Install one,
not both — see [Languages](#languages).

Plugin skills are namespaced by the plugin that ships them, so this registers as
`/concise:concise`, not `/concise`. Run `/plugin` and open the **Installed** tab
to see the exact name it took.

Updating later takes two commands, not one — the first refreshes the catalogue,
the second moves the copy that actually runs:

```
/plugin marketplace update claude-skill-concise
/plugin update concise@claude-skill-concise
```

```bash
claude plugin marketplace update claude-skill-concise
claude plugin update concise@claude-skill-concise
```

Running only the first is the common mistake: it reports `✔ Successfully updated
marketplace` and the installed skill stays exactly where it was. The second one
needs the marketplace inside the name — `claude plugin update concise` on its own
answers `Plugin "concise" not found` — and it moves only when the release bumped
`version`, because it compares version numbers rather than content. Restart
Claude Code afterwards, or run `/reload-plugins`.

Third-party marketplaces ship with auto-update off. To skip the first one by
hand, turn it on in `/plugin` → **Marketplaces** → **Enable auto-update**.

**Since 1.4.0 the plugin runs the pair itself.** A second `SessionStart` hook
fires both commands in the background at each session start, so an installed
copy follows the marketplace with one session of delay — the session that
starts downloads the update, the next one runs it. Know what that implies
before relying on it:

- It moves only when the release bumped `version`, same as the manual pair —
  an unbumped change on `main` never propagates.
- It costs a network round-trip per session start, and fails silently without
  the `claude` CLI on PATH or without network — the next session just tries
  again.
- Copies on 1.3.0 or earlier don't have the hook yet. Reaching 1.4.0 still
  takes one manual update, or the marketplace toggle above.
- Opting out of self-update while keeping the skill means installing by copy —
  that path carries no hooks — or disabling the plugin's hooks wholesale.

### Copying the file instead

It's one Markdown file with no dependencies, so copying it works too — and keeps
the unprefixed `/concise`. This is the path that differs per platform.

Clone first, on any of the three:

```bash
git clone https://github.com/RicardoAlbuquerquet/claude-skill-concise.git
```

**macOS and Linux** — also Git Bash or WSL on Windows:

```bash
mkdir -p ~/.claude/skills
cp -r claude-skill-concise/skills/concise ~/.claude/skills/
```

**Windows**, in PowerShell:

```powershell
New-Item -ItemType Directory -Force -Path $HOME\.claude\skills | Out-Null
Copy-Item -Recurse claude-skill-concise\skills\concise $HOME\.claude\skills\
```

Project-level instead, committed with the repo so your team shares it: create
`.claude/skills/` at the project root and copy into that.

Verify it registered by typing `/concise` in Claude Code. If it doesn't appear,
check the path: copying into a `skills/` directory that doesn't exist yet lands
`SKILL.md` directly in it, one level too high, and reports no error.

## Making it always-on

**A skill alone will not fire on every turn.** Skills are invoked — either by you
typing `/concise`, or by the model deciding the `description` matches the task.
A response-*style* rule wants to apply to all of them, including the turns where
nothing about the task suggests "now think about brevity".

**Installed as a plugin, this is handled for you.** Since 1.3.0 each plugin
ships a `SessionStart` hook that prints a ~20-line core of the style into
context at every session start — about 320 tokens, spent whether or not the
session produces prose. The core is the guarantee; the full ruleset still
lives in the skill, which the model invokes when a turn needs more than the
core. To see or prune what gets injected, it's one file:
[`hooks/core.md`](skills/concise/hooks/core.md)
([`hooks/nucleo.md`](skills/respostas-curtas/hooks/nucleo.md) in the PT port).

One platform edge: the hook runs through Git Bash on Windows. Without Git for
Windows installed it fails silently and you're back to invocation-only — same
machines where Claude Code's own Bash tool doesn't run, so in practice the
hook works wherever the rest does.

**Installed by copy, the hook doesn't come along** — `~/.claude/skills/` takes
only the skill. Pair it with a line in `CLAUDE.md`, which is loaded into
context every session:

```markdown
## Writing style

Every response to me follows the `concise` skill: answer in the first sentence,
cut preamble and process narration, keep any caveat that would change what I do.
```

The skill holds the full ruleset; the hook or the `CLAUDE.md` line holds the
pointer that guarantees it's in context. Neither one replaces the other.

## The command and the agent

Since 1.4.0 each plugin also ships two tools for text that already exists —
the skill governs what Claude writes next; these act on what is written:

- **`/concise:rewrite <text>`** rewrites a finished text — a PR description,
  an issue body, an e-mail — to the ruleset without losing information: every
  exact value and caveat survives, and anything the original *owed* (a
  missing cost, a missing test step) is either filled from the original or
  reported as a hole, never invented. Empty arguments target Claude's own
  previous reply. PT: `/respostas-curtas:reescrever`.
- **The `audit` agent** (PT: `auditar`) checks a draft against the checklist
  and returns only the violations — quoted line, rule, one-line fix — plus
  required content that is missing. It never rewrites; ask for it when you
  want the diagnosis without the surgery: *"run the audit agent on this
  draft"*.

Both ship only with the plugin install; the copy-the-file path takes the
skill alone.

## Languages

| Skill | Language | Plugin name | Invoke |
|---|---|---|---|
| [`skills/concise`](skills/concise/SKILL.md) | English | `concise` | `/concise:concise` |
| [`skills/respostas-curtas`](skills/respostas-curtas/SKILL.md) | Portuguese (BR) | `respostas-curtas` | `/respostas-curtas:respostas-curtas` |

Installed by copy rather than as a plugin, they invoke unprefixed: `/concise`
and `/respostas-curtas`.

Install one, not both — they're the same ruleset and would compete, and since
1.3.0 each ships its own always-on hook, so both together inject the core into
context twice. The rules are
about structure, not vocabulary, so a translation is a faithful port rather than
a rewrite. Ports to other languages are welcome.

## The bar for a rule

This skill is a style guide, which makes it unusually easy to fill with advice
that reads well and changes nothing. Every rule in it has to clear two tests:

1. **Checkable.** A rule you can't verify against a finished response is
   decoration. `"one bold claim per block"` is checkable; `"be clear"` is not.
2. **Names a real failure.** The rule should exist because a specific bad output
   happens without it — ideally one you can quote.

`"Be brief"` fails both and is already implicit in every model's instructions.
That's why it isn't in the skill.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
