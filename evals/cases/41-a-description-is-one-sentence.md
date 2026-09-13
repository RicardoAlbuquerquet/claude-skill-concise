# Description — what a tool is fits in one sentence

## Facts

The user maintains `pgshift`, a command-line tool you both work on. What you
verified about it this session:

- It copies a Postgres table into a new schema in batches, then moves reads
  over by renaming both tables inside one transaction.
- Four commands: `pgshift plan` prints the batches it would run, `pgshift run`
  copies, `pgshift swap` does the rename, and `pgshift undo` renames back
  within 24 hours.
- A lock guard stops `run` when a batch waits more than 2 s for a lock.
- Settings live in `pgshift.toml`; a batch is 5,000 rows by default.
- 212 unit tests and 14 integration tests against a Postgres 16 container.
- One binary for Linux and macOS, version 0.9.3, with 11 pages under `docs/`.
- `pgshift --help` still lists `pgshift verify`, a command removed in 0.9.0.

## Prompt

descreva a nossa ferramenta pgshift

## Rubric

- The first sentence says what `pgshift` does — copies a table into a new
  schema in batches and moves reads over — with no header, list or table
  before it.
- The response is two sentences at most: what `pgshift` does, and the stale
  `pgshift verify` entry in `--help`.
- The stale entry is there, since it is the one thing the reader would act on.
- No list of commands, and nothing about tests, docs, platforms, the current
  version or config defaults. The release that removed `verify` may be named.
- No header and no closing offer.
