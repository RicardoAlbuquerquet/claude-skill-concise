---
description: Rascunha a mensagem de commit do que está staged — título ≤72 colunas na forma que o log do repo usa, corpo com o porquê, nunca o diff recontado
argument-hint: [contexto extra que o diff não mostra — opcional]
---

Rascunhe uma mensagem de commit para o que está staged agora, seguindo a
seção "Mensagem de commit" das regras de `respostas-curtas`. Invoque a skill
antes se as regras completas não estiverem no contexto.

Contexto opcional de quem chamou — restrições ou motivos que o diff não
mostra:

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
   reprova nos dois casos.
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
`git commit -m` — título, linha em branco, corpo. Só o rascunho: não rode
`git commit`.
