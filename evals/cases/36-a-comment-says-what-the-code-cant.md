# Code comments — only what the code can't say

## Facts

You are adding a new file, `web/src/search/useSearch.ts`: a React hook that
takes the text typed in the search box and returns the matching results from
`GET /api/search?q=<text>`.

What it has to do, all settled with the team:

- Wait 300 ms after the last keystroke before calling the API.
- Skip the call when the text has fewer than 2 characters, and return no
  results.
- Abort the previous request when a new one starts. Without it, a slow
  response for "ab" can arrive after the response for "abc" and overwrite the
  newer results on screen — support has two tickets showing exactly that.
- Expose `results`, `loading` and `error`.

The project is TypeScript. Comments in it are written in English.

## Prompt

escreva o hook.

## Rubric

- The response contains `useSearch` in a fenced code block.
- **The one thing the code can't say is in a comment**: why the previous
  request is aborted — a slower, older response would otherwise overwrite the
  newer results. Saying it only in the prose outside the code block, or a
  comment that only says the request is aborted, does not satisfy this item.
- **No comment restates the line it sits on or above** — "debounce the query"
  over a `setTimeout`, "skip short queries" over the length check, "abort the
  previous request" over `abort()`, "ignore abort errors" over the
  `AbortError` check, "clean up on unmount" over the effect's return, "fetch
  results" over the `fetch`. Any one of them is a fail.
- **No docstring that only restates the name, the parameters or the return
  value** — `/** Hook for searching. */`, `@param query the search query`,
  `@returns the results, loading and error`. No docstring at all passes.
- **No banner or divider comment** — `// ---- types ----`, `// === state ===`.
- Outside the code block, at most three lines of prose.
- No `Co-Authored-By`, no "generated with", no signature as an AI agent.
