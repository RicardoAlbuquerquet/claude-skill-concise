---
description: Rewrite finished text to the concise rules without losing facts
argument-hint: "[text, file path, or empty for previous reply]"
---

Rewrite one finished text to comply with the `concise` ruleset. If the rules
are unavailable, invoke the `concise` skill first.

Target resolution:
- existing file path → read and rewrite its contents;
- empty argument → rewrite your previous reply;
- otherwise → rewrite the argument itself.

$ARGUMENTS

Rules:

- Preserve every fact, value, caveat, commitment, bad result, and scope note.
- Add required information only when it can be derived from the original.
  Otherwise report it as missing. Every value and result comes from the original.
- Match the destination. For PRs, cards, commits, changelogs, code comments,
  or similar surfaces, read the corresponding file under
  `${CLAUDE_PLUGIN_ROOT}/references/`. Chat replies follow the budgets table.

Output only:
1. the rewritten text;
2. when intended for another surface, place it in a copyable fenced block
   (four backticks if it contains fences);
3. `Missing: ...` lines only for required information absent from the source.

A file target changes only when the user asks. The delivery is the text
alone, with word counts and commentary on the cuts left out.