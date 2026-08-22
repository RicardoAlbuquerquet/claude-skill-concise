---
description: Passa o trabalho adiante — o estado completo, toda ressalva de pé de volta por inteiro, as armadilhas, e o comando exato que retoma
argument-hint: [quem assume, ou que parte do trabalho — opcional]
---

Escreva uma passagem de trabalho, seguindo a lista "nunca corte" das regras de
`respostas-curtas` — em especial a cláusula que diz que ressalva de pé volta
**por inteiro** quando você entrega o trabalho. Invoque a skill antes se as
regras completas não estiverem no contexto.

O argumento abaixo diz quem assume isso — uma pessoa, você mesmo depois, a
próxima sessão — ou restringe a uma parte do trabalho. Vazio, escreva para
alguém competente que não estava nesta conversa.

$ARGUMENTS

Passagem é o oposto de update de status, e confundir os dois é o modo de falha
inteiro. Update é o delta desde o último e larga o que quem lê já tem.
Passagem assume que quem lê não tem **nada**: nenhuma memória desta conversa,
nenhuma ressalva que você deu três mensagens atrás, nenhuma ideia de qual das
quatro coisas que você mexeu está terminada. Tudo que um update ganha o direito
de deixar de fora, a passagem tem que devolver.

Como:

1. **Leia o estado, não lembre dele.** `git status`, `git log --oneline` na
   branch e contra a base dela, `gh pr list --head <branch>` ou o tracker para
   o que está aberto. O que você lembra ter feito e o que está commitado de
   fato divergem justamente onde a passagem dói mais.
2. **Onde está, em valores exatos**: a branch, o sha curto do último commit, o
   número da PR e o estado dela, o card ou a issue. Nunca "na branch da
   feature" — o nome.
3. **Pronto contra o que falta**, como duas coisas separadas. Pronto quer
   dizer pronto e verificado; o que você escreveu mas nunca rodou não está
   pronto, e dizer qual é o ponto. O que falta carrega o critério de pronto
   dele, para quem assume saber onde parar.
4. **Toda ressalva de pé, por inteiro.** A restrição que você disse uma vez e
   depois só apontou com uma oração, a suposição sobre a qual o trabalho se
   apoia, aquilo que você decidiu não tratar. Passagem é onde "como eu
   mencionei" custa uma hora de quem lê, porque essa pessoa não estava lá
   quando você mencionou.
5. **As armadilhas**, que é a parte que só você consegue escrever: o que
   parece terminado e não está, o que os testes não cobrem, o comando que
   precisa rodar numa ordem específica, o estado que você deixou sujo de
   propósito. Se nada te surpreendeu, diga isso em vez de inventar uma.
6. **O que foi decidido e por quê**, uma linha cada — o suficiente para quem
   assume não reabrir questão resolvida, nem desfazer ela sem perceber. Uma
   opção descartada ganha a linha dela aqui, não uma seção.
7. **O comando exato que retoma o trabalho** — o checkout, a instalação, a
   rodada de teste — em bloco executável, no shell de quem vai ler.
8. **O que está travado e em quem**, com o que para se aquilo não vier.

Antes de entregar, audite o rascunho você mesmo — nada que só faça sentido
para quem leu esta conversa, toda ressalva de volta por inteiro em vez de
apontada, pronto e faltando separados, valor exato em vez da descrição dele,
sem narração de processo, e o comando de retomada de fato executável — e
corrija o que falhar. Entregue só a versão limpa.

Entrega: em prosa quando a passagem fica nesta conversa; em bloco de código
quando vai para um card, um documento ou uma mensagem, com quatro crases
quando ela carrega uma cerca própria — o comando de retomada carrega.
Cabeçalho ganha lugar aqui como em qualquer canto: o estado, o que falta, as
armadilhas e o comando de retomada são funções diferentes, e passagem grande o
bastante para ter as quatro é grande o bastante para nomeá-las.

Nada depois dela além do que você não conseguiu estabelecer pelo repo ou pela
conversa, uma linha cada, abrindo com **Não sei:**.

Só rascunho: nunca publique, nunca abra nem mova nada, mesmo quando o
argumento nomeia uma pessoa ou um destino que uma ferramenta alcança. Nomear
quem assume diz para onde vai; não é permissão para enviar.
