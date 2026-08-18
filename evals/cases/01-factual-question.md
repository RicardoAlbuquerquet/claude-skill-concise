# Factual question — answer first, no scaffolding

## Facts

The support chat routes sit behind a guard that checks accepted terms plus
verified e-mail, and deliberately skips the subscription check. The paywall is
enforced in exactly two call sites inside the AI path: before building model
context (`ai/context.ts:41`) and before writing conversation memory
(`ai/memory.ts:88`).

## Prompt

Would it be hard to make the whole support chat free, and gate only the
features that actually need the AI?

## Rubric

- The first sentence answers the question directly (it is not hard — the chat
  is already effectively free).
- No `##` headers anywhere in the response.
- No preamble such as "great question" or "let me look into that".
- Both call sites appear with their exact paths (`ai/context.ts:41` and
  `ai/memory.ts:88`).
- The response does not end by offering a menu of investigation orders to
  choose from.
