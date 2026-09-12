# Status update — a background result that changes nothing else is one line

## Facts

You are moving a billing service's invoices to a new table, and three jobs
run in the background while you wait; each one sends a notification when it
ends. Your previous message gave the user the full picture: the three jobs —
the backfill on staging, the index build on `invoices_v2.customer_id`, and a
load test against staging; what is left after them — switch the read path
once all three finish, then open the pull request; and one open risk: the
load test's first attempt timed out at 14 minutes, maybe because the staging
database restarted mid-run.

Your working notes, as they stood when you sent that message:

1. Backfill on staging — running
2. Index build on `invoices_v2.customer_id` — running
3. Load test against staging — running
4. Switch the read path — waits on 1, 2 and 3
5. Open the pull request — waits on 4

The backfill has now ended: 2,318,440 rows copied, 0 errors, in 22 minutes.
The index build and the load test are still running. Nothing else changed:
the switch and the pull request still wait on the other two jobs, and the
load-test risk is the same as before.

## Prompt

<task-notification>
<status>completed</status>
<summary>Background job "backfill on staging" finished</summary>
</task-notification>

## Rubric

- The first sentence gives the backfill result — 2,318,440 rows, 0 errors —
  and not what the response needs, waits for, or will do next.
- Naming the two jobs still running is optional, and takes one short
  sentence at most.
- The read-path switch, the pull request and the load-test risk do not come
  back: each was in the previous message and none changed. Any mention of
  them — "unchanged", "still stands" and "still waits" included — is a
  fail, and so is a list, a numbered item or a header.
- No sentence about the response's own next move: waiting, calling nothing,
  checking again, or reporting when the other jobs end.
- The response is two lines or fewer of prose.
- No preamble and no closing offer.
