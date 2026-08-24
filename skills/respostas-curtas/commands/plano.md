---
description: Rascunha o plano que você propõe — os passos numerados que você vai rodar, o risco nomeado, o que fica de fora. Só texto; não roda nada
argument-hint: "[para que é o plano — vazio usa o trabalho em discussão]"
---

Escreva um plano para aprovação, seguindo a seção "Plano que você propõe" das
regras de `respostas-curtas`. Invoque a skill antes se as regras completas não
estiverem no contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o trabalho mais
recente em discussão nesta conversa.

$ARGUMENTS

Isto rascunha o *texto* de um plano. Não entra em plan mode e não executa
passo nenhum — quem lê está decidindo se deixa você gastar o tempo dele, e
essa decisão acontece depois da leitura.

Regras do plano:

- **Ele abre com o que você vai fazer**, não com o que você descobriu para
  chegar aqui. Sem repetir o pedido antes dos passos, sem resumo do plano
  depois deles.
- **Passos numerados que você vai rodar de verdade**, em ordem, cada um
  nomeando o arquivo que toca ou o comando que roda. `src/auth/refresh.rs` e
  `npm test -- auth` são passos; "investigar o fluxo de auth" é o que você já
  fez para escrever isto.
- **Um passo, uma ação.** Passo com "e então" dentro são dois passos, e quem
  aprova não consegue dizer qual metade você vai errar.
- **O risco, nomeado** — o que pode quebrar, o que é irreversível, do que você
  não tem certeza e só descobriria começando. Plano sem seção de risco lê como
  plano que ninguém testou. Qualquer coisa que reescreve estado compartilhado
  — force-push, migração, branch apagada — sai em linha própria, não dobrada
  dentro de um passo.
- **O que fica de fora**, quando alguém razoavelmente esperaria aquilo no
  escopo.
- **O que você precisa dele antes do passo 1** — um acesso, uma decisão, um
  valor que você não tem — vai em bloco próprio, separado do que só informa.
- **Fundamente antes de escrever.** Leia os arquivos que os passos nomeiam.
  Passo apontando para uma função que não existe é descoberto por quem lê,
  depois de ter aprovado. Diga quais passos você não conseguiu verificar.
- **Desenhe quando bifurca** — plano com três ou mais saltos, com retry ou com
  caminho de rollback ganha o ASCII em bloco de código, setas rotuladas.

Antes de entregar, audite o rascunho você mesmo — a primeira linha diz o que
você vai fazer, todo passo nomeia arquivo ou comando, risco presente, fora de
escopo dito, nada que seja exploração vestida de passo — e corrija o que
falhar. Entregue só a versão limpa.

Entrega: o plano em prosa na conversa, já que ele é lido aqui para ser
aprovado. Em bloco de código só quando a invocação disser que ele vai para
outro lugar — um card, um documento, uma mensagem — e aí o registro daquela
superfície vem das regras. Nada depois dele além do que você precisa de quem
lê.

Só o rascunho: não comece o passo 1, e não trate a aprovação do plano como
dada dentro do mesmo turno que propôs ele.
