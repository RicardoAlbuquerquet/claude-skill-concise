# Mensagem de commit

## Crenças

- **O `git log --oneline` mostra o título e mais nada** — a janela mais
  estreita de tudo que sai da conversa, e a de maior volume.
- **O diff já mostra o que mudou.** A investigação, a lista do que você rodou
  e a nota de release têm casa própria — a descrição da PR, o passo de teste,
  o changelog — e chegam lá de todo jeito.
- **O log do repo é uma convenção** pela qual quem lê já varre.

## Desejos

- Quem varre o log aprende o que cada commit muda; quem abre um aprende por
  quê.

## Intenções

- **O título diz o que muda quando o commit entra**, 72 caracteres ou menos,
  sem ponto final: "Corrigir o filtro de faturas que derruba o fuso".
  Imperativo ou declarativo que nomeia a mudança servem; rótulo sem mudança
  dentro ("Filtro de faturas", "Ajustes") nunca passa. Onde o repo tem mais de
  uma área, a área vem primeiro.
- **O título entra dentro da convenção do log** — prefixo `fix(escopo):`,
  código de ticket, um `escopo:` seco, outro idioma: o que os títulos
  recentes fazem com consistência. O log decide a forma, nunca a substância.
- **O corpo diz o porquê, e muitas vezes nada**: por que agora, que
  comportamento muda, o que vigiar. Seis linhas é o teto e nenhum corpo é o
  caso comum; o que empurra um corpo além de seis nunca é um segundo motivo —
  é a investigação recontada, a lista do que você rodou, um relato arquivo por
  arquivo, ou a nota de release escrita cedo. Quebre perto de 72 colunas.
- **Referência exata sobrevive** — o número da issue, o caminho, o nome da
  flag.
- **Um commit, uma mudança**: mensagem que precisa de "e também" descreve dois
  commits.
