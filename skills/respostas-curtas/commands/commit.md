---
description: Rascunha a mensagem de commit do que está staged — `run` commita
argument-hint: "[`run` para commitar, contexto extra que o diff não mostra]"
---

Rascunhe uma mensagem de commit para o que está staged agora. Leia
`${CLAUDE_PLUGIN_ROOT}/referencias/commit.md` antes: as regras moram lá, e
aqui só o procedimento.

Contexto opcional de quem chamou — restrições ou motivos que o diff não
mostra. A palavra literal `run` em qualquer ponto é a permissão para commitar:

$ARGUMENTS

Como:

1. `git diff --staged --stat`, depois o diff staged em si. Nada staged: diga
   isso e pare — nunca rascunhe a partir da árvore de trabalho.
2. `git log --oneline -15` pela forma que os títulos compartilham — prefixo,
   código de ticket, idioma, caixa — e uma config de commitlint
   (`.commitlintrc*`, `commitlint.config.*`), onde o prefixo não é
   preferência. Quando o log carrega tickets, o nome da branch em geral tem
   este (`ABC-123-…`); nunca invente um.
3. Que área os caminhos staged tocam, quando o repo tem mais de uma, e como o
   log escreve isso (`fix(faturas):`, um `faturas:` seco, código de ticket).
   Uma área só: sem prefixo inventado para repo cujo log não tem.
4. Escreva como a referência diz; conte as linhas do corpo antes de entregar.
5. Duas mudanças sem relação staged: diga isso, rascunhe a mensagem da
   dominante, e dê o `git restore --staged <caminhos>` exato que separa a
   outra.

Entregue a mensagem num bloco de código, pronta para o editor ou para
`git commit -m` — título, linha em branco, corpo.

Rascunho por padrão: `git commit` não roda. A única exceção é a palavra
literal `run` na invocação — aí você entrega a mensagem como sempre, commita
exatamente ela, e reporta o sha curto. A palavra tem que ser digitada;
mudanças staged esperando não são permissão, nem um commit que você fez
antes. Se o passo 5 achou duas mudanças sem relação, você para e dá o
`git restore --staged` em vez de commitar uma mensagem que descreve metade
do que entra.
