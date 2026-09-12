---
description: Escreve a descrição da PR pelo diff real — `create` abre a PR
argument-hint: "[ref base, `create` para abrir a PR, contexto além do diff]"
---

Escreva a descrição da pull request da branch atual. Leia
`${CLAUDE_PLUGIN_ROOT}/referencias/pr.md` antes: as regras moram lá, e aqui
só o procedimento.

O argumento abaixo pode trazer uma ref base, contexto além do que o diff
mostra — um id de card, uma restrição, um motivo — ou os dois. Uma primeira
palavra que `git rev-parse --verify` resolve é a base; a palavra literal
`create` em qualquer ponto é a permissão para abrir a PR; o resto é contexto.
Com a ref ausente, a base é `origin/main`.

$ARGUMENTS

Como:

1. `git fetch`, depois `git log <base>..HEAD --oneline` — os títulos carregam
   o porquê — depois o diff `<base>...HEAD`: nomes de arquivo primeiro, o
   diff em si onde os nomes ficam curtos, e o suficiente dos arquivos mudados
   para descrever comportamento em vez de linhas. Com zero commits sobre a
   base, diga isso e pare.
2. Procure o template: `.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE.md`, `docs/`, ou um diretório
   `.github/PULL_REQUEST_TEMPLATE/`.
3. Procure o card ou a issue que motivou a branch: na conversa, depois —
   quando `gh` ou um board por MCP alcança — buscando o assunto da branch.
   Achou, entra; senão a descrição sai com zero referências, e o trabalho
   segue.
4. Escreva como a referência diz. Feature cuja tela ainda vem depois ganha
   passo de teste do mesmo jeito — o passo é a chamada direta, com rota e
   corpo.
5. Confira o rascunho contra a referência e corrija o que falha; acima de
   vinte e cinco linhas de prosa, o corte sai do que repete outra coisa, e
   toda ressalva, valor e bloco fica.

Entregue o título primeiro, numa linha só, pronto para
`gh pr create --title`; depois a descrição num bloco de código, pronta para
`--body` ou para o formulário do GitHub. **Cerque a entrega com quatro
crases**: a descrição carrega um bloco `bash` por regra, e uma cerca de três
crases termina nesse bloco interno. Depois do bloco, só o que a branch
deixou em aberto — valor que os commits e o diff omitem — uma linha cada,
abrindo com **Faltou:**.

Rascunho por padrão: `gh pr create` roda só com a palavra literal `create` na
invocação — aí você entrega título e descrição como sempre, roda
`gh pr create` exatamente com eles, e reporta a URL. A palavra tem que ser
digitada: ref base, id de card, branch que obviamente quer uma PR ou PR que
você abriu antes contam como contexto, e só a palavra conta como permissão.
O que tornaria a chamada errada para antes dela — zero commits sobre a base,
buraco que a branch deixou em aberto, `gh` deslogado, branch ainda só local
— e você diz qual, com o rascunho entregue mesmo assim.
