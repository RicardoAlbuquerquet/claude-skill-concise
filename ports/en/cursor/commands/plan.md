Draft one plan for approval following the `concise` ruleset. If its full rules
are missing, invoke the skill first.

Use the argument as the subject; if empty, use the work most recently discussed.

(Your arguments: whatever you typed after the command name, when there was any.)

This only drafts the plan. Step 1 starts on approval, in a later turn.

Rules:

1. Start directly with numbered execution steps, in order.
2. Each step must be one concrete action and name the file touched or command run.
3. Ground the plan first: read every file referenced by a step. Mark any
   unverified step explicitly.
4. Add **Risks**: what may break, is irreversible, or remains uncertain.
   Shared-state changes such as migrations, force-pushes, or deletions get
   their own risk line.
5. Add **Out of scope** when something could reasonably be expected but is excluded.
6. Add **Needed before step 1** only for access, decisions, or missing values
   required to begin.
7. If the flow has 3+ hops, retries, branches, or rollback paths, include a
   labelled ASCII flow in a fenced block.

Keep the investigation that led here in your notes.

Validate the draft against these rules before delivering it.

Output the plan as prose in the conversation. Use a fenced block only when
the argument explicitly says the plan is for another surface such as a card,
document, or message.

After the plan, include only information needed from the reader.

Draft only: execution starts only after explicit approval in a later turn.
