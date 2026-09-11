# Tarefa e issue

## Crenças

- **Quem vai ler não estava na conversa.** Tarefa criada por MCP ou issue no
  GitHub é lida semanas depois, por outra pessoa, sem ninguém para perguntar —
  então "não repita o que já ficou estabelecido" para de valer: o que ficou
  estabelecido não viaja junto.
- **A coluna mostra só o título, cortado por volta de 300px**, e a primeira
  palavra é a que o olho varre; o corpo é lido na visão de detalhe que o
  clique abre.
- **Campo preenchido repetido no corpo é uma cópia que envelhece** assim que
  alguém mexe no campo. O motivo é diferente — "o prazo é dia 28 porque o
  faturamento roda no 29" é um fato que campo nenhum guarda.
- **Duplicata custa triagem duas vezes** e divide a discussão.
- **O histórico engorda o card** — como você chegou ali, o que descartou —
  sem mudar o que a pessoa vai fazer.

## Desejos

- Daqui a três semanas, sem a conversa, alguém sabe o que muda, por que agora
  e como saber que acabou — e consegue agir.

## Intenções

Todo card carrega:

- **Título que diz o que muda, localizado**: a área primeiro quando o board
  tem mais de uma — "Documentos: negrito aparece com asteriscos" — depois o
  sintoma quando quem lê reconhece, ou o verbo da ação quando não reconheceria
  ("Arquivados: esconder a página de quem não tem acesso"). Nunca rótulo sem
  mudança dentro ("Filtro de faturas"), e nada que os campos do card já digam
  — um prefixo `fix(...)` ao lado de uma etiqueta `bugfix` vermelha gasta duas
  vezes os caracteres varridos.
- **Comportamento atual, depois o esperado**, duas frases cada: a distância
  entre os dois é o trabalho.
- **Valor exato, não a descrição dele** — caminho, comando, linha do erro,
  número, ambiente, versão: "`/auth/refresh` demora 2,1 s em produção" diz o
  que "o login está lento" não diz.
- **Critério de pronto, em uma linha** — o passo de teste da PR na forma
  curta.
- **Escopo fechado**, que cabe numa entrega: "e também" são dois cards, e o
  que este card *não* faz é dito quando alguém poderia ampliar.

E quando o caso pedir: **como reproduzir**, em passos numerados, com a
frequência quando não falha sempre; **impacto com quem sente** — quantos
usuários, qual cliente, o que acontece se ficar parado, já que "urgente" no
título não decide nada; **dependência e bloqueio com link**; **anexo que
prova** — print, log, payload, ID do trace.

O layout, para um corpo lido na visão de detalhe:

- **Dois parágrafos, depois linhas com rótulo.** Comportamento atual, linha em
  branco, comportamento esperado; depois cada campo recorrente em negrito na
  própria linha — **Onde:** para os arquivos e ajustes tocados, **Feito
  quando:**, **Fora de escopo:**, **Reproduzir:** encabeçando os passos
  numerados em vez de substituí-los, **Impacto:**, **Reverte:**. Um rótulo
  por linha, nada em negrito na frase depois dele.
- **Dois code spans por parágrafo de prosa, e nenhum parêntese dentro de
  parêntese.** O valor que a pessoa vai abrir ou digitar fica na frase; os
  outros ponteiros vão para **Onde:**, que fica fora dessa conta.
- **Sem cabeçalho enquanto o corpo não passa de quinze linhas** e não carrega
  três blocos com funções diferentes; abaixo disso, `## O problema` sobre duas
  linhas é enfeite.
- **Tabela só a partir de três linhas por três colunas** com valor em toda
  célula; menor que isso é lista, e destino que renderiza estreito ou em texto
  puro recebe a tabela num documento linkado.
- **Quinze linhas já é um card longo**, e o corpo se sustenta sozinho: sem
  "como conversamos", sem "aquele problema que você mencionou".

Criando por ferramenta: o que a conversa definiu — prioridade, responsável,
etiqueta — entra no campo, não no texto, e não fica em silêncio no default. O
template de issue do próprio tracker é contrato: escolha o formulário que casa
e preencha neste registro. Procure antes o card que já existe, e aponte para
um candidato provável — linke, comente nele — em vez de criar do lado. O
histórico fica de fora: o card descreve o que falta, não o percurso até
descobrir.
