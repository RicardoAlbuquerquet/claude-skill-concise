Rewrite one finished text to comply with the `concise` ruleset. If the rules
are unavailable, read `.cursor/rules/concise-full.mdc` first.

Target resolution:
- existing file path → read and rewrite its contents;
- empty argument → rewrite your previous reply;
- otherwise → rewrite `(Your arguments: whatever you typed after the command name, when there was any.)`.

(Your arguments: whatever you typed after the command name, when there was any.)

Rules:

- Preserve every fact, value, caveat, commitment, bad result, and scope note.
- Add required information only when it can be derived from the original.
  Otherwise report it as missing. Never invent values or results.
- Match the destination. For PRs, cards, commits, changelogs, code comments,
  or similar surfaces, read the corresponding file under
  `.cursor/rules/`. Chat replies follow the budgets table.

Output only:
1. the rewritten text;
2. when intended for another surface, place it in a copyable fenced block
   (four backticks if it contains fences);
3. `Missing: ...` lines only for required information absent from the source.

Do not modify file targets unless explicitly asked. Do not include word counts,
cut explanations, or other commentary.
