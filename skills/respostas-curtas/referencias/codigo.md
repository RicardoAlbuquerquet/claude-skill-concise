# Texto no código e na tela

## Crenças

- **O que você escreve dentro de uma aplicação é lido por quem nunca viu esta
  conversa**: quem mexe no código depois, num comentário, e quem usa o
  produto, na tela — no meio de outra tarefa, e sem ler nada duas vezes.
- **A casa do diff é o commit.** Depois do merge, comentário sobre a edição
  aponta para uma versão que ninguém vê, e o git guarda o código antigo.
- **A densidade de comentário de um arquivo é a convenção dele.**
- **Texto que um teste, um snapshot ou outro idioma conferem** quebra tudo
  isso quando muda sozinho.

## Desejos

- Quem mexe no código depois lê só o que o código não diz, e quem está na
  tela lê cada coisa uma vez e nunca perde aquilo com que decide.

## Intenções

- **Comentário diz o que o código não diz** — por que é assim, a armadilha, a
  unidade: `// o banco recusa mais de 2 casas decimais: arredonde antes de assinar`.
  A maioria das linhas não precisa de nenhum. O que a linha de baixo já diz
  sai (`// incrementa o contador`), e sai também a docstring que reconta a
  assinatura em palavras.
- **Nada sobre a própria edição**: "agora usa o cliente novo", "corrigido o
  race", "era 30" descrevem o diff.
- **Sem código comentado, sem banner dividindo o arquivo**, e sem um
  comentário por função num arquivo que não tem nenhum.
- **Mensagem nomeia o que falhou, com o valor, e o que fazer**:
  `porta "80a" em config.yaml não é número`, nunca `Configuração inválida`. Na
  tela, o mesmo nas palavras de quem usa — sem stack trace, sem código de
  status, sem "Ops".
- **Tela diz cada coisa uma vez**: sem subtítulo repetindo o título
  (`Faturas` sobre `Veja e gerencie suas faturas`), sem placeholder repetindo
  o rótulo, sem tooltip repetindo o botão, sem toast de uma mudança que a
  pessoa acabou de ver acontecer.
- **Botão é o verbo do que ele faz** — `Salvar rascunho`, `Excluir` — nunca
  `OK` ou `Clique aqui`, e confirmação pergunta com a consequência:
  `Cancelar o plano? O acesso acaba em 31 de maio.`
- **Palavra de tom sai**: "por favor", "com sucesso", "simplesmente", ponto de
  exclamação, a linha dando boas-vindas a uma página que a pessoa já abriu.
- **O que só parece cortável fica**: a consequência de uma ação irreversível,
  o valor com que a pessoa decide (um preço, um prazo, um tamanho de arquivo),
  onde o resultado chega quando a tela não consegue mostrar, a única saída de
  um erro, o texto que lei ou contrato exige, e o nome acessível — botão só de
  ícone mantém o `aria-label` quando a palavra visível sai.
- **Texto muda em todo teste, snapshot e idioma que confere com ele de uma
  vez, ou não muda.**
