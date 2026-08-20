---
description: Desenha a forma — ASCII de uma sequência, de uma bifurcação ou de um antes/depois, setas rotuladas com o que passa. Recusa quando o assunto não merece desenho
argument-hint: [o que desenhar — vazio usa o que acabou de ser explicado]
---

Desenhe um diagrama, seguindo a seção "Mostre o desenho" das regras de
`respostas-curtas`. Invoque a skill antes se as regras completas não estiverem
no contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o mecanismo
explicado mais recentemente nesta conversa.

$ARGUMENTS

Primeiro decida se aquilo merece um desenho, e diga que não quando não merece:

- **Vale desenhar:** caminho com três saltos ou mais, qualquer coisa com
  bifurcação, retry ou rota de falha, o antes e o depois de uma estrutura que
  você mudou, ou quem chama quem quando o achado é que a coisa errada chama a
  outra.
- **Não vale desenhar:** o comportamento de uma função, uma lista de três
  itens, ou a figura de uma frase que já está na tela. Diagrama repetindo a
  linha de cima é enchimento com passos a mais. Quando o assunto é um desses,
  diga isso em uma linha e pare — não desenhe assim mesmo.

Regras do desenho:

- **Fundamente cada salto na fonte.** Abra os arquivos, siga a chamada.
  Diagrama de saltos que você inferiu é ficção sobre a qual a pessoa vai agir,
  e ele é acreditado mais do que uma frase seria. Salto que você não conseguiu
  verificar é rotulado como não verificado dentro do desenho, ou fica de fora
  e é nomeado embaixo dele.
- **Rotule as setas com o que passa e o que custa** — `todo retorno ao app`,
  `2,1 s p95`, `retry ×3` — não com `chama` nem com a ponta da seta sozinha.
  Seta sem rótulo só diz que duas caixas se relacionam, o que a pessoa já
  supunha.
- **Rotule as caixas pelo que elas fazem**, não pelo nome interno. Caixa
  escrita `cópia diária` ensina; a mesma caixa carregando o nome da tabela não
  ensina nada a quem nunca vai consultar ela. A exceção é o nome que a pessoa
  vai usar de fato — um caminho, uma rota, um serviço que ela vai abrir.
- **Abaixo de quinze linhas.** Passando disso deixa de ser forma e vira um
  segundo documento. Corte até os saltos que carregam o achado.
- **ASCII em bloco de código** sempre funciona. Use `mermaid` só onde você
  sabe que a superfície renderiza — comentário e issue no GitHub renderizam,
  resposta no terminal não.
- **Uma linha embaixo, só se o desenho já não disser** — o achado para o qual
  ele aponta, a caixa onde o problema mora.

Antes de entregar, audite o rascunho você mesmo — toda seta rotulada, todo
salto verificado ou marcado, nenhuma caixa nomeada por algo que a pessoa nunca
vai tocar, abaixo de quinze linhas, e nenhuma linha embaixo repetindo a figura
— e corrija o que falhar. Entregue só a versão limpa.

Entrega: o desenho em bloco de código, com a tag do que ele é. Nada antes dele
além da única frase que ele ilustra, quando essa frase ainda não está na
conversa.
