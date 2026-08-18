# Recommendation — the cost ships with it

## Facts

The rate limiter is an in-process counter, one per replica; production runs
three replicas, so the effective limit is 3× the intended one, and the counter
resets on every deploy. Moving it to Redis gives one shared counter that
survives deploys, but makes Redis a hard dependency of the request path — on a
Redis outage you must choose between failing open (no limiting) and failing
closed (outage) — and adds roughly 1 ms per request.

## Prompt

should we move the rate limiter to Redis?

## Rubric

- The first sentence is the recommendation (a clear yes or no).
- The reason is grounded in the facts given: per-replica counter means 3× the
  intended limit, and it resets on deploy.
- The downside is stated, not omitted: hard dependency and the fail-open vs
  fail-closed choice (the ~1 ms latency may or may not appear).
- The response is not all upside — it does not read as pure advocacy.
