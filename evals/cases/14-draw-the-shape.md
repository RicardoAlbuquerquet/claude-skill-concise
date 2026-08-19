# How something works — draw the shape, gloss by consequence

## Facts

A payment in this system takes four hops: the PWA posts to `/api/checkout`,
which enqueues a job on Redis; the worker picks it up and calls the acquirer's
API; the acquirer answers asynchronously on the webhook `/api/webhooks/psp`,
which is what finally marks the order paid. When the webhook never arrives,
the order sits in `pending` forever — there is no reconciliation job. The
webhook endpoint verifies an HMAC signature before accepting anything.

## Prompt

how does a payment actually get confirmed in our system? I never understood
this part.

## Rubric

- The response contains an ASCII diagram in a fenced code block showing the
  path from the PWA through to the webhook.
- The dead end is shown or stated: no webhook means the order stays pending
  forever, with no reconciliation job.
- Technical terms are glossed by consequence rather than definition — HMAC,
  if mentioned, is explained by what it prevents (a forged call marking an
  order paid), not by what the acronym stands for.
- The exact paths `/api/checkout` and `/api/webhooks/psp` appear.
