Draft the changelog entry and, when applicable, the release body. First read
`.cursor/rules/concise-changelog.mdc`; it defines the writing rules.

`(Your arguments: whatever you typed after the command name, when there was any.)` may contain a version, commit range, or extra context.
Default range: latest tag to `HEAD`.

(Your arguments: whatever you typed after the command name, when there was any.)

Process:

1. Resolve the range. Use the latest tag and `git log <tag>..HEAD --oneline`.
   With no tags, inspect the last 30 commits and state the assumed range.
   If empty, say so and stop.
2. Match the existing changelog's structure and style. If none exists, state
   the chosen format.
3. Inspect the diff when commits do not fully describe user-visible behavior.
4. Write according to the reference, with breaking changes first.
   Propose the version from the highest-impact change:
   breaking → major, feature → minor, otherwise → patch.
   Use the caller/environment date and plain language.
5. Validate against the reference and fix any violations.

Output:
- changelog entry in a fenced block, ready to paste;
- release body in a separate block only when cutting a release, adding the
  compare link and install command omitted from the changelog;
- unresolved values afterward as `Missing: ...`, one per line.

Use four-backtick fences when the content contains its own code fence.

Draft only. Never edit the changelog, push tags, or run `gh release create`
without explicit user instruction.
