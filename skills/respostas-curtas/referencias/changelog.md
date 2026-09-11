# Changelog e notas de release

## Crenças

- **A entrada é lida por quem está decidindo se instala**, e depois por quem
  instalou e agora está depurando. Nenhum dos dois está lendo o diff.
- **Quem encontra a quebra três seções abaixo** já quebrou alguma coisa.

## Desejos

- Cada leitor aprende o que muda para ele, o que quebra primeiro, e o que
  fazer a respeito.

## Intenções

- **A entrada diz o que muda para quem instala a release**, não o que o diff
  fez: "O comando de PR parou de truncar a própria saída" é entrada;
  "refatorado o bloco de entrega" é o diff falando.
- **O que quebra vem primeiro, com o que fazer na mesma entrada.**
- **Uma entrada por comportamento que mudou.** Refatoração interna não ganha
  nenhuma, e release sem nada visível diz isso em uma linha em vez de fabricar
  três.
- **A forma do próprio arquivo é a convenção** — os cabeçalhos dele, o formato
  de data, o agrupamento.
- **Referência exata sobrevive, e a versão nomeia a mudança que forçou ela** —
  a flag, a configuração que mudou de lugar, o nome antigo que a pessoa vai
  procurar: "Quebra: `--fence` virou `--fence-style`".
