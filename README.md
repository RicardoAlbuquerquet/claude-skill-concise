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
bloated version. The skill states outright that a risk, a cost, an exact path or
version, and an unverified assumption all survive the edit.

See [`examples/before-after.md`](examples/before-after.md) for four real
transformations, including one where the concise answer is deliberately the
*longer* of the two.

## Install

User-level, applies to every project:

```bash
git clone https://github.com/RicardoAlbuquerquet/claude-skill-concise.git
```

```bash
cp -r claude-skill-concise/skills/concise ~/.claude/skills/
```

PowerShell:

```powershell
Copy-Item -Recurse claude-skill-concise\skills\concise $HOME\.claude\skills\
```

Project-level instead, committed with the repo so your team shares it: copy into
`.claude/skills/` at the project root.

Verify it registered by typing `/concise` in Claude Code.

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

## Languages

| Skill | Language | Invoke |
|---|---|---|
| [`skills/concise`](skills/concise/SKILL.md) | English | `/concise` |
| [`skills/respostas-curtas`](skills/respostas-curtas/SKILL.md) | Portuguese (BR) | `/respostas-curtas` |

Install one, not both — they're the same ruleset and would compete. The rules are
about structure, not vocabulary, so a translation is a faithful port rather than
a rewrite. Ports to other languages are welcome.

## The bar for a rule

This skill is a style guide, which makes it unusually easy to fill with advice
that reads well and changes nothing. Every rule in it has to clear two tests:

1. **Checkable.** A rule you can't verify against a finished response is
   decoration. `"cut headers under ~6 lines"` is checkable; `"be clear"` is not.
2. **Names a real failure.** The rule should exist because a specific bad output
   happens without it — ideally one you can quote.

`"Be brief"` fails both and is already implicit in every model's instructions.
That's why it isn't in the skill.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
