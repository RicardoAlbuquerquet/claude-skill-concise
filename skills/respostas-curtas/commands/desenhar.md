---
description: Desenha a forma em ASCII — diz quando o assunto lê melhor em prosa
argument-hint: "[o que desenhar — vazio usa o que acabou de ser explicado]"
---

Desenhe um diagrama, seguindo a seção "Mostre o desenho" das regras de
`respostas-curtas`.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o mecanismo
explicado mais recentemente nesta conversa.

$ARGUMENTS

## Crenças

- **Desenho é acreditado mais que frase**, então salto que você inferiu é
  ficção em que a pessoa vai agir.
- **Ele quebra no painel de quem lê, onde você só vê o seu rascunho** — e
  linha que quebra deixa de ser desenho.
- **O olho lê alinhamento como significado**: margem esquerda irregular como
  diferença, seta longa como lentidão, número solto contra a caixa errada,
  cruzamento como conexão.
- **Legenda é o desenho admitindo que falhou**, e caixa com o nome de uma
  tabela ensina só a quem consulta aquela tabela.
- **Anote toda caixa e a marca some**: a pessoa lê como tabela de referência,
  onde uma afirmação tem uma marca.

## Desejos

- Quem lê vê a forma e o achado de relance, e pode confiar em cada salto.

## Intenções

Primeiro, se merece desenho — e diga isso quando prosa serve melhor: caminho
com três ou mais saltos, bifurcação, retry ou rota de falha, o antes e
depois de uma estrutura que você mudou, ou quem chama quem, se desenha;
comportamento de uma função só, lista de três itens, ou figura de uma frase
que já está na tela fica em prosa — uma linha dizendo isso, e pare.

Depois o layout que o assunto já tem. Quatro pontos de partida, cada um
aberto à forma real:

**Fluxo** — um caminho, da esquerda para a direita, todo o resto pendurado
embaixo:

```text
PWA ──todo resume──> /auth/refresh ──> sessions
                      │
                      └─ 2,1 s p95, token_hash fora do índice
```

**Bifurcação** — de cima para baixo, a condição na seta, as duas saídas
começando na mesma coluna:

```text
POST /orders
     │
     ├── com estoque ─────> cobrança ──> e-mail de confirmação
     │
     └── estoque zerado ──> fila de backorder
                            │
                            └─ o comprador fica às escuras
```

**Antes/depois** — dois blocos empilhados, mesma coluna esquerda e mesma
ordem de caixas, para a diferença ser a única coisa que se move:

```text
antes    worker ──> cache ──> reports_daily
depois   worker ────────────> reports_daily
                               │
                               └─ 3 leituras velhas/dia a menos
```

**Árvore de chamadas** — indentação para a profundidade, segunda coluna para
o que cada chamada custa:

```text
handleOrder()
├─ validate()      pura
├─ charge()        rede, timeout por definir
│  └─ retry()      ×3, backoff por definir
└─ notify()        dispara e esquece
```

O desenho:

- **Todo salto confirmado na fonte** — abra os arquivos, siga a chamada.
  Salto que ficou por verificar leva um `?` no fim do rótulo, a única forma
  (`webhook retentado ×3 ?`); salto além de qualquer chute fica de fora e é
  nomeado embaixo do desenho.
- **Setas rotuladas com o que passa e o que custa** — `todo resume`,
  `2,1 s p95`, `retry ×3` — onde `chama` ou ponta de seta nua diz só que duas
  caixas se relacionam.
- **Caixas nomeadas pelo que fazem** — `cópia diária` — e pelo nome interno
  só quando a pessoa vai abrir: caminho, rota, serviço. E com as palavras que
  a prosa em volta usa.
- **Abaixo de quinze linhas, e abaixo de setenta e duas colunas** — o limite
  duro. Antes/depois que cresce além de lado a lado, empilhe.
- **Um conjunto de traços, uma ponta de seta, uma direção** — esquerda para
  direita no fluxo, cima para baixo na bifurcação — e o que corre em paralelo
  começa na mesma coluna.
- **Todo rótulo pendura no que ele nomeia**, por um `│` até um `└─`.
- **Rótulo solto na linha; caixa fechada só para nó com duas linhas** ou o
  bloco comparado num antes/depois — moldura `┌──────┐` custa seis linhas
  para o que `worker ──> cache` já diz. Um estilo de caixa por desenho.
- **O caminho feliz na linha principal, a falha embaixo dela**, e a seta de
  falha carrega o que a pessoa perde — `timeout: pedido cobrado, confirmação
  pendente` — onde `erro` diz só que algo falhou.
- **Repetição é contagem**: oito consumidores iguais são uma caixa e `×8`.
- **Todo significado mora num rótulo**: `×8` ou uma unidade é rótulo, e a
  legenda fica fora.
- **Uma marca, no achado**: a caixa onde o achado mora é a única com nota
  pendurada. Duas caixas merecendo são dois achados, provavelmente dois
  desenhos.
- **Uma linha embaixo, só para o que o desenho deixa por dizer.**

Mermaid no lugar de ASCII só com duas condições, as duas obrigatórias: a
superfície renderiza — comentário, issue ou PR no GitHub sim, enquanto
resposta no terminal, corpo de commit e campo de texto puro mostram a fonte —
e o grafo é de fato bidimensional: nó com duas setas entrando, ciclo, malha.
Aí, substituindo só as regras de alinhamento: `flowchart LR` para fluxo, `TD`
para bifurcação ou árvore; o rótulo visível é o que a pessoa lê, e o id do nó
é contabilidade (`auth["/auth/refresh"]`); toda aresta rotulada,
`-->|todo resume|`; forma de nó significa algo ou fica no padrão — `{...}`
decisão real, `[(...)]` armazenamento, `([...])` ponto de entrada; o visual
padrão, livre de `style`, `classDef` e cor; dez nós é o teto; e fique no
subconjunto que sempre parseia — aspas em rótulo com colchete, parêntese,
dois-pontos ou aspas, id nu diferente de `end`, rótulo em texto liso.

Nesta ordem, porque alinhamento se acerta na hora de desenhar:

1. A linha principal inteira primeiro — caixas e setas rotuladas; toda coluna
   abaixo se mede por ela.
2. A coluna em que cada caixa começa: o `│` fica embaixo de um caractere da
   caixa.
3. Rótulos pendurados de cima para baixo, o mais à esquerda fechando
   primeiro, para todo `└─` fechar antes de encontrar um `│` aberto.
4. A linha mais longa medida: passou de setenta e duas colunas, corte rótulos
   ou empilhe blocos — o rascunho sai só depois de caber.

O acabamento: rótulos num registro só — minúsculas, o último caractere letra
ou dígito, mesma forma; um estilo de unidade por desenho; comprimento de seta
é só espaçador; coluna de custo começa numa coluna e fica nela; encurte pela
cabeça, mantendo o fim (`…/auth/refresh.rs:88`); bloco com rótulo `text` —
rótulo de shell colore os traços como sintaxe — ou `mermaid`; linha em branco
só entre blocos empilhados.

Entrega: o desenho em bloco de código com rótulo `text` — ou `mermaid` quando
mereceu as duas condições. Antes dele, no máximo a frase que ele ilustra,
quando ela ainda falta na conversa.
