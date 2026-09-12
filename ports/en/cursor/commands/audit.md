Audit one finished text against the `concise` checklist and report what a
rewrite would have to fix. This reports; the rewrite is `/rewrite`.

Resolve the target from the argument below, in this order: a path to a file
that exists is read and audited; a PR or issue reference a tool can reach
(`gh`, an MCP board) has its body fetched and audited — the body, in place of
the diff; anything else is the text itself; empty targets your own previous
response in this conversation.

(Your arguments: whatever you typed after the command name, when there was any.)

You audit one text against the `concise` style checklist. The caller hands you
the text inline or as a file path — read the file if given a path. You report
what a rewrite would have to fix; the rewrite itself is a separate command.

First name the destination — chat reply, PR description, task/issue card, or
commit message — because it changes which checks apply. With the destination
unsaid and unclear from the text, audit as a chat reply and say you assumed
that.

Then check, in this order:

1. **The first sentence.** Does it answer, or does something stand in front of
   the answer — a header, a preamble, a restatement of the question?
2. **Always-cut items present:** preamble, postamble, process narration
   ("I read X, then ran Y"), prose restating quoted code, re-pasted tool
   output, justification that arrived on its own, a menu of options where the
   call was the writer's, rhetorical flourish, mid-text self-correction,
   hedges glued to confirmed facts, a line whose only content is announcing
   the next action ("now the schema", "next the docs"), a name out of the
   codebase the reader will leave untouched (a constant, a table, an internal
   function — where a sha, path, branch, version or number is one they will
   check), any byline other than the user's.
3. **Structure, both failures.** Inflation: a header over a single paragraph,
   one-clause bullets inside a single idea, an item running past two lines
   with detail stacked in parentheses, bold outside its two jobs — a block's
   one claim, an item's label — backticks on ordinary words, decorative emoji,
   a table column whose cells all hold the same value.
   And compression: one unbroken block covering several subjects, a comparison
   in prose that is rows-and-columns by nature, a block that mixes what the
   reader must decide with what merely informs them.
   And fences: a runnable command sharing its block with a second command or
   with pasted output, an untagged fence, or a tag other than the shell the
   reader pastes into — two steps chained with `&&` for a reader on Windows
   PowerShell is the case that actually breaks, since there `&&` is a parser
   error rather than a warning.
   And drawings: an unlabelled arrow, a line past seventy-two columns, two
   glyph sets in one picture, a label floating between two boxes instead of
   hanging off one, a box named after something the reader will leave
   unopened, a drawing that repeats the sentence above it, a legend
   explaining a glyph, a failure route sharing the main line with the happy
   path, and identical boxes repeated where a `×N` would carry it. A mermaid
   block is a violation wherever the destination shows the source in place of
   the picture, and wherever ASCII would have carried the same chain.
4. **Recommendations.** Each one carries a reason (≤3 lines) and a cost (≤3
   lines). An empty cost slot is a violation even when the text reads well.
5. **Choices that belong to the reader** — money, risk, irreversible: options
   side by side *and* still a recommendation, argued against the alternatives
   specifically.
6. **Always-keep holes.** Bad news, exact values (a number described in place
   of given), real uncertainty, what was left out of scope, actions that
   rewrote shared state. These are usually missing rather than quotable —
   report them as holes. Two of them are quotable, though: a path shortened
   to its basename on first mention, because the reader has to open the file;
   and bad news sitting after the part that is fine, where you quote the
   first line of the clean part and say the defects belong above it.
7. **Destination extras.** A PR description has three sections in this order —
   what is being solved, what was done, how to test it — with their headers.
   Opening on what the PR does is the violation, whatever the shape: the
   title already said that, and the problem is the one thing the reviewer has
   to be told. It ends with the exact test command, what appears if it's
   right, and what would prove it broke. Prose restating the diff, a
   file-by-file map, and a count of what changed are all padding here. A card
   has: what changes in the title, area first when the board holds more than
   one, current → expected behaviour, exact values, a done criterion, closed
   scope — and structure earned by the content: a header only past fifteen
   lines with three blocks doing different jobs, a table only at three rows
   by three columns of values, bold only as item labels. A commit message has
   a title of 72 characters or fewer, the last character a letter, that names
   what changes, and a body that says why rather than retelling the diff. For
   a card or a commit, also apply the stands-alone test: any "as discussed",
   "the problem you mentioned", or reference to this conversation is a
   violation, because the reader lacks it.
8. **Sentence shapes.** Announcing clauses ("it's worth noting that…") and
   hidden actors ("a validation is performed") — flag only clear cases.

Report format — your final text is the report, and the caller relays it:

- First line: the verdict. `N violations, M holes` or `clean`.
- Then a numbered list, one item per violation: the shortest quote that
  identifies the spot, the rule it breaks, the fix in one line.
- Then the holes, if any, each opening with **Missing:**.
- That is the whole report: the verdict, the list, the holes. If the text is
  clean, the verdict line is the whole report.
