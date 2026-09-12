# Texto no código e na tela

## Crenças

- **O que você escreve dentro de uma aplicação é lido por gente que vê aquilo
  ali pela primeira vez**: quem mexe no código depois, num comentário, e quem
  usa o produto, na tela — no meio de outra tarefa, e lendo cada coisa uma
  vez.
- **A casa do diff é o commit.** Depois do merge, comentário sobre a edição
  aponta para uma versão que só o git ainda guarda.
- **A densidade de comentário de um arquivo é a convenção dele.**
- **Texto que um teste, um snapshot ou outro idioma conferem** quebra tudo
  isso quando muda sozinho.

## Desejos

- Quem mexe no código depois lê só o que o código deixa por dizer, e quem está
  na tela lê cada coisa uma vez e mantém tudo com que decide.

## Intenções

- **Comentário diz o que o código deixa por dizer** — por que é assim, a
  armadilha, a unidade: `// o banco recusa mais de 2 casas decimais: arredonde
  antes de assinar`. A maioria das linhas se sustenta sozinha. O que a linha
  de baixo já diz sai (`// incrementa o contador`), e sai também a docstring
  que reconta a assinatura em palavras.
- **A edição em si fica no commit**: "agora usa o cliente novo", "corrigido o
  race", "era 30" descrevem o diff.
- **Código comentado sai, e sai também o banner dividindo o arquivo**;
  arquivo com zero comentários mantém a densidade dele.
- **Mensagem nomeia o que falhou, com o valor, e o que fazer**:
  `porta "80a" em config.yaml não é número` ganha de `Configuração inválida`.
  Na tela, o mesmo nas palavras de quem usa — stack trace, código de status e
  "Ops" ficam fora.
- **Tela diz cada coisa uma vez**: subtítulo repetindo o título (`Faturas`
  sobre `Veja e gerencie suas faturas`), placeholder repetindo o rótulo,
  tooltip repetindo o botão, toast de uma mudança que a pessoa acabou de ver
  acontecer — cada um é a mesma frase duas vezes, e a segunda sai.
- **Botão é o verbo do que ele faz** — `Salvar rascunho`, `Excluir` — onde
  `OK` e `Clique aqui` dizem o que qualquer botão faz; e confirmação pergunta
  com a consequência: `Cancelar o plano? O acesso acaba em 31 de maio.`
- **Palavra de tom sai**: "por favor", "com sucesso", "simplesmente", ponto de
  exclamação, a linha dando boas-vindas a uma página que a pessoa já abriu.
- **O que só parece cortável fica**: a consequência de uma ação irreversível,
  o valor com que a pessoa decide (um preço, um prazo, um tamanho de arquivo),
  onde o resultado chega quando falta espaço na tela para mostrar, a única
  saída de um erro, o texto que lei ou contrato exige, e o nome acessível —
  botão só de ícone mantém o `aria-label` quando a palavra visível sai.
- **Texto muda em todo teste, snapshot e idioma que confere com ele de uma
  vez, ou fica como está.**
