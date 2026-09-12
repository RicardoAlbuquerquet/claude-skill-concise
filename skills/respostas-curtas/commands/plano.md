---
description: Rascunha o plano para aprovação — passos, risco, o que fica de fora
argument-hint: "[para que é o plano — vazio usa o trabalho em discussão]"
---

Escreva um plano para aprovação, seguindo a seção "Recomendações, escolhas e
planos" das regras de `respostas-curtas`. Invoque a skill antes se as regras
completas estiverem ausentes do contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o trabalho mais
recente em discussão nesta conversa.

$ARGUMENTS

Isto rascunha o *texto* de um plano; o plan mode e o passo 1 ficam desligados
até quem lê aprovar — a pessoa está decidindo se deixa você gastar o tempo
dela, e essa decisão acontece depois da leitura.

Regras do plano:

- **Ele abre com o que você vai fazer**; o que você descobriu para chegar
  aqui fica nas suas anotações. A primeira linha é o passo 1 e a última é o
  último passo.
- **Passos numerados que você vai rodar de verdade**, em ordem, cada um
  nomeando o arquivo que toca ou o comando que roda. `src/auth/refresh.rs` e
  `npm test -- auth` são passos; "investigar o fluxo de auth" é o que você já
  fez para escrever isto.
- **Um passo, uma ação.** Passo com "e então" dentro são dois passos, e quem
  aprova precisa ver qual metade é qual.
- **O risco, nomeado** — o que pode quebrar, o que é irreversível, do que você
  está em dúvida e só descobriria começando. A seção de risco é o que mostra
  que o plano foi testado. Qualquer coisa que reescreve estado compartilhado
  — force-push, migração, branch apagada — ganha linha própria, separada do
  passo a que pertence.
- **O que fica de fora**, quando alguém razoavelmente esperaria aquilo no
  escopo.
- **O que você precisa dele antes do passo 1** — um acesso, uma decisão, um
  valor que falta — vai em bloco próprio, separado do que só informa.
- **Fundamente antes de escrever.** Leia os arquivos que os passos nomeiam.
  Passo apontando para uma função que falta é descoberto por quem lê, depois
  de ter aprovado. Diga quais passos ficaram por verificar.
- **Desenhe quando bifurca** — plano com três ou mais saltos, com retry ou com
  caminho de rollback ganha o ASCII em bloco de código, setas rotuladas.

Confira o rascunho contra as regras acima e corrija o que falhar antes de
entregar.

Entrega: o plano em prosa na conversa, já que ele é lido aqui para ser
aprovado. Em bloco de código só quando a invocação disser que ele vai para
outro lugar — um card, um documento, uma mensagem — e aí o registro daquela
superfície vem das regras. Depois dele, só o que você precisa de quem lê.

Só rascunho: o passo 1 começa na aprovação de quem lê, dada num turno
seguinte.
