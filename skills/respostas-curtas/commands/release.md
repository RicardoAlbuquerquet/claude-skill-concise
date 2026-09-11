---
description: Rascunha a entrada de changelog e o corpo da release — o que quebra primeiro
argument-hint: "[versão, um range de commits, ou contexto extra — opcional]"
---

Rascunhe a entrada de changelog e, quando uma release está sendo cortada, o
corpo dela. Leia `${CLAUDE_PLUGIN_ROOT}/referencias/changelog.md` antes: as
regras moram lá, e aqui só o procedimento.

O argumento abaixo pode trazer a versão a lançar, um range de commits, ou
contexto que os commits não mostram. Vazio, o range vai da última tag ao
`HEAD`.

$ARGUMENTS

Como:

1. O range: `git describe --tags --abbrev=0` para a última tag, depois
   `git log <tag>..HEAD --oneline`. Sem tags, `git log --oneline -30` e uma
   linha dizendo que range você assumiu. Range vazio: diga isso e pare.
2. O changelog existente, pela forma dele — cabeçalho, formato de data,
   agrupamento em `Added`/`Fixed` ou prosa, bullets ou parágrafos. Sem
   changelog: diga que forma você escolheu.
3. O diff, onde o título do commit não diz o que a pessoa vai ver — título
   escrito para o log costuma ser curto demais para ser entrada.
4. Escreva como a referência diz. O número da versão vem proposto com a única
   mudança que o força — quebra força a major, capacidade nova a minor, o
   resto a patch; a data vem de quem chamou ou do ambiente, nunca de chute.
   Sem voz de release note ("estamos muito felizes em"), que é fechamento
   com megafone.
5. Confira o rascunho contra a referência e corrija o que falha.

Entrega: a entrada de changelog primeiro, num bloco de código pronto para
colar no topo do arquivo — quatro crases quando uma entrada carrega um bloco
próprio, como um comando de migração carrega. Depois o corpo da release em
bloco próprio, só quando a invocação está cortando uma release: o mesmo
conteúdo mais o link de comparação e a linha de instalação que o arquivo não
precisa. Nada depois deles além dos valores que você não conseguiu
preencher, uma linha cada, abrindo com **Faltou:**.

Só rascunho: nunca rode `gh release create`, nunca empurre tag, e nunca
edite o arquivo de changelog sem o usuário pedir.
