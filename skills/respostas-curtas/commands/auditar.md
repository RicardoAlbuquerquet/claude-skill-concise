---
description: Reporta as violações de respostas-curtas num rascunho — citação, regra, correção — a reescrita fica separada
argument-hint: "[texto, um caminho de arquivo, uma URL de PR ou issue — vazio audita sua resposta anterior]"
---

Audite um texto pronto contra o checklist de `respostas-curtas` e reporte o
que uma reescrita teria de corrigir. Isto reporta; a reescrita é
`/respostas-curtas:reescrever`.

Resolva o alvo pelo argumento abaixo, nesta ordem: caminho para um arquivo que
existe é lido e auditado; referência de PR ou issue que uma ferramenta alcança
(`gh`, um board MCP) tem o corpo buscado e auditado — o corpo, no lugar do
diff; qualquer outra coisa é o próprio texto; vazio mira sua própria resposta
anterior nesta conversa.

$ARGUMENTS

Como:

1. **Pegue o texto primeiro.** Se o caminho falta ou a referência está fora
   de alcance, diga qual das duas falhou e pare — texto reconstruído carrega
   violações próprias.
2. **Nomeie o destino** — resposta de chat, descrição de PR, card de tarefa ou
   issue, mensagem de commit, comentário — porque ele decide que checagens
   valem. Com o destino por dizer e por deduzir do texto, audite como
   resposta de chat e diga que assumiu isso.
3. **Entregue ao agente `auditar`** com o texto inline e o destino nomeado. O
   agente guarda o checklist; rodar lá mantém a auditoria separada da conversa
   que produziu o rascunho.
4. **Repasse o relatório como ele voltou.** A saída do agente é a resposta — a
   linha de veredito, as violações numeradas, os buracos — inteira e na ordem
   dela, toda violação incluída. Quando você achar que o agente errou numa
   delas, diga isso em uma linha depois do relatório, com o motivo.

Entrega: o relatório sozinho. Ele abre com o veredito — `N violações, M
buracos` ou `limpo` — e texto limpo termina aí, em uma linha.

Depois do relatório, uma linha só: a invocação exata de
`/respostas-curtas:reescrever` que corrigiria o que ele achou. A reescrita, a
edição do arquivo e a correção na PR ou no card são chamadas separadas, e de
quem pediu.
