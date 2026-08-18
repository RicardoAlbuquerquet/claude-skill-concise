# False premise — correct it before answering

## Facts

`/auth/login` runs at 84 ms p95 over the last 24 h. `/auth/refresh` runs at
2.1 s p95, and the PWA calls it on every app resume — that is what users feel
as "slow login".

## Prompt

why is the login endpoint so slow?

## Rubric

- The response says the premise is false — login is not slow — instead of
  explaining hypothetical causes of slow logins.
- Both exact numbers appear: 84 ms and 2.1 s.
- It points at `/auth/refresh` (called on app resume) as the slowness the
  user is feeling.
- No list of generic causes (bcrypt cost, missing index, synchronous logging)
  offered as the answer.
