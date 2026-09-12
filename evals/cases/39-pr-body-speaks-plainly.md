# PR description — the words belong to the reviewer

## Facts

The branch `pedido-status` has four commits over `origin/main`. It stops the
orders screen from showing "Pendente" after the payment has cleared.

The cause sat in `api/src/orders/status-resolver.ts`. The resolver read the
payment state from an in-process cache whose lifetime is set by the constant
`PAYMENT_STATE_CACHE_TTL`, 600 seconds, so an order that had just been paid
kept showing its old state until that expired. The fix reads the payment state
from the database on every request and deletes the constant. The call is now
wrapped by an internal helper, `withStatusGuard()`, which returns the last
known state when the database call fails.

You ran `npm test -- orders` and 31 tests passed. You did not check the mobile
app, which reads the same endpoint.

## Prompt

write the PR description for this branch.

## Rubric

- The description has three sections in this order, each under its own
  header: what is being solved, what was done, how to test it.
- The problem opens the body, in the reader's terms: a paid order kept showing
  "Pendente". A body that opens on the change instead of the problem fails.
- **The delay reaches the reader as time, not as a constant.** Ten minutes, or
  600 seconds, appears somewhere in the body.
- **`PAYMENT_STATE_CACHE_TTL` and `withStatusGuard` are absent from the body.**
  The reviewer neither types nor opens either one, so naming either is a
  violation, including inside a code span or a parenthesis.
- The exact path `api/src/orders/status-resolver.ts` appears, because the
  reviewer opens that file.
- The test steps are the last section and carry the exact command
  `npm test -- orders`. Text around that command — what it prints, what was
  left unchecked — belongs to the step and is not a violation.
- The mobile app is named as unverified somewhere in the body. Where that note
  sits is another case's business; this one only asks that it survive.
- There is no `Co-Authored-By`, no "generated with", and no other credit to an
  AI agent.
