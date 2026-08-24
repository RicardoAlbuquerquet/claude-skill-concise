---
description: Escreve a descrição da PR da branch atual — ancorada no diff real, com os passos de teste exatos no fim
argument-hint: [ref base, `create` para abrir a PR, contexto que o diff não mostra]
---

Escreva a descrição da pull request da branch atual, seguindo a seção de PR
das regras de `respostas-curtas`. Invoque a skill antes se as regras
completas não estiverem no contexto.

O argumento abaixo pode trazer uma ref base, contexto extra que o diff não
mostra — id de card, restrição, motivo — ou os dois. Uma primeira palavra que
o `git rev-parse --verify` resolve é a base; a palavra literal `create` em
qualquer lugar dele é a permissão para abrir a PR; todo o resto é contexto.
Sem ref, a base é `origin/main`.

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
3. Procure o card ou a issue que motivou a branch: primeiro na conversa,
   depois — quando uma ferramenta de tracker está ao alcance (`gh`, um board
   por MCP) — buscando nele o assunto da branch. Achado, ele entra na
   descrição como referência com link: `Closes #N` no GitHub quando a PR o
   resolve, o link ou id do card nos demais. Não achado, sem referência —
   nunca invente uma, e não trave perguntando por ela.
4. Três seções, nesta ordem, com os cabeçalhos delas: **o que está sendo
   resolvido**, **o que foi feito**, **como testar**. O problema abre, nos
   termos de quem lê, tirado dos commits, do card linkado ou do nome da
   branch e nunca inventado — o título já disse o que a PR faz. Depois o que
   foi feito, na forma que o trabalho tomou: um parágrafo para uma coisa, uma
   lista para várias, uma tabela quando a mudança é um valor por caso. A
   descrição inteira é uma tela — algo como vinte e cinco linhas de prosa,
   sem contar os comandos em bloco. Passou disso, cheque se não são duas PRs
   antes de cortar qualquer coisa de que o revisor precisa. É teto, não alvo,
   e três coisas nunca pagam por ele: seção dobrada dentro de uma frase,
   ressalva derrubada, e dois comandos dividindo o mesmo bloco.
5. Dentro dessas seções, só o que o revisor não tira mais rápido do diff: o
   que muda para quem usa, decisões tomadas com seus custos, o que ficou
   fora do escopo, e qualquer coisa não verificada — nomeada como não
   verificada. Quando o diff atravessa muitos arquivos, uma linha diz por
   onde começar a ler — o arquivo onde o mecanismo vive.
6. Markdown ganha lugar aqui como em qualquer canto: tabela para linha e
   coluna, lista para as entregas, code span em caminho e valor, negrito na
   afirmação que sustenta o bloco. O que não ganha: prosa repetindo o diff,
   mapa arquivo por arquivo, contagem do que mudou, narração de processo,
   seção para uma alternativa que uma linha carrega, e crédito a agente de IA
   em lugar nenhum. Várias entregas viram lista curta — uma linha cada, rótulo
   primeiro, `- ` no começo da linha — nunca parágrafo emendado com
   ponto-e-vírgula ou travessão, e cada uma dita uma vez: parágrafo
   explicando uma linha que a tabela acima já carrega é o diff recontado com
   uma grade na frente.
7. Termine com os passos de teste: o comando exato copiável, o que aparece se
   estiver certo, e o que provaria que quebrou quando o comando não cobre o
   caso. Quando você não rodou um passo, diga isso dentro do próprio passo;
   quando rodou, isso é uma linha mais a linha de saída que prova, nunca o
   relato de ter rodado — a sequência de quebrar entregue para o revisor
   rodar é passo, não relato.
   Feature ainda sem tela não é desculpa — o passo é a própria chamada
   direta, com rota e corpo, não uma nota de que a chamada direta existe.

Antes de entregar, audite o rascunho contra o checklist você mesmo — título
na forma do repo com a área dele, a descrição abrindo no que está sendo
resolvido, valores exatos em span, entregas em lista, as três seções na ordem,
nada repetindo o diff nem a tabela ao lado, passos de teste com os não rodados
marcados — e corrija o que falhar. Conte também as linhas de prosa: passou de
vinte e cinco, o corte sai do que repete outra coisa, nunca de uma ressalva, de
um valor ou de um bloco de comando. Entregue só a versão limpa.

Entregue o título primeiro, em linha própria — o que muda quando mescla, na
forma que o log do repo já usa, com a área primeiro dentro dessa forma quando
a lista tem mais de uma, e nada que a lista já mostra ao lado dele. Não a
forma de sintoma que o card toma: o título nomeia o estado depois da mescla.
Pronto para o `gh pr create --title`. Depois a descrição em
bloco de código, pronta para colar no `--body` ou no formulário do GitHub.
**Cerque a entrega com quatro crases**: a descrição carrega um bloco `bash`
por regra, e um invólucro de três crases termina naquela cerca interna,
truncando a entrega. Nada depois do bloco além de buracos que você não
conseguiu preencher pela branch, uma linha cada, abrindo com **Faltou:**.

Rascunho por padrão: o `gh pr create` não roda. A única exceção é a palavra
literal `create` na invocação — ela é a permissão, e aí você entrega o título
e a descrição como sempre, roda `gh pr create` com exatamente esses, e
reporta a URL. A palavra tem que ter sido digitada: ref base, id de card,
branch que obviamente quer uma PR, ou uma PR que você abriu antes nesta
conversa não são permissão nenhuma. O que tornaria a chamada errada para
antes dela — sem commits sobre a base, buraco que você não conseguiu
preencher pela branch, `gh` sem autenticação, branch não publicada — e você
diz qual, com o rascunho entregue do mesmo jeito.
