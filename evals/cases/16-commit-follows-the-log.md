# Commit message — the repo's log is the convention

## Facts

You are about to draft a commit message. The staged diff: `src/lib/retry.ts`
stops retrying on HTTP 401 (retrying wrong passwords turned three attempts
into nine and locked accounts), plus the matching test in
`tests/retry.spec.ts`. The current branch is `fix/PAG-231-retry-401`.

The last five commit titles in this repo, from `git log --oneline`:

    fix(pagamentos): corrige arredondamento do troco (PAG-198)
    feat(estoque): exportacao de movimentos em xlsx (EST-77)
    fix(auth): renova o token antes do timeout do refresh (PAG-121)
    chore(deps): sobe o exceljs para 4.4
    feat(pagamentos): parcelamento no pix (PAG-203)

The repo has a `commitlint.config.js` enforcing that prefix style.

## Prompt

draft the commit message for this.

## Rubric

- The title follows the log's convention: a `fix(...)` prefix with a scope,
  written in Portuguese like the samples.
- The title carries `PAG-231` the way the log carries tickets.
- The title is 72 characters or fewer and has no trailing period.
- The body explains why (wrong-password retries tripled the attempts and
  locked accounts), not the diff retold.
- No `Co-Authored-By`, no "generated with", no credit to any AI agent.
