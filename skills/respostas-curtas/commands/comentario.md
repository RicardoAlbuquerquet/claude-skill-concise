---
description: Escreve um comentário ou mensagem — a afirmação, e depois a linha que prova
argument-hint: "[sobre o que é o comentário, e opcionalmente para onde ele vai]"
---

Escreva um comentário ou mensagem. Leia
`${CLAUDE_PLUGIN_ROOT}/referencias/comentario.md` antes: as regras moram lá,
e aqui só o procedimento.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o que está em
discussão mais recente — o trecho de diff que você acabou de ler, a thread
sobre a qual perguntaram, a pergunta que alguém te fez.

$ARGUMENTS

Como:

1. **Leia o que você vai comentar** — o arquivo na linha, a thread desde o
   topo, o card. Comentário sobre linha que você não abriu é chute vestindo
   um `caminho:linha`. Quando não alcança, diga isso e pare.
2. **Nomeie o tipo**, porque ele muda a forma: comentário de revisão ancorado
   numa linha do diff, resposta numa thread, recado no card de alguém,
   mensagem para uma pessoa. Não dito e não óbvio: comentário de revisão, e
   diga que assumiu isso.
3. Escreva como a referência diz, mais o que o tipo acrescenta: comentário de
   revisão diz se trava, dentro do comentário; resposta responde na primeira
   frase — "você tinha razão, corrigido em `a1b2c3d`" é a resposta inteira;
   quando a correção é uma linha, dê a linha, como bloco de sugestão ou o
   próprio texto.
4. Conte as linhas, depois confira o rascunho contra a referência e corrija o
   que falha. O que passa de três linhas é raciocínio para o card ou a PR,
   nunca a âncora ou o valor exato.

Entrega: cada comentário no próprio bloco de código, pronto para colar —
quatro crases quando ele carrega um bloco próprio, como bloco de sugestão
carrega. Vários comentários levam a âncora acima de cada bloco, numa linha
só (`retry.ts:88`). Nada depois deles além dos valores que você não conseguiu
preencher pelo assunto, uma linha cada, abrindo com **Faltou:**.

Publicar: só rascunho, por padrão. Quando a invocação nomeia um destino que
uma ferramenta alcança — número de PR, URL de issue, id de card — mostre o
rascunho e o alvo exato, e publique só depois de o usuário mandar, nesta
conversa. Destino nomeado diz para onde iria; não é permissão para notificar
alguém.
