---
description: Reescreve um texto pronto pelas regras, mantendo todo fato
argument-hint: "[texto a reescrever — vazio mira sua resposta anterior]"
---

Reescreva um texto pronto até ele cumprir as regras de `respostas-curtas`. Se
as regras completas estiverem ausentes do contexto, invoque a skill
`respostas-curtas` primeiro.

O alvo é o texto abaixo. Quando o argumento inteiro é um caminho para um
arquivo que existe, leia esse arquivo e reescreva o conteúdo dele; quando
está vazio, o alvo é a sua própria resposta anterior nesta conversa; nos
demais casos, o próprio argumento é o texto.

$ARGUMENTS

Regras da reescrita:

- **Os mesmos fatos, os mesmos compromissos.** Reescrever mantém todo fato:
  todo valor exato, ressalva, notícia ruim e nota de escopo do original
  sobrevive. A lista **Sempre fica** vale sobre o que o original *disse*.
- **Pode acrescentar o que o original devia** — o custo que faltava numa
  recomendação, o passo de teste que faltava numa descrição de PR — só quando
  o original contém a informação para preencher; senão reporte o buraco. Todo
  valor, número e resultado vem do original.
- **Escolha o registro pelo destino.** Descrição de PR, card, mensagem de
  commit, entrada de changelog, comentário ou texto no código segue o próprio
  arquivo em `${CLAUDE_PLUGIN_ROOT}/referencias/` — leia antes; resposta de
  chat segue a tabela de orçamentos.

Entregue o texto reescrito primeiro. Em bloco de código quando o destino for
outra superfície — PR, issue, mensagem de commit, e-mail — para copiar
inteiro, com quatro crases quando o texto carregar uma cerca própria; em
prosa quando for resposta de chat. Alvo em arquivo é entregue do mesmo jeito
— o arquivo em si muda só quando o usuário pedir. Depois dele, só se o
original estava devendo algo que as regras exigem, uma linha por buraco,
cada uma abrindo com **Faltou:**. Essa é a entrega inteira; contagem de
palavras e comentário sobre o corte ficam fora.
