---
description: Desenha a forma em ASCII — recusa assunto que não merece desenho
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
- **Ele quebra no painel de quem lê, não no seu rascunho** — você nunca vê
  acontecer, e linha que quebra deixa de ser desenho.
- **O olho lê alinhamento como significado**: margem esquerda irregular como
  diferença que não existe, seta longa como lentidão, número solto contra a
  caixa errada, cruzamento como conexão.
- **Desenho que precisa de legenda já falhou**, e caixa com o nome de uma
  tabela que a pessoa nunca vai consultar não ensina nada.
- **Toda caixa anotada é nenhuma caixa marcada**: a pessoa lê como tabela de
  referência, não como afirmação.

## Desejos

- Quem lê vê a forma e o achado de relance, e pode confiar em cada salto.

## Intenções

Primeiro, se merece desenho — e diga não quando não merece: caminho com três
ou mais saltos, bifurcação, retry ou rota de falha, o antes e depois de uma
estrutura que você mudou, ou quem chama quem, sim; comportamento de uma
função só, lista de três itens, ou figura de uma frase que já está na tela,
não — uma linha dizendo isso, e pare.

Depois o layout que o assunto já tem. Quatro pontos de partida, não moldes:

**Fluxo** — um caminho, da esquerda para a direita, todo o resto pendurado
embaixo:

```text
PWA ──todo resume──> /auth/refresh ──> sessions
                      │
                      └─ 2,1 s p95, sem índice em token_hash
```

**Bifurcação** — de cima para baixo, a condição na seta, as duas saídas
começando na mesma coluna:

```text
POST /orders
     │
     ├── com estoque ──> cobrança ──> e-mail de confirmação
     │
     └── sem estoque ──> fila de backorder
                          │
                          └─ nada avisa o comprador
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
├─ charge()        rede, sem timeout
│  └─ retry()      ×3, sem backoff
└─ notify()        dispara e esquece
```

O desenho:

- **Todo salto confirmado na fonte** — abra os arquivos, siga a chamada.
  Salto que você não conseguiu verificar leva um `?` no fim do rótulo, a
  única forma (`webhook retentado ×3 ?`); salto que nem dá para chutar fica
  de fora e é nomeado embaixo do desenho.
- **Setas rotuladas com o que passa e o que custa** — `todo resume`,
  `2,1 s p95`, `retry ×3` — nunca `chama` nem ponta de seta nua.
- **Caixas nomeadas pelo que fazem** — `cópia diária`, não o nome da tabela —
  salvo nome que a pessoa vai abrir: caminho, rota, serviço. E com as
  palavras que a prosa em volta usa.
- **Abaixo de quinze linhas, e abaixo de setenta e duas colunas** — o limite
  duro. Antes/depois que não cabe lado a lado, empilhe.
- **Um conjunto de traços, uma ponta de seta, uma direção** — esquerda para
  direita no fluxo, cima para baixo na bifurcação — e o que corre em paralelo
  começa na mesma coluna.
- **Todo rótulo pendura no que ele nomeia**, por um `│` até um `└─`.
- **Rótulo solto na linha; caixa fechada só para nó com duas linhas** ou o
  bloco comparado num antes/depois — moldura `┌──────┐` custa seis linhas
  para o que `worker ──> cache` já diz. Um estilo de caixa por desenho.
- **O caminho feliz na linha principal, a falha embaixo dela**, e a seta de
  falha carrega o que a pessoa perde — `timeout: pedido cobrado, não
  confirmado`, nunca `erro`.
- **Repetição é contagem**: oito consumidores iguais são uma caixa e `×8`.
- **Sem legenda, sem chave.** `×8` ou uma unidade é rótulo.
- **Uma marca, no achado**: a caixa onde o achado mora é a única com nota
  pendurada. Duas caixas merecendo são dois achados, provavelmente dois
  desenhos.
- **Uma linha embaixo, só se o desenho ainda não diz.**

Mermaid no lugar de ASCII só com duas condições, as duas obrigatórias: a
superfície renderiza — comentário, issue ou PR no GitHub sim; resposta no
terminal, corpo de commit e campo de texto puro não — e o grafo é de fato
bidimensional: nó com duas setas entrando, ciclo, malha. Aí, substituindo as
regras de alinhamento e nada mais: `flowchart LR` para fluxo, `TD` para
bifurcação ou árvore; o rótulo visível é o que a pessoa lê, nunca o id do nó
(`auth["/auth/refresh"]`); toda aresta rotulada, `-->|todo resume|`; forma de
nó significa algo ou fica no padrão — `{...}` decisão real, `[(...)]`
armazenamento, `([...])` ponto de entrada; sem `style`, `classDef` nem cor;
dez nós é o teto; e fique no subconjunto que sempre parseia — aspas em
rótulo com colchete, parêntese, dois-pontos ou aspas, nunca `end` como id
nu, sem markdown dentro de rótulo.

Nesta ordem, porque alinhamento não se conserta depois:

1. A linha principal inteira primeiro — caixas e setas rotuladas; toda coluna
   abaixo se mede por ela.
2. A coluna em que cada caixa começa: o `│` fica embaixo de um caractere da
   caixa, não perto.
3. Rótulos pendurados de cima para baixo, o mais à esquerda fechando
   primeiro, para nenhum `└─` cruzar um `│` aberto.
4. A linha mais longa medida: passou de setenta e duas colunas, corte rótulos
   ou empilhe blocos — nunca entregue torcendo pelo painel largo.

O acabamento: rótulos num registro só — minúsculas, sem pontuação final,
mesma forma; um estilo de unidade por desenho; comprimento de seta é
espaçador, nunca sinal; coluna de custo começa numa coluna e fica nela;
encurte pela cabeça, nunca pelo fim (`…/auth/refresh.rs:88`); bloco com
rótulo `text` — sem rótulo perde a regra, rótulo de shell colore os traços —
ou `mermaid`; linha em branco só entre blocos empilhados.

Entrega: o desenho em bloco de código com rótulo `text` — ou `mermaid` quando
mereceu as duas condições. Nada antes dele além da frase que ele ilustra,
quando essa frase ainda não está na conversa.
