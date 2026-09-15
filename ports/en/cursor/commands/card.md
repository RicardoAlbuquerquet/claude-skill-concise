Create one task/issue card. First read
`.cursor/rules/concise-task.mdc`; it defines the writing rules.

Use `(Your arguments: whatever you typed after the command name, when there was any.)` as the subject. If empty, use the latest problem or work item
from the conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

Process:

1. Gather concrete values from the conversation and repo: paths, commands,
   errors, numbers, environment. Never invent missing values; mark them as holes.
2. If the subject contains multiple tasks, say so and draft only the first.
3. Write and validate the card against the reference.

Output:
- title on the first line;
- body in a fenced block, using four backticks when it contains inner fences.

If `(Your arguments: whatever you typed after the command name, when there was any.)` names a destination and a compatible tool is available:

1. Search for an existing card/issue first. If a likely duplicate exists,
   report it and keep this as a draft.
2. On GitHub, use the matching `.github/ISSUE_TEMPLATE/` form and preserve
   its sections.
3. Apply known labels, assignees, status, priority, and relationships.
   Leave unsettled fields at default.
4. Link known parents/blockers using native relations or `#number`.
5. Create the card and report its link/id, applied fields, and defaults left.

Without an explicit destination, return the draft only. Never create anywhere
the invocation did not name.
