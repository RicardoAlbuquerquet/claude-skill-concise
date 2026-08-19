---
description: Escreve um card de tarefa/issue que se sustenta sozinho — atual → esperado, valor exato, critério de pronto — e cria quando o destino for dado
argument-hint: [sobre o que é o card, e opcionalmente onde criar]
---

Produza um card de tarefa/issue seguindo a seção "Tarefa e issue" das regras
de `respostas-curtas`. Invoque a skill antes se as regras completas não
estiverem no contexto.

O assunto é o texto abaixo. Se estiver vazio, o assunto é o problema ou
trabalho mais recente discutido nesta conversa.

$ARGUMENTS

Regras do card:

- **Quem vai ler não estava na conversa.** O corpo se sustenta sozinho: sem
  "como conversamos", sem referência a este chat. Valor exato — caminho,
  comando, linha do erro, número, ambiente — e não a descrição dele; se a
  conversa não produziu um valor que o card precisa, nomeie o buraco em vez
  de inventar.
- **Todo card carrega:** título com o verbo da ação; comportamento atual e
  depois o esperado, em duas frases; valores exatos; critério de pronto em
  uma linha; escopo fechado — um "e também" são dois cards, então diga isso e
  rascunhe o primeiro.
- **Quando o caso pedir:** passos de reprodução numerados (com frequência se
  for intermitente), impacto com quem sente, dependências com link, o anexo
  que prova.
- **Estrutura de painel estreito:** parágrafos curtos e no máximo uma lista;
  sem cabeçalho, sem tabela, negrito só como rótulo de item. Prioridade,
  responsável e prazo são campos, não corpo — o *motivo* do prazo, esse sim é
  corpo.

Antes de entregar, audite o rascunho contra o checklist do card você mesmo —
verbo no título, atual → esperado, valores exatos, critério de pronto, sem
cabeçalho nem tabela, corpo que se sustenta sozinho — e corrija o que
falhar. Entregue só a versão limpa.

Entrega: título na primeira linha, corpo em bloco de código, pronto para
colar. Cerque com quatro crases quando o corpo carregar uma cerca própria —
comando de reprodução carrega — para o invólucro não terminar na de dentro.

Quando a invocação nomeia um destino — um board, um repo, um projeto — e
existe ferramenta para ele (MCP, `gh`), crie lá depois do rascunho, nesta
ordem:

1. **Procure o card que já existe** — busque no destino pelo sintoma ou
   assunto. Candidato provável é linkado e reportado, em vez de duplicata
   criada do lado.
2. **No GitHub, honre o template de issue**: escolha o formulário que casa em
   `.github/ISSUE_TEMPLATE/`, mantenha os cabeçalhos, preencha neste
   registro — "nenhum" onde não há o que dizer.
3. **Campo, não texto**: descubra o que o destino oferece — etiquetas,
   membros, status, prioridade — e ponha nos campos o que a conversa definiu.
   O que ninguém definiu fica no default, e você diz isso.
4. **Ligue o que é ligado**: bloqueador ou pai nomeado ganha o link real —
   relação ou subtarefa no board, referência `#numero` no GitHub.
5. Crie, e reporte o id ou link — mais os campos que você preencheu e os que
   ficaram no default.

Sem destino, entregue só o rascunho e diga onde ele pode ir. Nunca crie em
lugar que não foi nomeado.
