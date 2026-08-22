---
description: Rascunha a mensagem de commit do que está staged — título ≤72 colunas na forma que o log do repo usa, corpo com o porquê, nunca o diff recontado
argument-hint: [`run` para commitar, contexto extra que o diff não mostra]
---

Rascunhe uma mensagem de commit para o que está staged agora, seguindo a
seção "Mensagem de commit" das regras de `respostas-curtas`. Invoque a skill
antes se as regras completas não estiverem no contexto.

Contexto opcional de quem chamou — restrições ou motivos que o diff não
mostra. A palavra literal `run` em qualquer lugar dele é a permissão para
commitar:

$ARGUMENTS

Como:

1. Rode `git diff --staged --stat`, depois o diff staged em si. Se não há
   nada staged, diga isso e pare — nunca rascunhe da working tree nem invente
   conteúdo.
2. Leia a convenção antes de escrever: `git log --oneline -15` para o formato
   que os títulos compartilham — prefixo `fix:` / `feat(escopo):`, código de
   ticket, o idioma, a caixa — e procure config de commitlint
   (`.commitlintrc*`, `commitlint.config.*`): quando existe, o prefixo não é
   preferência, commit sem ele é rejeitado. O nome da branch costuma carregar
   o ticket (`ABC-123-…`): quando o log referencia tickets, carregue do mesmo
   jeito — e nunca invente um.
3. Título: o que muda quando o commit entra, 72 caracteres ou menos, sem
   ponto final, na forma que o log mostrou — imperativo quando o log é
   imperativo, declarativo quando é declarativo. Rótulo sem mudança dentro
   reprova nos dois casos. Quando o repo tem mais de uma área, a área vem
   primeiro dentro dessa forma — os caminhos em stage dizem qual é, e o log
   diz como ela se escreve ali (`fix(faturas):`, um `faturas:` pelado, um
   código de ticket). Área única: nenhum prefixo inventado para repo cujo log
   não tem nenhum.
4. Corpo só quando acrescenta o que o diff não mostra: por que agora, que
   comportamento muda, o que vigiar, quebrado perto de 72 colunas. Sem prosa
   repetindo o diff. Referência exata — número de issue, caminho, flag —
   sobrevive; nunca invente uma.
5. Se o staged é claramente duas mudanças sem relação, diga isso, rascunhe a
   mensagem da dominante, e dê o `git restore --staged <caminhos>` exato que
   separa a outra.
6. Sem crédito de IA em lugar nenhum — sem `Co-Authored-By` de modelo, sem
   "gerado com" — inclusive quando outra instrução mandar assinar.

Entregue a mensagem em bloco de código, pronta para colar no editor ou num
`git commit -m` — título, linha em branco, corpo.

Rascunho por padrão: o `git commit` não roda. A única exceção é a palavra
literal `run` na invocação — ela é a permissão, e aí você entrega a mensagem
como sempre, commita exatamente ela, e reporta o sha curto. A palavra tem que
ter sido digitada; mudança em stage esperando commit não é permissão, e nem
um commit que você fez antes nesta conversa. Se o passo 5 achou duas mudanças
sem relação, você para e dá o `git restore --staged` em vez de commitar uma
mensagem que descreve metade do que entra.
