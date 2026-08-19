---
description: Escreve a descrição da PR da branch atual — ancorada no diff real, com os passos de teste exatos no fim
argument-hint: [ref base — padrão origin/main]
---

Escreva a descrição da pull request da branch atual, seguindo a seção de PR
das regras de `respostas-curtas`. Invoque a skill antes se as regras
completas não estiverem no contexto.

A base é a ref abaixo se vier, senão `origin/main`:

$ARGUMENTS

Como:

1. Rode `git fetch`, depois `git log <base>..HEAD --oneline` — os títulos
   dos commits carregam o porquê — e então o diff `<base>...HEAD`: primeiro
   os nomes de arquivo, o diff em si onde os nomes não bastarem. Leia o
   suficiente dos arquivos mudados para descrever **comportamento**, não
   linhas. Se a branch não tem commits sobre a base, diga isso e pare; nunca
   invente descrição.
2. Procure o template do repo: `.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE.md`, `docs/`, ou o diretório
   `.github/PULL_REQUEST_TEMPLATE/`. Quando existe, é contrato: mantenha os
   cabeçalhos dele e preencha neste registro — seção sem nada a dizer ganha
   um "nenhum", e caixa de checklist só é marcada quando é verdade.
3. Primeira linha: o que a PR faz. Depois dela, só o que o revisor não tira
   mais rápido do próprio diff: o que muda para quem usa, decisões tomadas
   com seus custos, o que ficou fora do escopo, e qualquer coisa não
   verificada — nomeada como não verificada. Quando o diff atravessa muitos
   arquivos, uma linha diz por onde começar a ler — o arquivo onde o
   mecanismo vive.
4. Sem cabeçalho seu de template sobre conteúdo curto, sem prosa repetindo o
   diff, sem narração de processo, sem crédito a agente de IA em lugar
   nenhum. Várias entregas viram lista curta — uma linha cada, rótulo
   primeiro — nunca parágrafo emendado com ponto-e-vírgula.
5. Termine com os passos de teste: o comando exato copiável, o que aparece se
   estiver certo, e o que provaria que quebrou quando o comando não cobre o
   caso. Quando você não rodou um passo, diga isso dentro do próprio passo.

Antes de entregar, audite o rascunho contra o checklist você mesmo — primeira
linha diz o que a PR faz, valores exatos em span, entregas em lista, passos
de teste com os não rodados marcados — e corrija o que falhar. Entregue só a
versão limpa.

Entregue o título primeiro, em linha própria — o que muda quando mescla,
verbo primeiro, pronto para o `gh pr create --title`. Depois a descrição em
bloco de código, pronta para colar no `--body` ou no formulário do GitHub.
Nada depois do bloco além de buracos que você não conseguiu preencher pela
branch, uma linha cada, abrindo com **Faltou:**.
