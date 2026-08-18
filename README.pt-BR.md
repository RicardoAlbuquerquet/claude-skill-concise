# respostas-curtas

[![parity](https://github.com/RicardoAlbuquerquet/claude-skill-concise/actions/workflows/parity.yml/badge.svg)](https://github.com/RicardoAlbuquerquet/claude-skill-concise/actions/workflows/parity.yml)
[![version](https://img.shields.io/badge/dynamic/json?label=vers%C3%A3o&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FRicardoAlbuquerquet%2Fclaude-skill-concise%2Fmain%2Fskills%2Frespostas-curtas%2F.claude-plugin%2Fplugin.json)](CHANGELOG.md)
[![license](https://img.shields.io/badge/licen%C3%A7a-MIT-blue)](LICENSE)

**English:** [README.md](README.md)

Uma skill de Claude Code que faz o Claude responder no registro que um terminal
realmente quer: a resposta primeiro, nada enchendo, e nenhum sacrifício de
correção.

![A mesma pergunta respondida sem e com a skill](docs/before-after.svg)

## O problema

O registro padrão de escrita do Claude é expansivo. É um bom padrão numa janela
de chat e um ruim num terminal, onde aparece como:

- um preâmbulo antes da resposta (`"Ótima pergunta — deixa eu ver isso."`)
- cabeçalhos `##` sobre uma resposta de três linhas
- justificativa que ninguém pediu, depois de a resposta já ter sido dada
- narração da busca — quais arquivos foram lidos, em que ordem
- um cardápio de quatro opções quando se queria uma recomendação
- um aforismo de fechamento, porque o parágrafo pareceu pedir um pouso

Nada disso é errado. Tudo isso fica entre você e a resposta.

## O que ela faz

A skill instala uma regra — **a resposta vem na primeira frase, e depois dela só
o que muda uma decisão** — mais orçamentos explícitos por situação, uma lista de
construções para sempre cortar, e uma lista mais curta para *nunca* cortar.

A segunda lista é a parte que importa. Compressão é fácil de exagerar, e uma
resposta de uma linha que derrubou a ressalva sobre dados de produção é pior que
a versão inchada. A skill afirma sem rodeio que notícia ruim, risco, caminho ou
versão exatos, premissa falsa na pergunta e suposição não verificada sobrevivem
todos à edição.

Três regras correm no sentido contrário e *acrescentam* texto, porque o que
faltava era informação e não palavras:

- **Recomendação sempre sai com o custo dela.** Recomendação, ≤3 linhas de
  motivo, ≤3 linhas do que piora ou do que se abre mão. Recomendação sem
  desvantagem declarada ou tem uma que ninguém procurou ou está escondendo — e
  do lado de quem lê, o campo vazio é indistinguível de "examinei e é barato".
- **Quando a decisão é do usuário, as opções vão lado a lado**, e ainda assim
  você recomenda uma e diz por que ela ganha *das outras especificamente*.
  Decidir em silêncio uma questão de dinheiro ou risco é mais curto e não é seu.
- **Desenhe o formato.** Quando a resposta é uma sequência ou uma bifurcação, um
  diagrama ASCII de cinco linhas ganha do parágrafo que a pessoa teria que
  montar na cabeça.

A estrutura se julga pelo conteúdo, não pelo tamanho. Uma versão anterior
cortava cabeçalho e bullet de qualquer resposta com menos de seis linhas; esse
teste estava errado, porque media a resposta em vez do que há nela. A regra
agora: separe o que é genuinamente separado — duas funções ganham dois blocos,
comparação ganha tabela, caminho e termo técnico ganham code span — e nunca
fatie um pensamento só. Se você consegue dizer para que serve cada bloco, a
estrutura é real; se os blocos são "parte 1, parte 2", é enfeite.

Ela também fixa o público. A skill é escrita para quem é dono do produto mas não
é profundo na stack: mantenha o termo preciso e pague por ele uma vez, explicando
**pela consequência** e não pela definição — não "`timestamptz` é um tipo com
fuso" e sim "a coluna guarda em UTC, então filtro montado no horário local pede
uma janela que ainda não começou". Resposta em que a pessoa não consegue agir
não é concisa, é só curta.

Veja [`examples/before-after.md`](examples/before-after.md): nove transformações
reais. Quatro saem mais longas.

## Instalação

Dois comandos, digitados dentro de uma sessão aberta do Claude Code:

```
/plugin marketplace add RicardoAlbuquerquet/claude-skill-concise
```

```
/plugin install respostas-curtas@claude-skill-concise
```

**São comandos do Claude Code, não de shell.** Colados no PowerShell, bash ou
zsh, falham com `command not found` — a `/` na frente entrega. De um terminal,
use o CLI `claude`. Mesmo efeito, e igual no macOS, Linux e Windows:

```bash
claude plugin marketplace add RicardoAlbuquerquet/claude-skill-concise
```

```bash
claude plugin install respostas-curtas@claude-skill-concise
```

A forma por CLI instala no escopo de usuário e vale a partir do próximo início
do Claude Code, ou quando você rodar `/reload-plugins` numa sessão já aberta.

Troque `respostas-curtas` por `concise` para o original em inglês. Instale um,
não os dois — veja [Idiomas](#idiomas).

Skill de plugin ganha o prefixo do plugin que a embarca, então esta registra
como `/respostas-curtas:respostas-curtas`. Rode `/plugin` e abra a aba
**Installed** para ver o nome exato que ela tomou.

Atualizar depois leva dois comandos, não um — o primeiro atualiza o catálogo, o
segundo move a cópia que de fato roda:

```
/plugin marketplace update claude-skill-concise
/plugin update respostas-curtas@claude-skill-concise
```

```bash
claude plugin marketplace update claude-skill-concise
claude plugin update respostas-curtas@claude-skill-concise
```

Rodar só o primeiro é o erro comum: ele responde `✔ Successfully updated
marketplace` e a skill instalada fica exatamente onde estava. O segundo precisa
do marketplace dentro do nome — `claude plugin update respostas-curtas` sozinho
responde que o plugin não foi encontrado — e só move quando a release subiu a
`version`, porque ele compara números de versão e não conteúdo. Reinicie o
Claude Code depois, ou rode `/reload-plugins`.

Marketplace de terceiro vem com auto-update desligado. Para dispensar o
primeiro comando manual, ligue em `/plugin` → **Marketplaces** → **Enable
auto-update**.

**Desde a 1.4.0 o plugin roda o par sozinho.** Um segundo hook `SessionStart`
dispara os dois comandos em segundo plano a cada início de sessão, então uma
cópia instalada segue o marketplace com uma sessão de atraso — a sessão que
abre baixa a atualização, a seguinte roda com ela. Saiba o que isso implica
antes de confiar:

- Só move quando a release subiu a `version`, igual ao par manual — mudança sem
  bump na `main` nunca propaga.
- Custa uma ida à rede por início de sessão, e falha em silêncio sem o CLI
  `claude` no PATH ou sem rede — a próxima sessão simplesmente tenta de novo.
- Cópias na 1.3.0 ou antes ainda não têm o hook. Alcançar a 1.4.0 leva um
  update manual, ou o toggle do marketplace acima.
- Sair do auto-update mantendo a skill significa instalar por cópia — esse
  caminho não carrega hooks — ou desligar os hooks do plugin por inteiro.

### Copiando o arquivo

É um arquivo Markdown sem dependências, então copiar também funciona — e mantém
o `/respostas-curtas` sem prefixo. Esse é o caminho que muda por plataforma.

Clone primeiro, em qualquer uma das três:

```bash
git clone https://github.com/RicardoAlbuquerquet/claude-skill-concise.git
```

**macOS e Linux** — também Git Bash ou WSL no Windows:

```bash
mkdir -p ~/.claude/skills
cp -r claude-skill-concise/skills/respostas-curtas ~/.claude/skills/
```

**Windows**, no PowerShell:

```powershell
New-Item -ItemType Directory -Force -Path $HOME\.claude\skills | Out-Null
Copy-Item -Recurse claude-skill-concise\skills\respostas-curtas $HOME\.claude\skills\
```

Em nível de projeto, versionado com o repositório para o time compartilhar:
crie `.claude/skills/` na raiz do projeto e copie para dentro.

Confira que registrou digitando `/respostas-curtas` no Claude Code. Se não
aparecer, cheque o caminho: copiar para um `skills/` que ainda não existe
deixa o `SKILL.md` direto nele, um nível acima do certo, sem erro nenhum.

## Sempre ligada

**Uma skill sozinha não dispara em todo turno.** Skill é invocada — ou por você
digitando `/respostas-curtas`, ou pelo modelo decidindo que a `description`
combina com a tarefa. Uma regra de *estilo* de resposta quer valer em todos,
inclusive nos turnos em que nada na tarefa sugere "agora pense em brevidade".

**Instalada como plugin, isso já vem resolvido.** Desde a 1.3.0 cada plugin
embarca um hook `SessionStart` que imprime um núcleo de ~20 linhas do estilo no
contexto a cada início de sessão — uns 320 tokens, gastos produza a sessão
prosa ou não. O núcleo é a garantia; as regras completas continuam na skill,
que o modelo invoca quando o turno pede mais que o núcleo. O que é injetado é
um arquivo só:
[`hooks/nucleo.md`](skills/respostas-curtas/hooks/nucleo.md)
([`hooks/core.md`](skills/concise/hooks/core.md) no port em inglês).

Para podar ou reescrever na sua máquina, não edite a cópia do cache — desde a
1.4.0 o auto-update sobrescreve na release seguinte. Escreva
`~/.claude/respostas-curtas-nucleo-override.md`
(`~/.claude/concise-core-override.md` no port em inglês): quando esse arquivo
existe, o hook injeta ele no lugar do núcleo embarcado, e ele sobrevive a toda
atualização. Ele substitui o núcleo por inteiro — comece de uma cópia do
arquivo embarcado e corte.

Uma aresta de plataforma: no Windows o hook roda pelo Git Bash. Sem o Git for
Windows instalado ele falha em silêncio e você volta ao só-por-invocação — as
mesmas máquinas onde a própria ferramenta Bash do Claude Code não roda, então
na prática o hook funciona onde o resto funciona.

**Instalada por cópia, o hook não vem junto** — `~/.claude/skills/` leva só a
skill. Emparelhe com uma linha no `CLAUDE.md`, que é carregado no contexto a
cada sessão:

```markdown
## Estilo de escrita

Toda resposta para mim segue a skill `respostas-curtas`: resposta na primeira
frase, corte preâmbulo e narração de processo, mantenha toda ressalva que
mudaria o que eu faço.
```

A skill guarda as regras completas; o hook ou a linha no `CLAUDE.md` guarda o
ponteiro que garante que elas estão no contexto. Um não substitui o outro.

## Os comandos e o agente

Desde a 1.4.0 cada plugin também embarca ferramentas para texto que já existe —
a skill governa o que o Claude escreve a seguir; estas agem sobre o que está
escrito:

- **`/respostas-curtas:reescrever <texto>`** reescreve um texto pronto — uma
  descrição de PR, um corpo de issue, um e-mail — pelas regras, sem perder
  informação: todo valor exato e ressalva sobrevive, e o que o original
  *devia* (um custo faltando, um passo de teste faltando) ou é preenchido a
  partir do original ou é reportado como buraco, nunca inventado. Sem
  argumento, o alvo é a resposta anterior do próprio Claude. EN:
  `/concise:rewrite`.
- **`/respostas-curtas:pr [base]`** escreve a descrição da PR da branch atual
  a partir do diff real contra `origin/main` (ou a base que você nomear), com
  a primeira linha dizendo o que a PR faz e os passos de teste exatos no fim.
  EN: `/concise:pr`.
- **`/respostas-curtas:card <assunto>`** rascunha um card de tarefa/issue com
  corpo que se sustenta sozinho — comportamento atual → esperado, valores
  exatos, critério de pronto — e cria quando você nomeia um destino que uma
  ferramenta alcança (um board por MCP, um repo via `gh`). EN:
  `/concise:card`.
- **O agente `auditar`** (EN: `audit`) confere um rascunho contra o checklist
  e devolve só as violações — linha citada, regra, correção em uma linha —
  mais o conteúdo obrigatório que falta. Nunca reescreve; peça quando quiser o
  diagnóstico sem a cirurgia: *"rode o agente auditar nesse rascunho"*.

Tudo isso vem só com a instalação por plugin; o caminho da cópia leva a skill
sozinha.

Há também um **auditor de Stop opcional** em
[`extras/stop-audit/`](extras/stop-audit/README.md): um hook que você instala
à mão e que julga a resposta final de cada turno contra o núcleo, avisando em
violação clara. Custa uma chamada de API por turno — por isso não vem ligado.

## Idiomas

| Skill | Idioma | Nome do plugin | Invocação |
|---|---|---|---|
| [`skills/respostas-curtas`](skills/respostas-curtas/SKILL.md) | Português (BR) | `respostas-curtas` | `/respostas-curtas:respostas-curtas` |
| [`skills/concise`](skills/concise/SKILL.md) | Inglês | `concise` | `/concise:concise` |

Instaladas por cópia em vez de plugin, invocam sem prefixo:
`/respostas-curtas` e `/concise`.

Instale um, não os dois — são o mesmo conjunto de regras e competiriam, e desde
a 1.3.0 cada um embarca seu próprio hook, então os dois juntos injetam o núcleo
no contexto duas vezes. As regras são sobre estrutura, não vocabulário, então
uma tradução é um port fiel e não uma reescrita. Ports para outros idiomas são
bem-vindos.

## O critério para uma regra

Esta skill é um guia de estilo, o que a torna fácil demais de encher com
conselho que lê bem e não muda nada. Toda regra nela tem que passar dois testes:

1. **Conferível.** Regra que você não consegue verificar contra uma resposta
   pronta é decoração. `"um negrito por bloco"` é conferível; `"seja claro"`
   não é.
2. **Nomeia uma falha real.** A regra existe porque algo específico dá errado
   sem ela — de preferência algo que você consegue citar.

`"Seja breve"` falha nos dois e já está implícito nas instruções de qualquer
modelo. Por isso não está na skill.

Veja [CONTRIBUTING.md](CONTRIBUTING.md).

## Licença

MIT — veja [LICENSE](LICENSE).
