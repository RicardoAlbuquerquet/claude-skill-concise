# Completed work — what waits on the reader, apart from what informs them

## Facts

You delivered a single screen and committed it as `3740cf8` on the branch
`task/217b13a0`, cut from `project/movimento-de-estoque`. Everything the card
asked for is in, except one bullet, and two things you decided on your own:

The card's bullet "pre-fill the fiscal company from the location" rests on a
false premise: `GET /dropdown/empresas-fiscais` returns only `{id, label}` for
every fiscal company, with no link to the physical location. The server does
know the pairing (`findMovimentadorFiscalByFisico`) but does not expose it. So
you shipped the fields editable, plus a banner naming which of the two is
missing, and left the pre-fill out. Adding a `movimentadorFiscalId` column to
that dropdown response is an API change, and it is the user's call whether
that happens here or becomes its own card.

Decided by you, already in the commit: the button labelled "Finalizar Envio"
calls `preparar-envio`, not `enviar` — Envio Direto refuses `finalizar-solicitacao`
with `MOVIMENTO_ENVIO_DIRETO_NAO_SOLICITAVEL`, and `preparar-envio` is the step
that means "I finished separating". Going all the way to `enviar` is one line.
Also: after saving, the header locks — `Salvar Rascunho` sends `PATCH` with
only `editaLocal`, so changing origin or destination afterwards needs the Edit
screen's permission.

`make test-web` is green; the 3 `<img>` warnings are pre-existing, in
`ordem-servico-aparelho`. You did not open a browser — that needs a database
and a session. Nothing in the API was touched. The branch is not pushed.

## Prompt

terminou?

## Rubric

- The API-dropdown question — the one thing that needs the reader's answer —
  is not in the same block or list as the two decisions already made and
  committed; they are separated, by two headings, two lists, or an explicit
  sentence marking which needs an answer.
- No heading joins the two jobs with "or" ("decide or know", "decidir ou
  saber").
- The false premise is stated: the dropdown returns only `{id, label}`, so
  the pre-fill the card asked for cannot be built from it.
- The gate is reported with the 3 pre-existing warnings, and the response
  says the browser was not opened.
- It says the branch is not pushed.
- The exact values survive: the sha `3740cf8` and the route
  `preparar-envio`, which is the decision itself. The error constant
  `MOVIMENTO_ENVIO_DIRETO_NAO_SOLICITAVEL` is evidence, not a value the
  reader acts on — keeping it is not required, and dropping it is not a fail.
