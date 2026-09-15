Write one concise status update using the `concise` ruleset. If unavailable,
invoke the skill first.

`(Your arguments: whatever you typed after the command name, when there was any.)` identifies the reader/destination. If empty, write for the person
in this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

Process:

1. Find the previous update. Do not repeat what the reader already knows.
2. Verify what changed in the repo, CI, and tracker since then.
3. Lead with bad news: failures, skipped steps, changed estimates, or shared
   state mutations.
4. Report only the delta, using exact branches, runs, values, and errors.
5. Put anything waiting on the reader in a separate block, including what is
   blocked and any deadline.
6. End with when or under what event the next update happens.

If the reader may not have the previous update, add one short anchor such as
`Since Tuesday: ...`; do not recap the full history.

For the first update, say so and report the current state instead of a delta.

Delivery:
- this conversation → plain prose;
- external destination → fenced block in that surface's natural style.

Draft only. Naming a destination does not authorize posting or notifying
anyone; wait for explicit permission.
