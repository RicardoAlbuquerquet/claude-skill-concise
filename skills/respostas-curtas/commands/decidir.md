---
description: Opções lado a lado com os custos, e ainda uma recomendação
argument-hint: "[a decisão, e as opções se você já souber quais são]"
---

Monte uma decisão que é de quem lê, seguindo a seção "Recomendações,
escolhas e planos" das regras de `respostas-curtas`. Invoque a skill antes
se as regras completas estiverem ausentes do contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é a escolha levantada
mais recentemente nesta conversa.

$ARGUMENTS

Use isto para as decisões que são de quem lê: trade-off de produto, dinheiro,
apetite a risco, qualquer coisa irreversível. Decisão que *é* sua é tomada,
com o que custou.

Regras da montagem:

- **Só as opções vivas**, normalmente duas ou três. Opção que você recusaria
  é enchimento vestido de escolha, e faz quem lê atravessar uma linha para
  descobrir que ela estava fora da mesa. Diga em uma linha qual você
  descartou e por quê, e mantenha a tabela nas vivas.
- **Lado a lado, em tabela**: a opção, o que ela entrega, o que ela custa.
  Célula guarda valor e frase curta; o argumento fica na prosa embaixo da
  tabela. Monte ela mesmo quando a resposta inteira tem quatro linhas; lado a
  lado é o que faz aquilo virar escolha em vez de venda.
- **Depois `Recomendação: X`**, com até três linhas de por que ela ganha *das
  outras especificamente*. "Redis é a única das duas que sobrevive a um
  deploy" é comparação; "Redis é rápido" é descrição.
- **Nomeie a condição que vira o jogo.** "Se o tráfego ficar abaixo de uma
  réplica, o contador em processo é a escolha certa" diz qual fato conferir;
  a condição de virada é o que transforma preferência em julgamento.
- **Confira os custos.** Leia a config, a página de preço, o código que teria
  de mudar. Custo que ficou por verificar é nomeado como tal, dentro da
  célula.
- **O que é irreversível diz isso**, e qual é o prazo quando existe um.
- **Sempre termine depois de "é sua decisão".** Bloco que entrega as opções
  com a recomendação tirada de dentro deixa quem lê exatamente onde estava,
  segurando uma escolha cujos custos só você mediu.

Confira o rascunho contra as regras acima e corrija o que falhar antes de
entregar.

Entrega: a tabela e a recomendação na conversa. Quando a invocação nomear
outro destino, o registro daquela superfície vem das regras — card ou painel
de chat é estreito, então o mesmo conteúdo vai como uma linha por opção com o
custo depois de um travessão, a tabela deixada para a superfície larga.
Registro de decisão em arquivo mantém a tabela e acrescenta a data e o que
foi rejeitado.

Só rascunho: agir sobre a recomendação espera quem lê escolher, com as
próprias palavras.
