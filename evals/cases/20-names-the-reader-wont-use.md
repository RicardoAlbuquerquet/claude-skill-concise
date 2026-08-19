# Investigation — the names the reader will never use

## Facts

Invoices closed today show yesterday's total on the billing dashboard. You
traced it.

The dashboard does not sum invoices live. It reads a pre-computed daily total,
written by `InvoiceRollupJob.buildDailySnapshot` into the table
`invoice_rollup_daily` and read back through
`InvoiceAggregateRepository.fetchDailyRollup`. That copy is held for
`CACHE_TTL_ROLLUP_SECONDS = 86400` — 24 hours — so an invoice closed at 10:00
today does not appear in the total until tomorrow's rebuild.

Dropping that constant to `300` leaves the dashboard at most five minutes
behind. The rebuild is one query over roughly 4 000 rows, measured at 120 ms
on staging, so running it every five minutes is cheap.

A staleness guard exists and would have caught this, but it is off: the flag
`billing.rollup.v2` is `false` in production and has to be switched on by hand
in the admin panel — the deploy will not do it.

The invoice list itself reads live and was always correct. Only the dashboard
total is stale, which is why support kept closing these tickets as "cannot
reproduce".

## Prompt

por que o total do faturamento mostra o valor de ontem?

## Rubric

- The first sentence gives the cause in terms of what the reader sees — the
  dashboard total comes from a copy rebuilt once a day rather than from the
  invoices themselves — not in terms of a class, a table, or a method.
- The values the reader acts on survive: the 24 hours of staleness, the
  proposed five minutes (`300`), and the flag `billing.rollup.v2`, which has
  to be switched on by hand.
- The names that are only evidence appear nowhere in the response:
  `InvoiceRollupJob.buildDailySnapshot`, `invoice_rollup_daily`,
  `InvoiceAggregateRepository.fetchDailyRollup`. The reader asked why a number
  is wrong, not where the code lives; naming any of these is a fail even when
  the sentence around it is correct. `CACHE_TTL_ROLLUP_SECONDS` is the
  exception and is not graded either way — it is the setting the response asks
  them to approve changing, not evidence of the hunt.
- The cached copy is explained by what it causes, never defined — "a TTL is a
  time-to-live in seconds", "a rollup is a pre-aggregation", and the like are
  failures.
- It says the invoice list itself was always right, so the reader knows the
  edge of the bug.
- The cost of the change is stated: the rebuild runs every five minutes
  instead of daily, at ~120 ms over ~4 000 rows.
