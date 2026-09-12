# Descrição de PR

## Crenças

- **Quem revisa está com o diff aberto na aba do lado**, e ele mostra o que
  mudou melhor que prosa: mapa arquivo por arquivo, contagem do que mudou ou
  uma seção por área disputa com ele e perde.
- **O problema é a única parte que quem revisa precisa ouvir de você** — o
  título diz o que a PR faz, e o diff mostra o que foi feito.
- **A coluna de rótulos em negrito na margem esquerda é o que se lê
  primeiro.** Cinco parágrafos vestindo travessão, ou um bloco solto
  estacionado entre dois cabeçalhos, é lido inteiro antes de dizer qualquer
  coisa.
- **Passo que passa por verificado é confiado como verificado**: quem revisa
  pula a checagem que lê como feita.
- **O `PULL_REQUEST_TEMPLATE` do repo é contrato**, enquanto um `## Mudanças`
  sobre um diff que quem revisa já tem aberto é enfeite com a autoridade do
  template atrás.

## Desejos

- Quem revisa sabe o que está sendo resolvido, lê o que foi feito numa tela, e
  confere sozinho.

## Intenções

- **Três funções, nesta ordem, com os cabeçalhos delas**: o que está sendo
  resolvido, o que foi feito, como testar. O problema abre, nos termos de quem
  lê: "a exportação truncava a própria saída sempre que a descrição tinha
  bloco de código" ganha de "corrige o tratamento de cerca".
- **As palavras são de quem revisa.** Nome que só existe dentro do repositório
  — uma variável, uma flag, um auxiliar interno — vira o que ele faz; o
  caminho, o comando e o valor que ela vai rodar, abrir ou aprovar mantêm o
  nome.
- **O que foi feito toma a forma que o trabalho tomou**: um parágrafo para uma
  coisa; para várias, lista markdown (`- ` no começo da linha), uma linha
  cada, abrindo com rótulo em negrito que nomeia a superfície — uma tela, um
  endpoint, um arquivo, um comportamento; tabela para um valor por caso. Item
  que passa de uma linha é duas afirmações ou uma inchada, e entregas
  emendadas com ponto-e-vírgula são a mesma parede de texto.
- **Tudo entre dois cabeçalhos fica sob um rótulo em negrito**: nota de
  migração, risco, valor que saiu diferente, decisão com o custo dela — cada
  um é uma linha sob o próprio rótulo, dentro da seção a que pertence.
- **Uma tela — algo como vinte e cinco linhas de prosa, blocos de comando
  fora da conta.** Passou disso, confira se são duas PRs. É teto em vez de
  alvo, e se paga só com o que repete: toda seção mantém as linhas, toda
  ressalva fica, e todo comando mantém o próprio bloco. Cada entrega é dita
  uma vez — parágrafo recontando uma linha da tabela de cima é o diff de novo
  — e checagem que você já rodou é uma linha mais a saída que prova ("já
  rodado: `44 ok, 0 falhas`"), o relato de ter rodado fora — com o comando
  dela em bloco próprio, como todo comando que o corpo cita.
- **Quando o diff atravessa muitos arquivos, uma linha diz por onde começar a
  ler** — o arquivo onde o mecanismo vive.
- **A alternativa que você descartou ganha uma linha**, e o argumento que a
  descartou vai para o corpo do commit ou para o card.
- **Template se preenche neste registro**: os cabeçalhos dele ficam, seção
  vazia de assunto ganha "nenhum", caixa só é marcada quando é verdade — e
  template que falta o espaço para o problema recebe o problema mesmo assim,
  abrindo a primeira seção em uma ou duas frases.
- **O título diz o que muda, a área primeiro, e deixa de fora o que a lista
  já mostra**, na forma que o log do repo usa — e nomeia o estado depois do
  merge, onde o card nomeia o sintoma: "Documentos: negrito aparece com
  asteriscos" é o card; "Documentos: escapar os asteriscos que o exportador
  emite crus" é a PR. Descrição que precisa de "e também" são duas PRs.
- **O card que motivou o trabalho viaja junto quando existe** — `Closes #52`
  no GitHub, card de board como link ou id — tirado da conversa ou de um
  tracker que uma ferramenta alcança, e só dali.
- **Ela termina com como quem revisa confere sozinho**:

1. **O comando exato**, copiável, em bloco próprio mesmo quando você já rodou
   — a linha dizendo que rodou e o que saiu fica ao lado do bloco:
   `npm test -- auth` conta, "rode os testes" é descrição.
2. **O que aparece se estiver certo** — o número, a linha da saída, a tela.
3. **O que provaria que quebrou**, quando o comando do passo 1 deixa o caso
   descoberto.

Passo que você pulou diz isso dentro do próprio passo, e o que você conferiu
no lugar vai nesse mesmo passo — juntado no fim, vira aviso legal e é lido
como um. Entregar a quem revisa a sequência que provaria que a checagem
quebra é passo de teste, e fica.
