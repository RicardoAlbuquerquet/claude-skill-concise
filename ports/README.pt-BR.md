# Ports

As mesmas regras, para as ferramentas que não são o Claude Code. Tudo aqui,
menos este arquivo, o gêmeo em inglês e os quatro arquivos do ChatGPT, é
gerado de `skills/` pelo [`scripts/build-ports.sh`](../scripts/build-ports.sh),
e o CI falha quando um arquivo gerado fica para trás da skill de onde veio.

Dois idiomas, `en/` e `pt-BR/` — escolha um, como se escolhe um plugin. Todo
comando abaixo está escrito para `pt-BR/`; troque o diretório para o outro.

## Cursor

```bash
mkdir -p .cursor/rules .cursor/commands && cp ports/pt-BR/cursor/rules/*.mdc .cursor/rules/ && cp ports/pt-BR/cursor/commands/*.md .cursor/commands/
```

```powershell
New-Item -ItemType Directory -Force .cursor\rules, .cursor\commands | Out-Null; Copy-Item ports\pt-BR\cursor\rules\*.mdc .cursor\rules\; Copy-Item ports\pt-BR\cursor\commands\*.md .cursor\commands\
```

O `respostas-curtas.mdc` leva `alwaysApply: true`, então o núcleo entra em
toda request — o mesmo trabalho que o output style forçado faz no Claude Code.
Os outros sete esperam a descrição casar com o que você está fazendo: o
`respostas-curtas-completo.mdc` para as regras inteiras, e um arquivo por
superfície que sai da conversa (`respostas-curtas-pr.mdc`,
`respostas-curtas-commit.mdc`, e mais quatro).

Os treze comandos aparecem quando você digita `/` no chat, com o nome pelado:
`/pr`, `/card`, `/commit`, `/comentario`, `/release`, `/plano`, `/decidir`,
`/desenhar`, `/status`, `/passagem`, `/reescrever`, `/enxugar`, `/auditar`.

O Cursor também lê `AGENTS.md`, então a seção abaixo funciona lá como
instalação mais leve — regras e comandos são a completa.

## AGENTS.md

Lido pelo Codex, pelo agente de código do Copilot, Zed, Gemini CLI, Windsurf,
Aider, Jules e o resto da família `AGENTS.md`, e pelo Cursor:

```bash
cp ports/pt-BR/AGENTS.md . && cp -r ports/pt-BR/respostas-curtas .
```

```powershell
Copy-Item ports\pt-BR\AGENTS.md .; Copy-Item -Recurse ports\pt-BR\respostas-curtas .
```

O `AGENTS.md` guarda o núcleo e uma tabela dizendo que arquivo ler para
qualquer coisa maior — `respostas-curtas/completo.md` para as regras inteiras,
`respostas-curtas/pr.md` e os cinco irmãos dele para as superfícies. Copiar só
o `AGENTS.md` ainda deixa um estilo funcionando; a pasta é o que a tabela
aponta.

Repositório que já tem um `AGENTS.md` recebe o conteúdo acrescentado no fim,
sob um cabeçalho próprio.

## ChatGPT

Dois arquivos, porque o ChatGPT tem dois lugares para eles:

| Arquivo | Onde entra | Teto |
|---|---|---|
| `ports/pt-BR/chatgpt/instrucoes-personalizadas.md` | Configurações → Personalização → Instruções personalizadas, na caixa sobre como o ChatGPT deve responder | 1.500 caracteres |
| `ports/pt-BR/chatgpt/instrucoes-de-projeto.md` | as instruções de um projeto, ou de um GPT personalizado | 8.000 caracteres |

O primeiro é uma compressão do núcleo — 1.500 caracteres é um quarto do que o
núcleo ocupa, então ele é escrito à mão em vez de gerado, e guarda a regra da
primeira frase, as duas listas e o custo de uma recomendação. O segundo leva o
estilo inteiro, os treze comandos como gatilhos digitados (`/pr`, `/commit`, …)
e as seis superfícies em resumo.

A build falha se um dos dois passar do teto, então regra nova lá em cima entra
aqui cabendo, em vez de a caixa cortar calada.

## O que fica para trás

O output style forçado, o lembrete por turno, a guarda de crédito, o desvio da
PR e a auto-atualização diária são maquinaria de plugin do Claude Code, e ficam
lá. No Cursor a metade sempre-ligada sobrevive como `alwaysApply: true`; no
ChatGPT como a caixa de instruções; no `AGENTS.md` como o arquivo que a
ferramenta carrega sozinha. O agente `auditar` não tem subagente onde rodar,
então o `/auditar` portátil leva o checklist inline em vez de repassar.

## Mudando uma regra

Edite a skill em `skills/`, depois:

```bash
bash scripts/build-ports.sh
```

Commite o que ele reescrever. `bash scripts/build-ports.sh --check` é o que o
CI roda, e ele também falha quando os nomes do próprio plugin —
`${CLAUDE_PLUGIN_ROOT}`, o prefixo `/respostas-curtas:`, `$ARGUMENTS` —
sobrevivem num arquivo cujo leitor não tem nenhum deles.
