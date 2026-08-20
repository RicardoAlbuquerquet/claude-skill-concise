---
description: Escreve o update de andamento — só o delta desde o último, notícia ruim primeiro, e o que depende de quem lê em bloco próprio
argument-hint: [quem lê e para onde vai — opcional]
---

Escreva um update de andamento, seguindo o orçamento "Update de andamento no
meio do trabalho" e a lista "Nunca corte" das regras de `respostas-curtas`.
Invoque a skill antes se as regras completas não estiverem no contexto.

O argumento abaixo diz quem lê e para onde vai — uma pessoa, um canal, um
comentário no card, esta conversa. Vazio, quem lê é a pessoa com quem você já
está falando.

$ARGUMENTS

Como:

1. **Ache o update anterior** antes de escrever este — sua última mensagem
   nesta conversa, o último comentário do card, a última mensagem da thread.
   Tudo que a pessoa já tem não é notícia, e update que recomeça a história
   faz ela reler para achar as duas linhas que andaram.
2. **Ache o que mudou de verdade**, não lembre: `git log` desde aquele ponto,
   `gh run list` ou a página de CI para o portão, o tracker para o que outra
   pessoa moveu. Update reportando build verde que você não olhou é a falha
   que custa mais caro, porque depois disso a pessoa para de conferir.
3. **Notícia ruim primeiro** — teste vermelho, etapa pulada, estimativa que
   mudou, ação que reescreveu estado compartilhado. Vem antes da parte que
   está bem. Oito confirmações seguidas de dois defeitos fazem a pessoa passar
   por tudo que não precisa dela para chegar no que precisa.
4. **Só o delta.** Uma linha é o update inteiro quando uma coisa aconteceu;
   "CI verde, entrando o merge" é um status completo. Ressalva que você já
   disse e que não mudou não é notícia de novo — uma oração apontando para ela
   vale mais que o parágrafo, e ela volta inteira só quando a pessoa está
   prestes a agir contra ela ou quando você entrega o trabalho.
5. **O que depende de quem lê ganha bloco próprio**, separado do que só
   informa — a decisão, o acesso, a revisão. Diga o que trava se não vier, e
   até quando.
6. **Diga quando sai o próximo update**, ou que evento produz ele. "Quando o
   CI terminar" é resposta; silêncio é o que faz as pessoas perguntarem.
7. **Valores exatos**: a branch, o número, a execução, a linha do erro. Nunca
   "quase pronto" — diga o que falta.

Quando o destino é um canal ou uma pessoa que pode não ter o update anterior,
uma oração de âncora é permitida — "desde terça: …" — e recapitulação não é.
Quando você realmente não tem update anterior para partir, diga isso na
primeira linha e dê o estado atual em vez de um delta.

Antes de entregar, audite o rascunho você mesmo — nada que a pessoa já tinha,
notícia ruim no topo, o que está travado e em quem, valores exatos, sem
narração de processo e sem "só passando para atualizar" — e corrija o que
falhar. Entregue só a versão limpa.

Entrega: em prosa quando o destino é esta conversa; em bloco de código quando
vai para outro lugar, no registro daquela superfície — comentário em card pega
o painel estreito, então sem cabeçalho e sem tabela.

Só o rascunho: nunca publique, mesmo com o destino nomeado e uma ferramenta
alcançando ele. Nomear para onde vai não é permissão para notificar alguém.
