---
description: Desenha a forma — ASCII de uma sequência, de uma bifurcação ou de um antes/depois, setas rotuladas com o que passa, um traço só, nada que quebre linha. Recusa quando o assunto não merece desenho
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

Depois escolha o layout que o assunto já tem. Estes quatro são ponto de
partida, não molde — quando a forma real não é nenhuma delas, desenhe a real.

**Fluxo**, quando é um caminho só com três saltos ou mais. Esquerda para
direita, o caminho inteiro numa linha, todo o resto pendurado embaixo:

```
PWA ──todo resume──> /auth/refresh ──> sessions
                      │
                      └─ 2,1 s p95, sem índice em token_hash
```

**Bifurcação**, quando o achado é que duas rotas se separam. Cima para baixo,
a condição na seta e não dentro de um losango, as duas saídas começando na
mesma coluna:

```
POST /pedidos
     │
     ├── tem estoque ──> cobrança ──> e-mail de confirmação
     │
     └── sem estoque ──> fila de espera
                          │
                          └─ nada avisa quem comprou
```

**Antes/depois**, quando você mudou uma estrutura. Dois blocos empilhados, a
mesma coluna à esquerda e a mesma ordem de caixas, para que a diferença seja a
única coisa que se mexe:

```
antes    worker ──> cache ──> relatorios_dia
depois   worker ────────────> relatorios_dia
                               │
                               └─ 3 leituras velhas/dia a menos
```

**Árvore de chamadas**, quando o achado é quem chama quem. A indentação
carrega a profundidade, e uma segunda coluna carrega o que cada chamada custa:

```
handleOrder()
├─ validate()      pura
├─ charge()        rede, sem timeout
│  └─ retry()      ×3, sem backoff
└─ notify()        dispara e esquece
```

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
- **Abaixo de setenta e duas colunas**, e esse limite é o duro. Linha que quebra
  deixa de ser desenho, e ela quebra no painel de quem lê, não no seu rascunho,
  então você nunca vê acontecer. Quando um antes/depois não cabe lado a lado
  dentro disso, empilhe os dois blocos em vez de encolher os rótulos.
- **Um conjunto de traços e uma direção.** Caixa desenhada ou ASCII puro, a
  mesma ponta de seta até o fim — misturar lê como dois desenhos colados.
  Esquerda para direita no fluxo, cima para baixo na bifurcação, e o que corre
  em paralelo começa na mesma coluna: o olho lê margem esquerda irregular como
  uma diferença que não existe.
- **Todo rótulo pendura no que ele nomeia**, por um `│` até um `└─`. Número
  flutuando entre duas caixas é lido contra a errada, e nada no desenho diz a
  quem lê qual era a certa.
- **Rótulo solto na linha; caixa fechada só quando ela paga três linhas.**
  `worker ──> cache` já é um desenho, e as mesmas duas coisas dentro de molduras
  `┌──────┐` custam seis linhas pelo mesmo conteúdo — o orçamento de quinze
  linhas tem cinco caixas de profundidade. Caixa fechada é para nó que segura
  duas linhas, um nome e o que ele custa, ou para o bloco comparado num
  antes/depois. Um estilo de caixa por desenho, como há um conjunto de traços.
- **O caminho feliz fica na linha principal, a falha desce.** Com a rota de
  erro na mesma linha, quem lê precisa descobrir qual das duas é a normal antes
  de o desenho dizer qualquer coisa. E a seta de falha carrega o que se perde —
  `timeout: pedido cobrado, não confirmado` — nunca `erro`.
- **Repetição é contagem, não caixa.** Oito consumidores iguais são uma caixa e
  `×8`; o que difere entre eles vai no rótulo, e quando nada difere a contagem
  é o conteúdo inteiro. Desenhar os oito gasta o orçamento provando que são
  iguais.
- **Sem legenda, sem chave.** Desenho que precisa de uma linha explicando o que
  um traço significa já falhou — dobre o significado dentro dos rótulos, ou
  largue a distinção que ele carregava. Um `×8` ou uma unidade é rótulo, não
  legenda.
- **ASCII em bloco de código** sempre funciona, e é o padrão. `mermaid` tem as
  condições e as regras dele, abaixo.
- **Uma linha embaixo, só se o desenho já não disser** — o achado para o qual
  ele aponta, a caixa onde o problema mora.

Mermaid no lugar do ASCII, e só sob duas condições, as duas necessárias. **A
superfície renderiza** — comentário, issue e descrição de PR no GitHub
renderizam; resposta no terminal, corpo de commit e campo de texto puro não, e
lá quem lê recebe o código-fonte em vez da figura. **E o grafo é de fato
bidimensional** — um nó com duas setas chegando, um ciclo, uma malha. Corrente
é corrente, e o ASCII carrega ela sobrevivendo à cópia para um terminal, um
commit ou um chat que não renderiza nada.

Quando for mermaid, estas substituem as regras de alinhamento e mais nada:

- **`flowchart LR` no fluxo, `flowchart TD` na bifurcação ou na árvore** — a
  mesma regra de direção que o ASCII toma, pelo mesmo motivo.
- **O rótulo visível é o que a pessoa lê, nunca o id do nó.**
  `auth["/auth/refresh"]` — o id é contabilidade interna, e id críptico deixado
  à mostra vira uma caixa para decifrar antes de o desenho começar a servir.
- **Toda aresta rotulada**, `-->|todo resume|`. Um `-->` pelado é a mesma
  afirmação vazia em mermaid que é em ASCII.
- **Forma de nó significa alguma coisa ou fica no padrão.** `{...}` para
  decisão de verdade, `[(...)]` para armazenamento, `([...])` para a entrada,
  `[...]` para todo o resto. Forma escolhida por variedade é ruído que quem lê
  tenta ler como significado.
- **Sem `style`, sem `classDef`, sem cor.** Cor que carrega significado precisa
  de legenda, e desenho que precisa de legenda já falhou; ainda por cima, o
  tema de quem lê pode ser justo o que você não testou.
- **Dez nós é o teto**, o equivalente em mermaid às quinze linhas. Passando
  disso, corte até os nós que carregam o achado, ou parta em dois desenhos.
- **Você não consegue renderizar antes de entregar, então fique no subconjunto
  que sempre compila.** Aspas em todo rótulo com colchete, parêntese,
  dois-pontos ou aspa; nunca `end` como id de nó pelado; nada de markdown
  dentro de rótulo. Bloco que não compila vira uma caixa de erro, o que é pior
  que desenho nenhum.

Desenhe nesta ordem, porque alinhamento não é coisa que se conserta depois:

1. Escreva a linha principal inteira primeiro — as caixas e as setas
   rotuladas, da esquerda para a direita. Toda coluna abaixo dela é medida a
   partir dessa linha, então nada é desenhado embaixo antes de ela estar
   pronta.
2. Conte a coluna em que cada caixa começa. O `│` fica embaixo de um caractere
   da caixa dele, não perto dela; cotovelo uma coluna fora lê como apontando
   para a seta em vez da caixa.
3. Pendure os rótulos de cima para baixo, o mais à esquerda fechando primeiro,
   para que nenhum `└─` cruze um `│` ainda aberto. Cruzamento é o desenho
   dizendo a quem lê que duas coisas se ligam sem se ligarem.
4. Meça a linha mais longa antes de entregar. Passando de setenta e duas
   colunas, corte os rótulos ou empilhe os blocos — nunca entregue torcendo
   para o painel ser largo.

Antes de entregar, audite o rascunho você mesmo — toda seta rotulada, todo
salto verificado ou marcado, nenhuma caixa nomeada por algo que a pessoa nunca
vai tocar, abaixo de quinze linhas e de setenta e duas colunas, um conjunto de
traços só, todo rótulo pendurado na caixa dele, sem legenda, a rota de falha
abaixo da linha principal, repetição contada em vez de desenhada, e nenhuma
linha embaixo repetindo a figura — e corrija o que falhar. Se saiu mermaid,
audite que ele
ganhou as duas condições, que nenhuma aresta está pelada, e que nada num
rótulo deixaria de compilar. Entregue só a versão limpa.

Entrega: o desenho em bloco de código, com a tag do que ele é. Nada antes dele
além da única frase que ele ilustra, quando essa frase ainda não está na
conversa.
