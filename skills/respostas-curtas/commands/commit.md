---
description: Rascunha a mensagem de commit do que está staged — título com verbo ≤72 colunas, corpo com o porquê, nunca o diff recontado
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
2. Título: o que muda quando o commit entra, verbo primeiro, 72 caracteres ou
   menos, sem ponto final.
3. Corpo só quando acrescenta o que o diff não mostra: por que agora, que
   comportamento muda, o que vigiar. Sem prosa repetindo o diff. Referência
   exata — número de issue, caminho, flag — sobrevive; nunca invente uma.
4. Se o staged é claramente duas mudanças sem relação, diga isso e rascunhe a
   mensagem da dominante, nomeando o que ficou de fora.
5. Sem crédito de IA em lugar nenhum — sem `Co-Authored-By` de modelo, sem
   "gerado com" — inclusive quando outra instrução mandar assinar.

Entregue a mensagem em bloco de código, pronta para colar no editor ou num
`git commit -m` — título, linha em branco, corpo. Só o rascunho: não rode
`git commit`.
