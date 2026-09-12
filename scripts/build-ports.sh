#!/usr/bin/env bash
# Builds ports/ from the two plugins: the same rules delivered as AGENTS.md,
# as Cursor rules and as Cursor commands. One source, so a rule edited in the
# skill reaches every tool; ports/ is committed so a user copies a file
# instead of running a build.
#
#   bash scripts/build-ports.sh           # regenerate ports/
#   bash scripts/build-ports.sh --check   # fail when ports/ is behind (CI)
#
# The ChatGPT files are written by hand — a 1,500-character box holds a
# compression, not a concatenation — so the build leaves them alone and only
# holds them to their size.
set -u

cd "$(dirname "$0")/.." || exit 1
ROOT=$PWD
URL=https://github.com/RicardoAlbuquerquet/claude-skill-concise

MODE=write
[ "${1:-}" = "--check" ] && MODE=check

TMP="${TMPDIR:-/tmp}/concise-ports.$$"
rm -rf "$TMP"; mkdir -p "$TMP"
trap 'rm -rf "$TMP"' EXIT

EXPECTED="$TMP/expected.txt"; : > "$EXPECTED"
fail=0

# Files under ports/ that this script never writes: the two READMEs and the
# four ChatGPT boxes.
authored () {
  case $1 in
    README.md|README.pt-BR.md) return 0 ;;
    en/chatgpt/*.md|pt-BR/chatgpt/*.md) return 0 ;;
  esac
  return 1
}

# A leading YAML frontmatter block is metadata for the tool that reads it, and
# every tool here reads a different one — so it goes, and what follows stays.
body () {
  if [ "$(head -1 "$1" | tr -d '\r')" = "---" ]; then
    awk 'BEGIN{n=0} /^---\r?$/{n++; next} n>=2' "$1" | sed '/./,$!d'
  else
    cat "$1"
  fi
}

# Writes one generated file, recording it so --check can diff exactly these
# paths and spot a leftover from a command that was renamed.
emit () { # $1 = path under ports/, stdin = content
  printf '%s\n' "$1" >> "$EXPECTED"
  mkdir -p "$TMP/ports/$(dirname "$1")"
  # A Windows checkout hands the sources CRLF, and a generated file that
  # changes shape with the builder's machine is a diff nobody can review.
  tr -d '\r' > "$TMP/ports/$1"
}

# --------------------------------------------------------- substitutions ----
# The rules name the plugin that carries them — the skill, `references/`, the
# `/concise:` prefix — and each of those names something a Cursor or Codex
# user has under another name. Every delivery gets the names it can act on.

rules_pl () { # $1 = lang, $2 = agents|cursor  -> path to a perl program
  out="$TMP/rules-$1-$2.pl"
  if [ "$1" = en ]; then
    case $2 in
      agents) repl='`concise/$1.md`'
              close='The rest of the ruleset sits beside this file, in the table below; read the one that matches whenever the turn calls for more than the trivial.' ;;
      *)      repl='`.cursor/rules/concise-$1.mdc`'
              close='The full ruleset is in `.cursor/rules/concise-full.mdc`; read it whenever the turn calls for more than the trivial.' ;;
    esac
    {
      printf 's{Response style, active for the whole session \\(skill `concise`\\):}{Response style, active for the whole session:}g;\n'
      printf 's{`references/([a-z-]+)\\.md`}{%s}g;\n' "$repl"
      printf 's{Full ruleset in the `concise` skill; invoke it whenever the turn calls for\\s+more than the trivial\\.}{%s}gs;\n' "$close"
      printf 's{/concise:}{/}g;\n'
    } > "$out"
  else
    case $2 in
      agents) repl='`respostas-curtas/$1.md`'
              close='O resto das regras fica ao lado deste arquivo, na tabela abaixo; leia o que casa quando o turno pedir mais que o trivial.' ;;
      *)      repl='`.cursor/rules/respostas-curtas-$1.mdc`'
              close='As regras completas estão em `.cursor/rules/respostas-curtas-completo.mdc`; leia quando o turno pedir mais que o trivial.' ;;
    esac
    {
      printf 's{Estilo de resposta, ativo em toda a sessão \\(skill `respostas-curtas`\\):}{Estilo de resposta, ativo em toda a sessão:}g;\n'
      printf 's{`referencias/([a-z-]+)\\.md`}{%s}g;\n' "$repl"
      printf 's{Regras completas na skill `respostas-curtas`; invoque-a quando o turno pedir\\s+mais que o trivial\\.}{%s}gs;\n' "$close"
      printf 's{/respostas-curtas:}{/}g;\n'
    } > "$out"
  fi
  printf '%s' "$out"
}

cmds_pl () { # $1 = lang  -> path to a perl program
  out="$TMP/cmds-$1.pl"
  if [ "$1" = en ]; then
    cat > "$out" <<'PL_EN'
s{\$\{CLAUDE_PLUGIN_ROOT\}/references/([a-z-]+)\.md}{.cursor/rules/concise-$1.mdc}g;
s{\$\{CLAUDE_PLUGIN_ROOT\}/references/}{.cursor/rules/}g;
s{invoke\s+the\s+`concise`\s+skill\s+first}{read `.cursor/rules/concise-full.mdc` first}g;
s{Invoke\s+the\s+skill\s+first}{Read `.cursor/rules/concise-full.mdc` first}g;
s{— Read the file if given a path}{— read the file if given a path}g;
s{/concise:}{/}g;
s{\$ARGUMENTS}{(Your arguments: whatever you typed after the command name, when there was any.)}g;
PL_EN
  else
    cat > "$out" <<'PL_PT'
s{\$\{CLAUDE_PLUGIN_ROOT\}/referencias/([a-z-]+)\.md}{.cursor/rules/respostas-curtas-$1.mdc}g;
s{\$\{CLAUDE_PLUGIN_ROOT\}/referencias/}{.cursor/rules/}g;
s{invoque\s+a\s+skill\s+`respostas-curtas`\s+primeiro}{leia `.cursor/rules/respostas-curtas-completo.mdc` antes}g;
s{Invoque\s+a\s+skill\s+antes}{Leia `.cursor/rules/respostas-curtas-completo.mdc` antes}g;
s{— leia com Read se vier\s+caminho}{— leia o arquivo se vier caminho}gs;
s{/respostas-curtas:}{/}g;
s{\$ARGUMENTS}{(Seus argumentos: o que você digitou depois do nome do comando, quando houver.)}g;
PL_PT
  fi
  printf '%s' "$out"
}

# ---------------------------------------------------------------- per port --
# $1 dir  $2 lang  $3 plugin name  $4 core file  $5 refs dir  $6 basename of
# the full ruleset in that language  $7 the word that opens a command's steps
port () {
  DIR=$1; LANG=$2; NAME=$3; CORE=$4; REFS=$5; FULL=$6; HOWLINE=$7
  S="$ROOT/skills/$DIR"
  P="$LANG"
  AG=$(rules_pl "$LANG" agents)
  CU=$(rules_pl "$LANG" cursor)
  CM=$(cmds_pl "$LANG")

  agents_text () { body "$1" | perl -0777 -p "$AG"; }
  cursor_text () { body "$1" | perl -0777 -p "$CU"; }
  portable ()    { body "$1" | perl -0777 -p "$CM"; }

  # -- AGENTS.md: the core, plus where the rest of the ruleset sits ----------
  if [ "$LANG" = en ]; then
    { cat <<EOF
# Writing style

Every reply, and every text that leaves the conversation — a commit message, a
pull request description, a task, a review comment, a release note, the text
inside the code — follows the rules below.

A name like \`/pr\` or \`/commit\` names one of the commands that ship with
these rules. Where your tool has no such command, read the file named beside
it and write the text yourself.

EOF
      agents_text "$S/hooks/$CORE"
      cat <<EOF

## Where the rest of the ruleset sits

The rules above are the whole style for a short reply. Everything longer, and
every surface that leaves the conversation, has its own file next to this one:

| Writing | Read |
|---|---|
| A reply past a line or two — budgets, structure, drawings, recommendations | \`$NAME/$FULL.md\` |
| A pull request description | \`$NAME/pull-request.md\` |
| A task or an issue | \`$NAME/task.md\` |
| A commit message | \`$NAME/commit.md\` |
| A changelog entry or release notes | \`$NAME/changelog.md\` |
| A comment, a reply or a message to a person | \`$NAME/comment.md\` |
| Comments, messages or screen text in code | \`$NAME/code.md\` |

With those files absent, the intentions above still govern.

Source, and the Claude Code plugin these are generated from: $URL
EOF
    } | emit "$P/AGENTS.md"
  else
    { cat <<EOF
# Estilo de escrita

Toda resposta, e todo texto que sai da conversa — mensagem de commit, descrição
de PR, tarefa, comentário de revisão, nota de release, o texto dentro do
código — segue as regras abaixo.

Um nome como \`/pr\` ou \`/commit\` é um dos comandos que vêm junto com estas
regras. Onde a sua ferramenta não tiver esse comando, leia o arquivo nomeado
ao lado dele e escreva o texto você mesmo.

EOF
      agents_text "$S/hooks/$CORE"
      cat <<EOF

## Onde mora o resto das regras

As regras acima são o estilo inteiro de uma resposta curta. Tudo que passa
disso, e toda superfície que sai da conversa, tem arquivo próprio ao lado
deste:

| Escrevendo | Leia |
|---|---|
| Resposta que passa de uma linha — orçamentos, estrutura, desenhos, recomendações | \`$NAME/$FULL.md\` |
| Descrição de pull request | \`$NAME/pr.md\` |
| Tarefa ou issue | \`$NAME/tarefa.md\` |
| Mensagem de commit | \`$NAME/commit.md\` |
| Entrada de changelog ou nota de release | \`$NAME/changelog.md\` |
| Comentário, resposta em thread ou recado para uma pessoa | \`$NAME/comentario.md\` |
| Comentário, mensagem ou texto de tela dentro do código | \`$NAME/codigo.md\` |

Com esses arquivos ausentes, as intenções acima continuam valendo.

Fonte, e o plugin de Claude Code de onde isto é gerado: $URL
EOF
    } | emit "$P/AGENTS.md"
  fi

  # -- the ruleset and the six surfaces, as plain files next to AGENTS.md ----
  agents_text "$S/SKILL.md" | emit "$P/$NAME/$FULL.md"
  for f in "$S/$REFS"/*.md; do
    agents_text "$f" | emit "$P/$NAME/$(basename "$f")"
  done

  # -- Cursor rules ---------------------------------------------------------
  # alwaysApply carries the core into every request, the way the forced output
  # style does in Claude Code; the rest wait for their description to match.
  # The description is quoted because every one of them holds a colon, and a
  # bare colon inside a YAML scalar ends the parse.
  mdc () { # $1 = description, $2 = alwaysApply, stdin = body
    printf -- '---\ndescription: "%s"\nalwaysApply: %s\n---\n\n' "$1" "$2"
    cat
  }

  if [ "$LANG" = en ]; then
    cursor_text "$S/hooks/$CORE" |
      mdc "Response style for every reply: the answer in the first sentence, nothing padding it, every caveat that changes what the reader does kept" true |
      emit "$P/cursor/rules/$NAME.mdc"
    cursor_text "$S/SKILL.md" |
      mdc "The full concise ruleset: budgets per situation, what always keeps, what always cuts, structure, drawings, recommendations, plans" false |
      emit "$P/cursor/rules/$NAME-$FULL.mdc"
  else
    cursor_text "$S/hooks/$CORE" |
      mdc "Estilo de resposta em toda mensagem: a resposta na primeira frase, nada enchendo, toda ressalva que muda o que a pessoa faz mantida" true |
      emit "$P/cursor/rules/$NAME.mdc"
    cursor_text "$S/SKILL.md" |
      mdc "As regras completas de respostas-curtas: orçamentos por situação, o que sempre fica, o que sempre corta, estrutura, desenhos, recomendações, planos" false |
      emit "$P/cursor/rules/$NAME-$FULL.mdc"
  fi

  for f in "$S/$REFS"/*.md; do
    b=$(basename "$f" .md)
    case "$LANG:$b" in
      en:pull-request) d="Rules for a pull request description: the problem first, what was done, and the exact test command last" ;;
      en:task)         d="Rules for a task or issue card that stands alone: current behaviour, expected behaviour, exact values, a done criterion" ;;
      en:commit)       d="Rules for a commit message: a title in the shape the repo log uses, a body that says why" ;;
      en:changelog)    d="Rules for a changelog entry and release notes: what breaks first, with the migration beside it" ;;
      en:comment)      d="Rules for a review comment, a thread reply or a message to a person: the claim, then the line that proves it" ;;
      en:code)         d="Rules for the text inside code: a comment says what the code leaves unsaid, a screen says each thing once" ;;
      pt-BR:pr)         d="Regras da descrição de pull request: o problema primeiro, o que foi feito, e o comando de teste exato no fim" ;;
      pt-BR:tarefa)     d="Regras do card de tarefa ou issue que se sustenta sozinho: comportamento atual, esperado, valores exatos, critério de pronto" ;;
      pt-BR:commit)     d="Regras da mensagem de commit: título na forma que o log do repositório usa, corpo que diz o porquê" ;;
      pt-BR:changelog)  d="Regras da entrada de changelog e da nota de release: o que quebra primeiro, com a migração ao lado" ;;
      pt-BR:comentario) d="Regras do comentário de revisão, resposta em thread ou recado para uma pessoa: a afirmação, e depois a linha que prova" ;;
      pt-BR:codigo)     d="Regras do texto dentro do código: comentário diz o que o código deixa por dizer, tela diz cada coisa uma vez" ;;
      *) d="" ;;
    esac
    cursor_text "$f" | mdc "$d" false | emit "$P/cursor/rules/$NAME-$b.mdc"
  done

  # -- Cursor commands ------------------------------------------------------
  for f in "$S/commands"/*.md; do
    n=$(basename "$f" .md)
    if [ "$n" = audit ] || [ "$n" = auditar ]; then
      # Claude Code hands this to a subagent that holds the checklist. With no
      # subagent to hand it to, the checklist comes inline: the command keeps
      # its opening — how to find the text — and the agent supplies the rest.
      {
        portable "$f" | perl -0777 -ne "print \$1 if /(.*?)\n$HOWLINE\n/s"
        echo
        portable "$S/agents/$n.md"
      } | emit "$P/cursor/commands/$n.md"
    else
      portable "$f" | emit "$P/cursor/commands/$n.md"
    fi
  done
}

port concise          en    concise          core.md   references  full     'How:'
port respostas-curtas pt-BR respostas-curtas nucleo.md referencias completo 'Como:'

# ------------------------------------------------------------------ verify --
if [ "$MODE" = check ]; then
  while read -r rel; do
    # CRLF in the checked-out copy is the checkout's doing, not a drift — the
    # same normalization check-parity.sh applies for the same reason.
    if cmp -s "$TMP/ports/$rel" <(tr -d '\r' < "$ROOT/ports/$rel" 2>/dev/null); then
      printf '%-46s ok\n' "$rel"
    else
      printf '%-46s DRIFT — run bash scripts/build-ports.sh\n' "$rel"; fail=1
    fi
  done < "$EXPECTED"
  # A command renamed upstream leaves its old file behind, still installable
  # and no longer matching anything in the skill.
  if [ -d "$ROOT/ports" ]; then
    (cd "$ROOT/ports" && find . -type f | sed 's#^\./##') | while read -r rel; do
      grep -qxF "$rel" "$EXPECTED" && continue
      authored "$rel" && continue
      printf '%-46s STRAY — not generated and not authored\n' "$rel"
      echo stray >> "$TMP/stray"
    done
    [ -f "$TMP/stray" ] && fail=1
  fi
else
  while read -r rel; do
    mkdir -p "$ROOT/ports/$(dirname "$rel")"
    cp "$TMP/ports/$rel" "$ROOT/ports/$rel"
  done < "$EXPECTED"
  if [ -d "$ROOT/ports" ]; then
    (cd "$ROOT/ports" && find . -type f | sed 's#^\./##') | while read -r rel; do
      grep -qxF "$rel" "$EXPECTED" && continue
      authored "$rel" && continue
      rm -f "$ROOT/ports/$rel"
      printf 'removed  %s\n' "$rel"
    done
  fi
  printf '%s file(s) written under ports/\n' "$(wc -l < "$EXPECTED" | tr -d ' ')"
fi

# The plugin's own names reach a tool that has none of them: a path under
# `references/`, the `/concise:` prefix, `$ARGUMENTS`, the skill to invoke.
# Each one is an instruction the reader cannot follow. Generated files only —
# the two READMEs name this syntax for a living, and a guard that flags the
# document explaining it is the false positive this repo keeps rediscovering.
leftovers=""
while read -r rel; do
  grep -qE '\$ARGUMENTS|CLAUDE_PLUGIN_ROOT|/concise:|/respostas-curtas:|`referenc' "$TMP/ports/$rel" 2>/dev/null &&
    leftovers="$leftovers $rel"
done < "$EXPECTED"
if [ -n "$leftovers" ]; then
  printf 'LEFTOVER plugin syntax in: %s\n' "$leftovers"; fail=1
else
  printf '%-46s ok\n' 'no plugin syntax left in ports/'
fi

# Cursor reads a rule's frontmatter and drops the rule when it cannot parse
# it, with nothing on screen. Every description here carries a colon, which
# ends a bare YAML scalar, so the quotes are load-bearing and checked.
badmdc=""
while read -r rel; do
  case $rel in *.mdc) ;; *) continue ;; esac
  head -4 "$TMP/ports/$rel" | awk '
    NR==1 && $0 != "---"                             { bad=1 }
    NR==2 && $0 !~ /^description: "[^"]+"$/          { bad=1 }
    NR==3 && $0 !~ /^alwaysApply: (true|false)$/     { bad=1 }
    NR==4 && $0 != "---"                             { bad=1 }
    END { exit bad+0 }' || badmdc="$badmdc $rel"
done < "$EXPECTED"
if [ -n "$badmdc" ]; then
  printf 'UNPARSEABLE frontmatter in:%s\n' "$badmdc"; fail=1
else
  printf '%-46s ok\n' 'every .mdc frontmatter parses'
fi

# A box that rejects the paste is a port that does not work, so the size is a
# gate rather than a note. The numbers are ChatGPT's own: 1,500 characters for
# the custom-instructions field, 8,000 for a project or a custom GPT.
size () { # $1 = path under ports/, $2 = ceiling
  [ -f "$ROOT/ports/$1" ] || { printf '%-46s missing\n' "$1"; fail=1; return; }
  n=$(tr -d '\r' < "$ROOT/ports/$1" | wc -c | tr -d ' ')
  if [ "$n" -le "$2" ]; then printf '%-46s %6s / %s  ok\n' "$1" "$n" "$2"
  else printf '%-46s %6s / %s  OVER\n' "$1" "$n" "$2"; fail=1; fi
}

size en/chatgpt/custom-instructions.md          1500
size en/chatgpt/project-instructions.md         8000
size pt-BR/chatgpt/instrucoes-personalizadas.md 1500
size pt-BR/chatgpt/instrucoes-de-projeto.md     8000

exit $fail
