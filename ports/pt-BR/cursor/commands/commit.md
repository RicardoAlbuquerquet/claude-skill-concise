Rascunhe uma mensagem de commit para o que está staged agora. Leia
`.cursor/rules/respostas-curtas-commit.mdc` antes: as regras moram lá, e
aqui só o procedimento.

Contexto opcional de quem chamou — restrições ou motivos além do diff. A
palavra literal `run` em qualquer ponto é a permissão para commitar:

(Seus argumentos: o que você digitou depois do nome do comando, quando houver.)

Como:

1. `git diff --staged --stat`, depois o diff staged em si. Com o stage vazio,
   diga isso e pare — o rascunho vem só do stage.
2. `git log --oneline -15` pela forma que os títulos compartilham — prefixo,
   código de ticket, idioma, caixa — e uma config de commitlint
   (`.commitlintrc*`, `commitlint.config.*`), onde o prefixo é exigência.
   Quando o log carrega tickets, o nome da branch em geral tem este
   (`ABC-123-…`); ticket entra só quando a branch ou quem chamou deu.
3. Que área os caminhos staged tocam, quando o repo tem mais de uma, e como o
   log escreve isso (`fix(faturas):`, um `faturas:` seco, código de ticket).
   Uma área só: o título fica seco em repo cujo log é seco.
4. Escreva como a referência diz; conte as linhas do corpo antes de entregar.
5. Duas mudanças independentes staged: diga isso, rascunhe a mensagem da
   dominante, e dê o `git restore --staged <caminhos>` exato que separa a
   outra.

Entregue a mensagem num bloco de código, pronta para o editor ou para
`git commit -m` — título, linha em branco, corpo.

Rascunho por padrão: `git commit` roda só com a palavra literal `run` na
invocação — aí você entrega a mensagem como sempre, commita exatamente ela, e
reporta o sha curto. A palavra tem que ser digitada; mudanças staged
esperando, ou um commit que você fez antes, contam como contexto, e só a
palavra conta como permissão. Se o passo 5 achou duas mudanças
independentes, você para e dá o `git restore --staged`, e o commit espera uma
mensagem que descreva tudo que entra.
