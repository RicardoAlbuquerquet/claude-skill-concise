---
description: Audita um rascunho pelo checklist de respostas-curtas e reporta só as violações — linha citada, regra quebrada, correção em uma linha. Diagnóstico, nunca cirurgia
argument-hint: "[texto, um caminho de arquivo, uma URL de PR ou issue — vazio audita sua resposta anterior]"
---

Audite um texto pronto contra o checklist de `respostas-curtas` e reporte o
que uma reescrita teria de corrigir. Isto reporta; não reescreve.

Resolva o alvo pelo argumento abaixo, nesta ordem: caminho para um arquivo que
existe é lido e auditado; referência de PR ou issue que uma ferramenta alcança
(`gh`, um board MCP) tem o corpo buscado e auditado — o corpo, não o diff;
qualquer outra coisa é o próprio texto; vazio mira sua própria resposta
anterior nesta conversa.

$ARGUMENTS

Como:

1. **Pegue o texto primeiro.** Se o caminho não existe ou a referência não
   pode ser buscada, diga qual das duas falhou e pare — auditar um texto que
   você teve de reconstruir reporta violações que o texto real pode não ter.
2. **Nomeie o destino** — resposta de chat, descrição de PR, card de tarefa ou
   issue, mensagem de commit, comentário — porque ele decide que checagens
   valem. Quando a invocação não disse e o texto não deixa óbvio, audite como
   resposta de chat e diga que assumiu isso.
3. **Entregue ao agente `auditar`** com o texto inline e o destino nomeado. O
   agente guarda o checklist; rodar lá evita que a auditoria seja contaminada
   pela conversa que produziu o rascunho.
4. **Repasse o relatório como ele voltou.** A saída do agente é a resposta — a
   linha de veredito, as violações numeradas, os buracos. Não suavize, não
   reordene, não acrescente um parágrafo concordando, e não some com uma
   violação de que você discorda. Quando você achar que o agente errou numa
   delas, diga isso em uma linha depois do relatório, com o motivo.

Entrega: o relatório e nada mais. Ele abre com o veredito — `N violações, M
buracos` ou `limpo` — e texto limpo termina aí, em uma linha, sem resumo do
que ele acertou.

Depois do relatório, uma linha só: a invocação exata de
`/respostas-curtas:reescrever` que corrigiria o que ele achou. Nunca reescreva
o texto aqui, nunca edite o arquivo, e nunca publique correção na PR nem no
card. A correção é outra chamada, e ela é de quem pediu.
