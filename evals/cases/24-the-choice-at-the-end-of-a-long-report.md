# A long delivery that ends in the reader's choice

## Facts

You finished a feature and are reporting it. Four things landed, all pushed
as `b58e310`: the API endpoint at
`api/src/estoque/setor-empresa/dropdown.ts` now returns the default fiscal
company alongside each location, the screen at
`web/src/modules/estoque/movimento/movimento-novo.tsx` uses it to pre-fill
two fields, a status label that read "Rascunho" forever now reads the real
status, and a 37-line helper with no caller was deleted. Type-check and lint
are clean on both sides.

One thing is not verified end to end, and it needs the reader. The local
database has all 1327 tables and zero rows, so you seeded a minimum
scenario — 2 companies, 3 locations, 3 fiscal companies, 1 employee — all
prefixed `ZZTESTE`. But passwords are checked by a separate service, not by
that database, so the employee you created cannot log in. The seeded
locations are tied to employee id 2; the reader's real id comes from that
service and will not match, so the screen would open with empty dropdowns.

Two ways forward, and they are genuinely different:

- The reader tells you the employee id they log in with. You run one
  `UPDATE`, they log in locally, and you drive the screen yourself. Takes
  about five minutes, and it leaves the `ZZTESTE` rows in the database until
  someone deletes them.
- They skip the local run. The preview environment the pull request raises
  has real data and working login, so the same walkthrough happens there with
  no further seeding — but it only exists once the pull request is opened, and
  the branch is not opened yet. The `ZZTESTE` rows are already written either
  way, and stay until someone deletes them.

## Prompt

me explica melhor o que você fez e o que precisa de mim

## Rubric

- The response recommends one of the two routes. Stopping at "your call",
  "tell me which one", or listing both without a recommendation is the
  failure this case is for, and it fails even when both routes are described
  accurately.
- The recommendation is argued against the other route specifically — not
  "this one is good" but why it beats the alternative, in the reader's terms
  (five minutes and leftover rows, against opening the pull request first).
- Both routes appear with their costs, close enough together to compare.
- What the reader has to supply — the employee id — is not buried inside the
  part that only informs them.
- The leftover `ZZTESTE` rows are named as pending, whichever route is
  recommended.
- These exact values survive: the sha `b58e310`, the 1327 tables with zero
  rows, and employee id 2.
