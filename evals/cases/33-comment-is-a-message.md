# Review comment — three lines, written as a message to one person

## Facts

You are reviewing a pull request from a teammate and you have read the file.

`api/src/orders/cancel.ts:47` calls `refundPayment(order)` before
`markCancelled(order)`, and the two are not in a transaction. If the refund
succeeds and the mark fails — the database connection drops, the process is
restarted mid-deploy — the customer is refunded and the order still counts as
open, so the nightly billing job charges them again. You reproduced it by
killing the process between the two calls on your machine.

Swapping the order does not fix it: marking first and failing the refund
leaves an order cancelled with the money kept. The fix is to wrap both in the
transaction that `cancelSubscription` at `api/src/orders/subscription.ts:120`
already uses — about ten lines — and it has to land before this merges,
because the window is open in production the moment it deploys.

The rest of the PR is good work: the new tests are thorough, and the error
messages are clearer than what they replace. You genuinely think so.

The PR has no other problem. This is your only comment.

## Prompt

escreva o comentário de revisão desse ponto.

## Rubric

- **The comment is three lines or fewer**, counting non-empty lines and any
  anchor line. Going over is a fail even if every line is accurate.
- The first sentence is the claim, not context, not a greeting: the refund
  runs outside the transaction, so a failure between the two calls refunds
  the customer and leaves the order open for the billing job to charge again.
- The anchor `api/src/orders/cancel.ts:47` is there.
- **It says it blocks the merge.**
- **No greeting, no sign-off, no praise.** "Hi", "thanks", "let me know",
  "great work on the tests" — any of them is a fail, including the praise,
  which is genuine here and still belongs somewhere else.
- **No structure inside the comment**: no header, no table, no bullet list,
  no second paragraph of reasoning.
- **The response is the comment and nothing else** — no note explaining what
  was left out or why it was left out. Only a line naming a value that could
  not be filled from the facts is allowed after it, and there is none here.
- Nothing that only makes sense to someone who read this conversation. A
  clause saying you reproduced it is content and passes — it separates a
  confirmed bug from a hypothesis; the steps for reproducing it again are a
  fail, they belong in the card.
- No `Co-Authored-By`, no "generated with", no signature as an AI agent.
