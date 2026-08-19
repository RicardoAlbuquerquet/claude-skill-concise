---
description: Reescreve um texto pronto pelas regras de respostas-curtas — a mesma informação, sem o enchimento
argument-hint: [texto a reescrever — vazio mira sua resposta anterior]
---

Reescreva um texto pronto até ele cumprir as regras de `respostas-curtas`. Se
as regras completas não estiverem no contexto, invoque a skill
`respostas-curtas` primeiro.

O alvo é o texto abaixo. Quando o argumento inteiro é um caminho para um
arquivo que existe, leia esse arquivo e reescreva o conteúdo dele; quando
está vazio, o alvo é a sua própria resposta anterior nesta conversa; nos
demais casos, o próprio argumento é o texto.

$ARGUMENTS

Regras da reescrita:

- **Os mesmos fatos, os mesmos compromissos.** Reescrever não é resumir: todo
  valor exato, ressalva, notícia ruim e nota de escopo do original sobrevive.
  A lista **Nunca corte** vale sobre o que o original *disse*, não sobre o que
  é conveniente manter.
- **Pode acrescentar o que o original devia** — o custo que faltava numa
  recomendação, o passo de teste que faltava numa descrição de PR — mas só
  quando o original contém a informação para preencher. Quando não contém,
  reporte o buraco em vez de inventar conteúdo. Nunca invente valor, número ou
  resultado.
- **Escolha o registro pelo destino.** Descrição de PR segue a seção de PR das
  regras; tarefa ou issue segue a seção dela, inclusive os limites de
  estrutura do painel estreito; resposta de chat segue a tabela de orçamentos.

Entregue o texto reescrito primeiro. Em bloco de código quando o destino for
outra superfície — PR, issue, mensagem de commit, e-mail — para copiar
inteiro, com quatro crases quando o texto carregar uma cerca própria; em
prosa quando for resposta de chat. Alvo em arquivo é entregue do mesmo jeito
— nunca edite o arquivo sem o usuário pedir. Depois dele, só se o original
estava devendo algo que as regras exigem, uma linha por buraco, cada uma
abrindo com **Faltou:**. Nada além disso: sem contagem de palavras
antes/depois, sem comentário sobre o que foi cortado.
