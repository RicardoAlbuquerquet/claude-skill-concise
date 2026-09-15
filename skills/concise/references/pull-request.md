# Pull request descriptions

## Beliefs

* The reviewer already has the diff; do not rewrite it in prose.
* The PR description should explain **the problem**, summarize **what was done**, and show **how to verify it**.
* A repository PR template is authoritative and should be preserved.
* Anything written as verified will be trusted as verified.

## Desires

* The reviewer understands the problem, sees the solution quickly, and can verify it independently.

## Intentions

### Structure

Use these sections, in order:

1. **Problem**
2. **What changed**
3. **How to test**

Open with the problem in user-facing terms, not internal implementation language.

### What changed

* Describe behavior, not internal variable or helper names.
* Keep paths, commands, endpoints, and exact values the reviewer will use.
* Use:

  * one paragraph for one change;
  * one-line bullets for multiple changes;
  * a table for values that vary by case.
* Avoid file-by-file summaries, diff restatements, and change counts.
* If the diff is large, give one line saying where review should start.
* Mention a discarded alternative only when it affects the review; keep it to one line.

### Length

Keep the description to roughly one screenful, about 25 prose lines.

Go longer only for required caveats, commands, risks, or verification details.

If the description naturally needs multiple unrelated sections or “and also”, consider splitting the PR.

### Template

* Keep repository template headers and required fields.
* Write `none` when a required section has nothing to report.
* Check boxes only when true.
* If the template lacks a place for the problem, add it at the start.

### Title and issue

* The title says **what changes**, with the affected area first, using the repository's existing style.
* Describe the post-merge behavior, not only the symptom.
* Link the motivating issue or card when one is known and verified,
