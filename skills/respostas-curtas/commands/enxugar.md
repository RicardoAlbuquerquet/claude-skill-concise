---
description: Tira o texto morto do código e da tela — comentário que repete o código, texto que repete a tela
argument-hint: "[caminhos — vazio mira os arquivos que esta branch mudou]"
---

Tire do código o texto que não carrega nada: comentário, docstring, mensagem de
log e de erro, e o texto que uma pessoa lê na tela. Siga a seção "Texto no
código e na tela" das regras de `respostas-curtas`; se as regras completas não
estiverem no contexto, invoque a skill `respostas-curtas` primeiro.

$ARGUMENTS

Como:

1. **O alvo.** Os caminhos do argumento, quando houver — diretório quer dizer
   os arquivos de código dentro dele. Vazio, os arquivos que esta branch
   mudou: `git diff --name-only origin/main...HEAD` mais o que não foi
   commitado. Quando nenhum dos dois dá arquivo, diga isso e pare. Código
   gerado, código de terceiros, lockfile e migration de banco nunca são alvo.
2. **Leia antes de cortar.** Cada arquivo inteiro, e a convenção em volta
   dele: quanto os vizinhos comentam, onde moram os textos — no próprio código
   ou num catálogo como `locales/` ou `messages/` — e quais testes conferem
   texto.
3. **Corte o que a seção corta**: o comentário que a linha de baixo já diz, o
   comentário sobre uma edição, código comentado, banner, a docstring que
   reconta a assinatura; na tela, a segunda vez que a mesma coisa é dita, o
   botão sem verbo, a palavra de tom, o toast de uma mudança que a pessoa viu
   acontecer.
4. **Mantenha o que a seção mantém, e o que só parece morto**: diretiva dentro
   de comentário (`eslint-disable`, `@ts-expect-error`, `# type: ignore`),
   cabeçalho de licença, docstring que um gerador de documentação publica, e
   JSDoc que carrega os tipos num projeto JavaScript.
5. **Texto muda junto com tudo que casa com ele.** Antes de mudar um texto
   visível, procure por ele no repo — teste, snapshot, outro idioma, cliente
   que lê a mensagem de erro — e mude tudo junto. Quando uma parte não pode
   mudar — idioma que você não traduz com fidelidade, mensagem que outro
   sistema lê — deixe o texto como estava e reporte.
6. **Rode as checagens do próprio repo** no que você tocou — os scripts de
   teste e lint que ele define — e guarde a linha que prova o resultado.

Nunca commite, e nunca reescreva código que roda: nome, condição ou estrutura
ficam fora do escopo mesmo quando leem mal.

Entregue como trabalho concluído: os arquivos mudados e a linha das checagens
— e antes dos dois, quando houver, o que você deixou no lugar de propósito, uma
linha cada, com o motivo. Sem contagem do que saiu e sem antes/depois dos
textos: o diff mostra.
