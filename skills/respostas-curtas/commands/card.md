---
description: Escreve um card que se sustenta sozinho, e cria quando o destino for nomeado
argument-hint: "[sobre o que é o card, e opcionalmente onde criar]"
---

Produza um card de tarefa/issue. Leia
`${CLAUDE_PLUGIN_ROOT}/referencias/tarefa.md` antes: as regras moram lá, e
aqui só o procedimento.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o problema ou
trabalho discutido mais recentemente nesta conversa.

$ARGUMENTS

Como:

1. Junte os valores exatos que o card precisa — caminho, comando, linha do
   erro, número, ambiente — da conversa e do repo. Valor que a conversa não
   produziu é buraco a nomear, nunca chute.
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
   provável é linkado e reportado em vez de uma duplicata criada do lado.
2. **No GitHub, use o formulário que casa em `.github/ISSUE_TEMPLATE/`**: os
   cabeçalhos dele mantidos, preenchidos neste registro, "nenhum" onde não há
   nada a dizer.
3. **Campo, não texto**: descubra o que o destino oferece — etiquetas,
   membros, status, prioridade — e ponha nos campos o que a conversa definiu.
   O que ninguém definiu fica no default, e você diz isso.
4. **Ligue o que está conectado**: bloqueador ou pai nomeado ganha o link real
   — relação ou subtarefa no board, `#número` no GitHub.
5. Crie, depois reporte o id ou link, os campos que você preencheu e os que
   ficaram no default.

Sem destino, entregue só o rascunho e diga para onde ele pode ir. Nunca crie
em lugar que não foi nomeado.
