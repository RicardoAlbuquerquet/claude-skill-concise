# Tasks and issues

## Beliefs

* A task or issue must **stand alone**; the reader may see it weeks later without the original conversation.
* The title is scanned first, so it must say what changes quickly.
* Do not repeat tracker fields in the body.
* Duplicates split discussion and waste triage.
* Keep decision history out unless it changes what must be done.

## Desires

* Someone with only the card should know **what changes, why it matters, and when it is done**.

## Intentions

Every card includes:

* **Title:** affected area first when useful, then the symptom or action.
* **Current behavior:** what happens now.
* **Expected behavior:** what should happen instead.
* **Exact values:** paths, commands, errors, versions, environments, numbers.
* **Done when:** one clear acceptance criterion.
* **Out of scope:** what this card intentionally does not cover when ambiguity is possible.

Add when relevant:

* **Repro:** numbered steps and failure frequency.
* **Impact:** who is affected and how.
* **Dependencies/blockers:** linked when known.
* **Evidence:** screenshot, log, payload, trace ID, or equivalent.

## Title

The title must describe the change, not only the topic.

Prefer:

`Documents: bold renders as raw asterisks`

Avoid:

`Invoice filter`

Do not repeat information already carried by labels or tracker fields.

## Body

Default structure:

Current behavior.

Expected behavior.

**Where:** affected files, settings, or environment
**Done when:** acceptance criterion
**Out of scope:** excluded work
**Repro:** steps, when needed
**Impact:** affected users or systems
**Reverts:** rollback information, when relevant

Keep one label per line.

## Structure

* Keep most cards under ~15 lines.
* Use headers only when the body exceeds ~15 lines and has distinct sections.
* Use tables only for real comparisons with several rows and columns.
* Keep technical references in prose only when the reader will open, type, or use them; move the rest to **Where**.
* Never write references such as “as discussed” or “the issue you mentioned”. State the fact directly.

## Scope

* One card should represent one deliverable.
* If the description requires “and also” for unrelated work, split it.
* State excluded scope when someone could reasonably expand the task.

## Creating through a tracker

* Put priority, assignee, labels, and similar metadata in their fields, not the body.
* Follow the repository or tracker issue template when one exists.
* Search for an existing card first; update or link it instead of creating a duplicate.
* Describe the remaining work, not the history of how it was discovered.
