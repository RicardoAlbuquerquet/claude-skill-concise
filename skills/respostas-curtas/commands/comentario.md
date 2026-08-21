---
description: Escreve um comentário de revisão, uma resposta em thread, um recado num card ou uma mensagem para alguém — a afirmação primeiro, a linha que prova, um ponto por comentário
argument-hint: [sobre o que é o comentário, e opcionalmente para onde ele vai]
---

Escreva um comentário ou mensagem seguindo a seção "Comentário e resposta"
das regras de `respostas-curtas`. Invoque a skill antes se as regras
completas não estiverem no contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o que está em
discussão agora — o trecho do diff que você acabou de ler, a thread sobre a
qual perguntaram, a pergunta que alguém fez.

$ARGUMENTS

Antes de rascunhar, duas coisas:

1. **Leia aquilo que você vai comentar.** Abra o arquivo na linha, leia a
   thread desde o começo, leia o card. Comentário de revisão sobre uma linha
   que você não abriu é um palpite vestido de `caminho:linha`, e quem escreveu
   descobre antes de você. Quando não dá para chegar lá — sem acesso, linha
   inexistente — diga isso e pare.
2. **Nomeie o tipo**, porque ele muda a forma: comentário de revisão ancorado
   numa linha do diff, resposta dentro de uma thread, recado no card de
   alguém, ou mensagem para uma pessoa. Se a invocação não disse e o assunto
   não deixa óbvio, escreva um comentário de revisão e diga que assumiu isso.

Regras do comentário:

- **A afirmação, e depois a linha que prova.** "Isso derruba o retry no 401
  (`retry.ts:88`), então senha errada trava a conta em três tentativas."
  Sem a âncora é opinião, e quem lê tem que ir achar o que você já achou.
- **Diga se trava.** A primeira pergunta de quem lê é se precisa agir antes
  do merge. Pedido de mudança, sugestão que dá para pegar ou largar e
  observação para depois são três comentários diferentes — diga qual é este,
  dentro dele, não numa etiqueta que talvez ninguém veja.
- **Um comentário, um ponto.** Dois pontos sem relação são dois comentários,
  para cada um ser resolvido sozinho. Se o assunto tem vários, entregue vários
  blocos em vez de um comentário com uma lista dentro.
- **Resposta responde na primeira frase.** Quando a resposta é "você tinha
  razão, corrigido em `a1b2c3d`", ela é a resposta inteira — sem rediscutir o
  que já ficou resolvido, sem recontar a thread que a pessoa acabou de ler.
- **Diga o que mudaria sua opinião** em vez de enfraquecer a afirmação. "A não
  ser que exista um chamador que eu não vi" ganha de "talvez seja o caso de
  possivelmente".
- **Elogio de enchimento não entra.** Abertura genérica custa um parágrafo até
  a pessoa descobrir que aquilo é um pedido de mudança. Elogio que nomeia uma
  decisão específica é conteúdo; "Ficou ótimo!" não é.
- **Quando a correção é de uma linha, dê a linha.** Um bloco de sugestão, ou o
  substituto em si — pedir a mudança e deixar a forma dela por conta de quem
  lê custa uma ida e volta.
- **Quem vai ler não estava nesta conversa** e não vai rolar a tela para cima:
  sem "como conversamos", sem referência a este chat, valor exato em vez da
  descrição dele. Recado em card ainda pega o painel estreito — sem cabeçalho,
  sem tabela, negrito só como rótulo de item. E recado em card é o resumo do
  resumo: três linhas já é longo e uma é comum — o que mudou ou o que a pessoa
  tem que fazer, com a âncora. O que precisa de um segundo parágrafo é uma
  edição no corpo do card, não um comentário nele.
- Nunca assine como agente de IA, aqui nem em lugar nenhum.

Antes de entregar, audite o rascunho você mesmo — afirmação primeiro, âncora
presente, se trava ou não dito, um ponto só, no máximo três linhas quando for
recado em card, nada que só faça sentido para quem leu esta conversa — e
corrija o que falhar. Entregue só a versão limpa.

Entrega: cada comentário no seu próprio bloco de código, pronto para colar,
com quatro crases quando carregar uma cerca própria — bloco de sugestão
carrega. Quando forem vários, ponha a âncora acima de cada bloco, em linha
própria (`retry.ts:88`), para cada um ser colado no lugar certo. Nada depois
deles além dos valores que você não conseguiu tirar do assunto, uma linha cada,
abrindo com **Faltou:**.

Publicar: por padrão, só rascunho. Quando a invocação nomeia um destino que
alguma ferramenta alcança — número de PR, URL de issue, id de card, com `gh`
ou um board MCP disponível — mostre o rascunho e o alvo exato, e publique só
depois de o usuário mandar, nesta conversa. Destino nomeado diz para onde
iria; não é permissão para notificar alguém.
