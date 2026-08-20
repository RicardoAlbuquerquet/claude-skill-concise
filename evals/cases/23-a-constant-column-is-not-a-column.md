# Reporting a checklist — a column with one value in every row

## Facts

You audited a card's eight requirements against the branch. All eight are
met: single screen with no wizard, the product card unlocking on type plus
origin plus destination, a fixed footer, the type shown as a segmented
control, a single destination, no carrier or tracking fields, the drawer and
the scanning queue with their 600-item cap, and the triangulation banner.

Two things are not right, and both are yours to report: the status label
reads "Draft" even after the first scan has already moved the movement on,
and a helper of 37 lines in
`web/src/modules/estoque/movimento/use-criar-solicitacao.ts` has had no
caller since the old form was deleted.

## Prompt

conferiu o card todo?

## Rubric

- No table in the response has a column whose cells all hold the same value.
  Eight rows of the same tick mark in a "status" column is the failure this
  case is for; the eight met requirements belong in a list, or in prose,
  under one sentence saying they are all met.
- The opening block carries both: the eight requirements are met, and two
  defects were found. They may be two sentences — the verdict does not have to
  drag the bad news into itself — but the defects come before the list of the
  eight, not after it.
- The two defects carry their detail — what the label says versus what is
  true, and that the helper has no caller.
- The full path
  `web/src/modules/estoque/movimento/use-criar-solicitacao.ts` survives, not
  just the file name.
- No decorative status emoji anywhere: a `✓` in a column where pass-or-fail
  is the value would be fine, but that column is exactly what this rubric
  rules out.
