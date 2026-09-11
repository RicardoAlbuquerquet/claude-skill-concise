---
description: Escreve a descrição da PR pelo diff real — `create` abre a PR
argument-hint: "[ref base, `create` para abrir a PR, contexto que o diff não mostra]"
---

Escreva a descrição da pull request da branch atual. Leia
`${CLAUDE_PLUGIN_ROOT}/referencias/pr.md` antes: as regras moram lá, e aqui
só o procedimento.

O argumento abaixo pode trazer uma ref base, contexto extra que o diff não
mostra — um id de card, uma restrição, um motivo — ou os dois. Uma primeira
palavra que `git rev-parse --verify` resolve é a base; a palavra literal
`create` em qualquer ponto é a permissão para abrir a PR; o resto é contexto.
Sem ref, a base é `origin/main`.

$ARGUMENTS

Como:

1. `git fetch`, depois `git log <base>..HEAD --oneline` — os títulos carregam
   o porquê — depois o diff `<base>...HEAD`: nomes de arquivo primeiro, o
   diff em si onde os nomes não bastam, e o suficiente dos arquivos mudados
   para descrever comportamento, não linhas. Sem commits sobre a base: diga
   isso e pare.
2. Procure o template: `.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE.md`, `docs/`, ou um diretório
   `.github/PULL_REQUEST_TEMPLATE/`.
3. Procure o card ou a issue que motivou a branch: na conversa, depois —
   quando `gh` ou um board por MCP alcança — buscando o assunto da branch.
   Não achou, sem referência, e sem travar perguntando.
4. Escreva como a referência diz. Feature sem tela ainda não desculpa passo
   de teste vago — o passo é a chamada direta, com rota e corpo.
5. Confira o rascunho contra a referência e corrija o que falha; acima de
   vinte e cinco linhas de prosa, o corte sai do que repete outra coisa,
   nunca de ressalva, valor ou bloco.

Entregue o título primeiro, numa linha só, pronto para
`gh pr create --title`; depois a descrição num bloco de código, pronta para
`--body` ou para o formulário do GitHub. **Cerque a entrega com quatro
crases**: a descrição carrega um bloco `bash` por regra, e uma cerca de três
crases termina nesse bloco interno. Nada depois do bloco além dos buracos que
você não conseguiu preencher pela branch, uma linha cada, abrindo com
**Faltou:**.

Rascunho por padrão: `gh pr create` não roda. A única exceção é a palavra
literal `create` na invocação — aí você entrega título e descrição como
sempre, roda `gh pr create` exatamente com eles, e reporta a URL. A palavra
tem que ser digitada: ref base, id de card, branch que obviamente quer uma PR
ou PR que você abriu antes não são permissão. O que tornaria a chamada errada
para antes dela — sem commits sobre a base, buraco que você não preencheu,
`gh` sem login, branch não empurrada — e você diz qual, com o rascunho
entregue mesmo assim.
