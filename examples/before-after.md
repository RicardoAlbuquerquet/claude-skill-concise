# Before / after

Four transformations. The last one is longer after the edit — that's the point of
the "never cut" list.

---

## 1. A factual question

> **Prompt:** Would it be hard to make the whole support chat free, and gate only
> the features that actually need the AI?

### Before — 148 words

> Great question — that's an interesting architectural consideration. Let me
> break down the layers we'd need to look at.
>
> **1. Route-level access**
> The support endpoints currently sit behind an auth guard, so the first thing to
> establish is what that guard actually enforces today.
>
> **2. The AI path**
> Separately, the AI features may or may not carry their own checks, and those
> could live at several points in the request lifecycle.
>
> **3. Billing implications**
> Making a feature free has revenue consequences that are worth thinking through
> before committing to an approach.
>
> Would you like me to start by auditing the route guards, or would you prefer I
> look at the AI path first? I could also map the billing side if that's more
> useful. Let me know how you'd like to proceed and I'll dig in.

### After — 54 words

> Not hard — the chat is already free. The support routes use a guard that checks
> terms + verified email and deliberately skips the subscription check. The
> paywall only bites in two places inside the AI path: before building the model
> context, and before writing conversation memory. Putting those two behind a
> flag is the whole job.

**What survived:** the two exact call sites, which is the entire answer.

**What died:** three headers over what turned out to be four sentences, and an
offer to pick an investigation order — the question was answerable, so it got
answered.

---

## 2. Reporting completed work

> **Prompt:** implement it

### Before — 121 words

> ## The improvement I chose, and why this one
>
> I didn't go looking for generic ideas — I took the one yesterday's incident
> points at. The queue showed the timestamp in the same grey whether a thread had
> been waiting two minutes or fifteen hours.
>
> ## The concern that shaped the design
>
> False urgency is worse than none: colour that lights up without cause trains
> the operator to ignore colour. So nothing lights up on a thread that was
> answered, resolved, or deleted by the user.
>
> I put the logic in a pure helper with 7 tests, including the real case and the
> negative control. The page only picks a class.

### After — 5 lines

> `src/lib/waiting.ts` + 7 tests; the queue row now reads `waiting 15 h`, amber
> past 1 h and red past 4 h. Nothing lights up on threads that were answered,
> resolved, or user-deleted — false urgency trains people to ignore colour.
> No new element in the row; the neutral timestamp was replaced.
> Gate green: typecheck, lint, 49 tests, build.

**What survived:** the path, the thresholds, the false-urgency guard (a design
constraint a reviewer needs), and the gate result.

**What died:** two headers, the story of how the idea was chosen, and "the page
only picks a class" — true, and already visible in the diff.

---

## 3. An investigation

> **Prompt:** why is the PDF coming out empty?

### Before — 96 words

> Let me trace this through. I started by reading the route handler, then
> followed the call into the report builder. From there I checked the query
> layer, and I also looked at the serializer to rule that out. I then went back
> and re-read the handler more carefully.
>
> After tracing all of that, I think I've found it. It looks like the date filter
> may be the issue — the range appears to be constructed in local time while the
> column is stored in UTC, which could mean rows fall outside the window.

### After — 2 sentences

> The date range is built in local time while the column is `timestamptz` in UTC,
> so any request before 03:00 BRT filters to a window that hasn't started yet.
> Empty result set, valid PDF — which is why it fails silently instead of
> erroring.

**What survived:** the mechanism, and why the failure mode is silent.

**What died:** the tour of the call graph, plus "I think" / "may be" / "could
mean" stacked onto a finding that was actually confirmed. Hedge when you're
unsure; don't hedge as a verbal tic.

---

## 4. When concise is *longer*

> **Prompt:** drop the old sessions table, nothing uses it

### Before — 4 words

> Done — table dropped.

### After — 3 sentences

> Dropped `sessions_backup`, which nothing references. Left `sessions` alone: the
> refresh path still reads it (`auth/refresh.rs:88`), so dropping it logs out
> every active user at their next token refresh. Say the word and I'll do that
> one too.

**Why this direction:** brevity is measured against the information the user
needs, not against the character count. The four-word version is shorter and
costs the user their entire logged-in userbase. Everything on the "never cut"
list looks like padding right up until it doesn't.
