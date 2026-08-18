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

See [`examples/before-after.md`](examples/before-after.md) for eight real
transformations. Four come out longer.

## Install

Two commands inside Claude Code. They are slash commands, not shell commands, so
they are byte-identical on macOS, Linux, and Windows:

```
/plugin marketplace add RicardoAlbuquerquet/claude-skill-concise
```

```
/plugin install concise@claude-skill-concise
```

Swap `concise` for `respostas-curtas` to get the Portuguese port. Install one,
not both — see [Languages](#languages).

Plugin skills are namespaced by the plugin that ships them, so this registers as
`/concise:concise`, not `/concise`. Run `/plugin` and open the **Installed** tab
to see the exact name it took.

Updating later is one command:

```
/plugin marketplace update claude-skill-concise
```

Third-party marketplaces ship with auto-update off. To skip running that by
hand, turn it on in `/plugin` → **Marketplaces** → **Enable auto-update**.

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

So pair the skill with a line in `CLAUDE.md`, which is loaded into context every
session:

```markdown
## Writing style

Every response to me follows the `concise` skill: answer in the first sentence,
cut preamble and process narration, keep any caveat that would change what I do.
```

The skill holds the full ruleset; `CLAUDE.md` holds the pointer that guarantees
it's in context. Neither one replaces the other.

Installing as a plugin doesn't change this. A plugin can ship skills, agents, and
hooks, but it can't write to your `CLAUDE.md` — that line stays yours to add.

## Languages

| Skill | Language | Plugin name | Invoke |
|---|---|---|---|
| [`skills/concise`](skills/concise/SKILL.md) | English | `concise` | `/concise:concise` |
| [`skills/respostas-curtas`](skills/respostas-curtas/SKILL.md) | Portuguese (BR) | `respostas-curtas` | `/respostas-curtas:respostas-curtas` |

Installed by copy rather than as a plugin, they invoke unprefixed: `/concise`
and `/respostas-curtas`.

Install one, not both — they're the same ruleset and would compete. The rules are
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
