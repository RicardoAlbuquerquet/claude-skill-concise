---
description: Audit concise violations — quote, rule, fix
argument-hint: "[text, file, PR/issue URL — empty audits previous reply]"
---

Audit a finished text against the `concise` checklist. Report only; rewriting
belongs to `/concise:rewrite`.

Resolve `$ARGUMENTS` in order:
1. existing file path → read it;
2. reachable PR/issue → fetch its body;
3. otherwise → use the argument as text;
4. empty → audit your previous reply.

$ARGUMENTS

Process:

1. Get the exact text. If a file/reference cannot be reached, report the
   failure and stop; never reconstruct it.
2. Identify the destination: chat, PR, issue/task, commit, or comment.
   If unclear, assume chat and state that.
3. Send the text and destination to the `audit` agent.
4. Return its report unchanged in content and order. If you disagree with one
   finding, add one brief line afterward explaining why.

Output:
- start with `N violations, M holes` or `clean`;
- include every violation and hole;
- if clean, stop after that line.

Then add exactly one final line with the `/concise:rewrite` invocation that
would fix the findings. Do not rewrite or modify the source here.