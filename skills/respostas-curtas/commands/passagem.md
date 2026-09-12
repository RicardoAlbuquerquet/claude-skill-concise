---
description: Passa o trabalho adiante — estado completo, toda ressalva, o comando que retoma
argument-hint: "[quem assume, ou que parte do trabalho — opcional]"
---

Escreva uma passagem de trabalho, seguindo a lista "Sempre fica" das regras
de `respostas-curtas` — em especial a cláusula que diz que ressalva de pé
volta **por inteiro** quando você entrega o trabalho. Invoque a skill antes
se as regras completas estiverem ausentes do contexto.

O argumento abaixo diz quem assume isso — uma pessoa, você mesmo depois, a
próxima sessão — ou restringe a uma parte do trabalho. Vazio, escreva para
alguém competente que estava longe desta conversa.

$ARGUMENTS

Passagem é o oposto de update de status, e distinguir os dois é o trabalho
inteiro. Update é o delta desde o último e larga o que quem lê já tem.
Passagem assume que quem lê parte do zero: a conversa, a ressalva que você
deu três mensagens atrás e qual das quatro coisas que você mexeu está
terminada têm que estar nela. Tudo que um update ganha o direito de deixar
de fora, a passagem devolve.

Como:

1. **Leia o estado no repo**: `git status`, `git log --oneline` na branch e
   contra a base dela, `gh pr list --head <branch>` ou o tracker para o que
   está aberto. O que você lembra ter feito e o que está commitado de fato
   divergem justamente onde a passagem dói mais.
2. **Onde está, em valores exatos**: a branch, o sha curto do último commit, o
   número da PR e o estado dela, o card ou a issue — o nome em si, no lugar
   de "a branch da feature".
3. **Pronto contra o que falta**, como duas coisas separadas. Pronto quer
   dizer pronto e verificado; o que você escreveu e deixou por rodar continua
   aberto, e dizer qual é o ponto. O que falta carrega o critério de pronto
   dele, para quem assume saber onde parar.
4. **Toda ressalva de pé, por inteiro.** A restrição que você disse uma vez e
   depois só apontou com uma oração, a suposição sobre a qual o trabalho se
   apoia, aquilo que você decidiu deixar quieto. Passagem é onde "como eu
   mencionei" custa uma hora de quem lê, porque essa pessoa estava longe
   quando você mencionou.
5. **As armadilhas**, que é a parte que só você consegue escrever: o que
   parece terminado e continua aberto, o que os testes deixam descoberto, o
   comando que precisa rodar numa ordem específica, o estado que você deixou
   sujo de propósito. Quando toda armadilha já está listada, diga isso.
6. **O que foi decidido e por quê**, uma linha cada — o suficiente para quem
   assume manter fechada a questão resolvida e a decisão no lugar. Uma opção
   descartada ganha a linha dela aqui, em vez de uma seção.
7. **O comando exato que retoma o trabalho** — o checkout, a instalação, a
   rodada de teste — em bloco executável, no shell de quem vai ler.
8. **O que está travado e em quem**, com o que para enquanto aquilo falta.

Confira o rascunho contra as regras acima e corrija o que falhar antes de
entregar.

Entrega: em prosa quando a passagem fica nesta conversa; em bloco de código
quando vai para um card, um documento ou uma mensagem, com quatro crases
quando ela carrega uma cerca própria — o comando de retomada carrega.
Cabeçalho ganha lugar aqui como em qualquer canto: o estado, o que falta, as
armadilhas e o comando de retomada são funções diferentes, e passagem grande o
bastante para ter as quatro é grande o bastante para nomeá-las.

Depois dela, só o que o repo e a conversa deixaram em aberto, uma linha cada,
abrindo com **Em aberto:**.

Só rascunho: ela fica na conversa, mesmo quando o argumento nomeia uma pessoa
ou um destino que uma ferramenta alcança. Nomear quem assume diz para onde
vai, e o envio espera a palavra do usuário.
