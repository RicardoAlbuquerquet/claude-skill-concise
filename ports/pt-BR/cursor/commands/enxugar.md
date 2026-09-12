Tire do código o texto que carrega zero: comentário, docstring, mensagem de
log e de erro, e o texto que uma pessoa lê na tela. Leia
`.cursor/rules/respostas-curtas-codigo.mdc` antes: as regras moram lá, e
aqui só o procedimento.

(Seus argumentos: o que você digitou depois do nome do comando, quando houver.)

Como:

1. **O alvo.** Os caminhos do argumento, quando houver — diretório quer dizer
   os arquivos de código dentro dele. Vazio, os arquivos que esta branch
   mudou: `git diff --name-only origin/main...HEAD` mais o que ficou por
   commitar. Quando os dois vêm vazios, diga isso e pare. Código gerado,
   código de terceiros, lockfile e migration de banco ficam fora do alvo.
2. **Leia antes de cortar.** Cada arquivo inteiro, e a convenção em volta
   dele: quanto os vizinhos comentam, onde moram os textos — no próprio código
   ou num catálogo como `locales/` ou `messages/` — e quais testes conferem
   texto.
3. **Corte o que o arquivo corta**: o comentário que a linha de baixo já diz,
   o comentário sobre uma edição, código comentado, banner, a docstring que
   reconta a assinatura; na tela, a segunda vez que a mesma coisa é dita, o
   botão com um `OK` seco, a palavra de tom, o toast de uma mudança que a
   pessoa viu acontecer.
4. **Mantenha o que o arquivo mantém, e o que só parece morto**: diretiva
   dentro de comentário (`eslint-disable`, `@ts-expect-error`,
   `# type: ignore`), cabeçalho de licença, docstring que um gerador de
   documentação publica, e JSDoc que carrega os tipos num projeto JavaScript.
5. **Texto muda junto com tudo que casa com ele.** Antes de mudar um texto
   visível, procure por ele no repo — teste, snapshot, outro idioma, cliente
   que lê a mensagem de erro — e mude tudo junto. Quando uma parte tem que
   ficar — idioma que você traduziria mal, mensagem que outro sistema lê —
   deixe o texto como estava e reporte.
6. **Rode as checagens do próprio repo** no que você tocou — os scripts de
   teste e lint que ele define — e guarde a linha que prova o resultado.

O commit é do usuário, e código que roda fica como está: nome, condição ou
estrutura ficam fora do escopo mesmo quando leem mal.

Entregue como trabalho concluído: os arquivos mudados e a linha das checagens
— e antes dos dois, quando houver, o que você deixou no lugar de propósito, uma
linha cada, com o motivo. O diff mostra os textos que mudaram; a entrega deixa
a contagem e o antes/depois para ele.
