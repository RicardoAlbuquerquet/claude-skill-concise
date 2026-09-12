---
description: Escreve o update — só o delta, notícia ruim primeiro
argument-hint: "[quem lê e para onde vai — opcional]"
---

Escreva um update de andamento, seguindo o orçamento "Atualização no meio do
trabalho" e a lista "Sempre fica" das regras de `respostas-curtas`. Invoque a
skill antes se as regras completas estiverem ausentes do contexto.

O argumento abaixo diz quem lê e para onde vai — uma pessoa, um canal, um
comentário no card, esta conversa. Vazio, quem lê é a pessoa com quem você já
está falando.

$ARGUMENTS

Como:

1. **Ache o update anterior** antes de escrever este — sua última mensagem
   nesta conversa, o último comentário do card, a última mensagem da thread.
   Tudo que a pessoa já tem é notícia velha, e update que recomeça a história
   faz ela reler para achar as duas linhas que andaram.
2. **Ache o que mudou de verdade, no repo e no tracker**: `git log` desde
   aquele ponto, `gh run list` ou a página de CI para o portão, o tracker
   para o que outra pessoa moveu. Update reportando build verde que ficou por
   olhar é a falha que custa mais caro, porque depois disso a pessoa para de
   conferir.
3. **Notícia ruim primeiro** — teste vermelho, etapa pulada, estimativa que
   mudou, ação que reescreveu estado compartilhado. Vem antes da parte que
   está bem. Oito confirmações seguidas de dois defeitos fazem a pessoa passar
   por tudo que já está bem.
4. **Só o delta.** Uma linha é o update inteiro quando uma coisa aconteceu;
   "CI verde, entrando o merge" é um status completo. Ressalva que você já
   disse e que ficou igual ganha uma oração apontando para ela, e volta
   inteira só quando a pessoa está prestes a agir contra ela ou quando você
   entrega o trabalho.
5. **O que depende de quem lê ganha bloco próprio**, separado do que só
   informa — a decisão, o acesso, a revisão. Diga o que trava enquanto aquilo
   falta, e até quando.
6. **Diga quando sai o próximo update**, ou que evento produz ele. "Quando o
   CI terminar" é resposta; silêncio é o que faz as pessoas perguntarem.
7. **Valores exatos**: a branch, o número, a execução, a linha do erro. Diga
   o que falta, onde "quase pronto" diz só como parece.

Quando o destino é um canal ou uma pessoa que pode ter perdido o update
anterior, uma oração de âncora — "desde terça: …" — carrega o elo, e a
recapitulação fica fora. Escrevendo o primeiro update, diga isso na primeira
linha e dê o estado atual no lugar de um delta.

Confira o rascunho contra as regras acima e corrija o que falhar antes de
entregar.

Entrega: em prosa quando o destino é esta conversa; em bloco de código quando
vai para outro lugar, no registro daquela superfície — comentário em card pega
o painel estreito, então parágrafos lisos, com cabeçalho e tabela deixados
para a PR.

Só rascunho: ele fica aqui mesmo com o destino nomeado e uma ferramenta
alcançando ele. Nomear para onde vai diz o endereço; notificar alguém espera
a palavra do usuário.
