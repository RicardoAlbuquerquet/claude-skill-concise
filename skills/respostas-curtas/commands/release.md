---
description: Rascunha a entrada de changelog e o corpo da release do que saiu — o que muda para quem instala, o que quebra primeiro, nunca o diff recontado
argument-hint: "[versão, um range de commits, ou contexto extra — opcional]"
---

Rascunhe a entrada de changelog e, quando uma release está sendo cortada, o
corpo dela, seguindo a seção "Changelog e notas de release" das regras de
`respostas-curtas`. Invoque a skill antes se as regras completas não
estiverem no contexto.

O argumento abaixo pode trazer a versão a lançar, um range de commits, ou
contexto que os commits não mostram. Vazio, o range é da última tag até
`HEAD`.

$ARGUMENTS

Como:

1. Estabeleça o range: `git describe --tags --abbrev=0` para a última tag,
   depois `git log <tag>..HEAD --oneline`. Sem tag no repo, caia para
   `git log --oneline -30` e diga em uma linha qual range você assumiu. Se o
   range está vazio, diga isso e pare — nunca rascunhe release do nada.
2. Leia o changelog existente antes de escrever: forma do cabeçalho, formato
   de data, se as entradas agrupam sob `Adicionado`/`Corrigido` ou correm em
   prosa, bullets ou parágrafos. O arquivo é a convenção, do mesmo jeito que
   o log é para o título de commit. Sem changelog no repo, diga qual forma
   você escolheu.
3. Leia o diff onde o título do commit não diz o que a pessoa vai ver. Título
   escrito para o log costuma ser curto demais para virar entrada, e adivinhar
   o efeito visível a partir do título é como uma nota de release acaba
   descrevendo algo que não foi entregue.
4. Uma entrada por comportamento que mudou. Refatoração interna não vira
   entrada; release sem nada visível diz isso em uma linha em vez de fabricar
   três.
5. O que quebra vem primeiro, com o que fazer a respeito na mesma entrada —
   quem atualiza e encontra a quebra três seções abaixo já quebrou alguma
   coisa.
6. Proponha o número da versão e nomeie a única mudança que força ele — quebra
   força o major, capacidade nova força o minor, o resto força o patch. A data
   vem de quem chamou ou do ambiente, nunca de um palpite.
7. Referência exata sobrevive: a flag, a configuração que mudou de lugar, o
   número da issue, o nome antigo que a pessoa vai procurar. Nunca invente uma.
8. Sem crédito de IA em lugar nenhum, e sem voz de nota de release —
   "melhorias empolgantes", "temos o prazer de" — que é postâmbulo com
   megafone.

Antes de entregar, audite o rascunho você mesmo — toda entrada nomeia uma
mudança que quem instala consegue observar, as que quebram no topo, nenhuma
entrada que só repete um título de commit, valores exatos presentes — e
corrija o que falhar. Entregue só a versão limpa.

Entrega: a entrada de changelog primeiro, em bloco de código pronta para colar
no topo do arquivo, com quatro crases quando a entrada carregar uma cerca
própria — um comando de migração carrega. Depois o corpo da release no bloco
dele, só quando a invocação está cortando uma release; é o mesmo conteúdo com
o link de comparação e a linha de instalação que o arquivo de changelog não
precisa. Nada depois deles além dos valores que você não conseguiu preencher,
uma linha cada, abrindo com **Faltou:**.

Só o rascunho: nunca rode `gh release create`, nunca empurre uma tag, e nunca
edite o arquivo de changelog sem o usuário pedir. Cortar a release é dele.
