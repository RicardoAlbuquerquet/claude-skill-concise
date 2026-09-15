Draft the PR for the current branch. First read
`.cursor/rules/concise-pull-request.mdc`; it defines the writing rules.

Parse `(Your arguments: whatever you typed after the command name, when there was any.)`:
- first resolvable git ref → base;
- literal `create` → permission to open the PR;
- everything else → context.
Default base: `origin/main`.

(Your arguments: whatever you typed after the command name, when there was any.)

Process:

1. `git fetch`; inspect `git log <base>..HEAD --oneline` and `<base>...HEAD`.
   Use commits for intent and the diff/files for actual behavior.
   If there are no commits, say so and stop.
2. Use an existing PR template if present in the repository.
3. Look for a related card/issue in conversation or reachable `gh`/MCP context.
   If none is found, continue without references.
4. Write the PR according to the reference. Describe behavior, not line changes.
   For UI-less features, testing may be a direct route/call with its body.
5. Validate against the reference and remove repetition. Keep prose ≤25 lines
   without dropping caveats, required values, or code fences.

Output:
- PR title on its own line;
- body inside a four-backtick fence;
- afterward, only unresolved branch information as `Missing: ...`, one per line.

By default, only draft. Run `gh pr create` only when `(Your arguments: whatever you typed after the command name, when there was any.)` contains the
literal word `create`, using exactly the generated title and body, then report
the URL.

Do not create the PR if there are zero commits, required information is
missing, `gh` is unauthenticated, or the branch is not remote. Still return
the draft and state the blocker.
