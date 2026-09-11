---
description: Opções lado a lado com os custos, e ainda uma recomendação
argument-hint: "[a decisão, e as opções se você já souber quais são]"
---

Monte uma decisão que é de quem lê, seguindo a seção "Recomendações,
escolhas e planos" das regras de `respostas-curtas`. Invoque a skill antes se as regras
completas não estiverem no contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é a escolha levantada
mais recentemente nesta conversa.

$ARGUMENTS

Use isto para as decisões que não são suas: trade-off de produto, dinheiro,
apetite a risco, qualquer coisa irreversível. Decisão que *é* sua não ganha
menu — tome ela, e diga o que custou.

Regras da montagem:

- **Só as opções vivas**, normalmente duas ou três. Opção que você jamais
  tomaria é enchimento vestido de escolha, e faz quem lê atravessar uma linha
  para descobrir que ela não estava sendo oferecida. Diga em uma linha qual
  você descartou e por quê, em vez de engordar a tabela com ela.
- **Lado a lado, em tabela**: a opção, o que ela entrega, o que ela custa.
  Célula guarda valor e frase curta, não sentença — o argumento fica na prosa
  embaixo da tabela. Monte ela mesmo quando a resposta inteira tem quatro
  linhas; lado a lado é o que faz aquilo virar escolha em vez de venda.
- **Depois `Recomendação: X`**, com até três linhas de por que ela ganha *das
  outras especificamente*. "Redis é rápido" não é comparação; "Redis é a única
  das duas que sobrevive a um deploy" é.
- **Nomeie a condição que vira o jogo.** "Se o tráfego ficar abaixo de uma
  réplica, o contador em processo é a escolha certa" diz qual fato conferir;
  recomendação sem condição de virada lê como preferência.
- **Confira os custos, não os adivinhe.** Leia a config, a página de preço, o
  código que teria de mudar. Custo que você não verificou é nomeado como não
  verificado, dentro da célula, não arredondado em silêncio.
- **O que é irreversível diz isso**, e qual é o prazo quando existe um.
- **Nunca pare em "é sua decisão".** Bloco que entrega as opções e tira a
  recomendação de dentro deixa quem lê exatamente onde estava, segurando uma
  escolha cujos custos só você mediu.

Confira o rascunho contra as regras acima e corrija o que falhar antes de
entregar.

Entrega: a tabela e a recomendação na conversa. Quando a invocação nomear
outro destino, o registro daquela superfície vem das regras — card ou painel
de chat é estreito, então o mesmo conteúdo vai como uma linha por opção com o
custo depois de um travessão, sem tabela. Registro de decisão em arquivo
mantém a tabela e acrescenta a data e o que foi rejeitado.

Só o rascunho: não execute a recomendação, e não trate a leitura dela como a
escolha feita.
