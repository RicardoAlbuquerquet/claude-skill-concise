Produza um card de tarefa/issue. Leia
`.cursor/rules/respostas-curtas-tarefa.mdc` antes: as regras moram lá, e
aqui só o procedimento.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o problema ou
trabalho discutido mais recentemente nesta conversa.

(Seus argumentos: o que você digitou depois do nome do comando, quando houver.)

Como:

1. Junte os valores exatos que o card precisa — caminho, comando, linha do
   erro, número, ambiente — da conversa e do repo. Valor que a conversa
   deixou de fora é nomeado como buraco; o card carrega só valores que
   existem.
2. Quando o assunto são dois cards ("e também"), diga isso e rascunhe o
   primeiro.
3. Escreva como a referência diz, depois confira o rascunho contra ela e
   corrija o que falha.

Entrega: título na primeira linha, corpo em bloco de código, pronto para
colar — quatro crases quando o corpo carrega um bloco próprio, como comandos
de reprodução carregam.

Quando a invocação nomeia um destino — um board, um repo, um projeto — e há
ferramenta para ele (MCP, `gh`), crie lá depois de rascunhar:

1. **Procure no destino o sintoma ou o assunto primeiro.** Um candidato
   provável é linkado e reportado, e o card continua rascunho.
2. **No GitHub, use o formulário que casa em `.github/ISSUE_TEMPLATE/`**: os
   cabeçalhos dele mantidos, preenchidos neste registro, "nenhum" onde a
   seção está vazia.
3. **Campo, depois texto**: descubra o que o destino oferece — etiquetas,
   membros, status, prioridade — e ponha nos campos o que a conversa definiu.
   O que ficou em aberto mantém o default, e você diz isso.
4. **Ligue o que está conectado**: bloqueador ou pai nomeado ganha o link real
   — relação ou subtarefa no board, `#número` no GitHub.
5. Crie, depois reporte o id ou link, os campos que você preencheu e os que
   ficaram no default.

Com o destino ausente, entregue só o rascunho e diga para onde ele pode ir.
Crie só onde a invocação nomeou.
