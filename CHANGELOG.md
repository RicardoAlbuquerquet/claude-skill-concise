# Changelog

Every `version` bump in the two ports gets an entry here. The number is what
propagates a release: the self-update hook and `claude plugin update` both
compare versions, so a change without a bump reaches nobody — and a bump
without an entry tells nobody what it brought.

## 1.53.0 — 2026-08-25

Cards came out correct and unreadable: five paragraphs of prose with the done
criterion buried in the fourth and five code spans stacked in the first. The
rules said what a card must contain and what it must not wear, never how the
body is laid out.

- **The default layout is two paragraphs, then labelled lines.** Current
  behaviour, expected behaviour, two sentences each with a blank line between
  them — then **Where:**, **Done when:**, **Out of scope:**, **Repro:**,
  **Impact:**, **Reverts:**, each opening in bold on its own line, skipping
  the ones with nothing in them. Those labels are what a card is scanned for.
- **Two code spans in a prose paragraph, and no parenthesis inside a
  parenthesis.** The **Where:** line is exempt — holding the pointers is what
  it is for, and it is what keeps the opening paragraphs about behaviour
  instead of about files.
- **`Repro:` heads the numbered steps rather than swallowing them**, which is
  the collision the new label created and case 11 caught.
- **Eval case 34** is the real card that prompted this, with its five names,
  its reversal of an earlier decision and its out-of-scope values. It passes
  3 of 3.
- **Case 11 was already flaky at 1 of 3**, measured against the pre-change
  skill before crediting anything: packed repro, title opening on the product
  name. The layout rules took it to 2 of 3, and naming the board's areas in
  its facts took it to 3 of 3.

## 1.52.0 — 2026-08-24

The two surfaces that had no budget get one, and the shortest of them gets
the tightest. The commit body was the only surface in the ruleset without a
number at all — the three commits this repo wrote with the command carry 16,
19 and 23 lines of body, and every other commit in its log has none. A
comment had a number for card notes only.

- **Six lines is the ceiling, and no body at all is the common case.** A
  title that already says the why has nothing left to add, and most logs are
  almost entirely title-only.
- **What pushes a body over is named, because it is never a second reason**:
  the investigation retold, the list of what you ran, a file-by-file account,
  the release note written early. Each lands in the PR description, the test
  step or the changelog anyway, so in the commit it is the same text twice.
- In `SKILL.md` as a budget row of its own, in `commands/commit.md` as a
  count before delivering, and in the hook core — which is where a session
  reads it without invoking anything.
- **Eval case 32** hands the model an hour of investigation, two green
  commands and a written changelog line, and fails the message that keeps any
  of them. It passes 3 of 3, and cases 09 and 16 still do.
- **A comment is three lines at most, one is common, and it is the shortest
  thing here** — review comment, thread reply, note on a card, message to a
  person, all the same ceiling. It is written as a message to one person who
  is mid-task: no header, no table, no list, no second paragraph, no greeting
  and no sign-off. A point that needs structure needs a card or a paragraph
  in the PR, and the comment is the line pointing at it.
- **What a comment leaves out, it leaves out silently.** A note explaining
  why the praise or the detail didn't go in is longer than the thing it left
  out. That rule exists because eval case 33 caught the note twice in three
  runs; loosening the rubric instead would have graded away what the case is
  for.
- **Eval case 33** grades a blocking review comment with praise dangled in
  the facts on purpose. It passes 3 of 3, and case 25 still does.

## 1.51.0 — 2026-08-24

The rule from 1.50.0 only fires if the command runs, and nothing made it
obvious that it should. Two PRs in a row got a description written from
memory while `/concise:pr` sat there able to read the diff.

- **A second `PreToolUse` hook routes PR writing through the command.** The
  session's first `gh pr create` — or `gh pr edit --body` — is denied once,
  with a reason naming `/concise:pr` and how to open the PR with it. Repeat
  the call and it goes through: the failure is a description written from
  memory, not a PR being opened, and a hook that kept denying would be a wall
  the session could not leave. Same escapes as the credit guard:
  `CONCISE_NO_ROUTE_HINT=1`, or `touch ~/.claude/.concise-no-route-hint`.
- **What it cannot see is a PR opened in the browser**, and no plugin can. A
  repo whose PRs are opened on github.com puts the line in its own
  `PULL_REQUEST_TEMPLATE` instead — this one now does, in the comment at the
  top.
- **`/concise:pr` and `/concise:commit` were loading with no description and
  no argument hint at all**, in both ports, and had been since the hints were
  added. A backtick opening an item inside `argument-hint: [...]` is a
  reserved token in a YAML flow sequence, so the frontmatter failed to parse
  and every field was silently dropped — the command list showed the two
  commands bare. `claude plugin validate ./skills/concise` said so; nothing
  ran it. Every `argument-hint` in both ports is now a quoted string, which is
  what it was always meant to be, and a test fails the suite on the next
  unquoted one.
- **Ten offline tests**, including the one that matters: the second call in
  the same session passes. The hook suite goes from 46 to 56. `route-hint.sh`
  is byte-identical across the ports and `check-parity.sh` now enforces that
  for five scripts instead of four.

## 1.50.0 — 2026-08-24

The same report as 1.49.0, one surface further out: the PR descriptions this
command writes ran 57, 65 and 57 lines.

- **A PR description now has a size: one screenful, around twenty-five lines
  of prose**, with the fenced commands not counted — code and commands are
  exempt from every budget in this ruleset, and this one is no exception. It
  is a ceiling and not a target: a section folded into a sentence, a dropped
  caveat and two commands sharing one fence never pay for it.
- **What inflates them is stated where the rule is**: a deliverable said twice
  — once in the table and again in the prose under it — and a check you ran
  retold as a trip instead of reported as one line plus the output that proves
  it. The break-it sequence handed to the reviewer *to run* stays; it is a
  test step, not an account. In `SKILL.md` and in `commands/pr.md`, which
  gained the line count as the last thing it checks before delivering.
- **Eval case 31** grades a PR description against the ceiling, including that
  the cut never comes out of a caveat or a fence. It passes 3 of 3; it took
  four rewrites to get there, and three of them were the rubric. Both lessons
  are in `evals/README.md`: a case whose facts restate work that really landed
  here gets contradicted by the session's own git context, and an item that
  grades a shape has to say what makes it fail in something countable.
- **Case 10's rubric is fixed**, and it was flaky at 2 of 3 before any of this
  — measured against the pre-change skill to be sure the new ceiling was not
  the cause. It read "ends with a test step containing the exact command"
  literally, so the unverified part the ruleset requires after the command
  failed the case that asked for it. It passes 3 of 3 now.
- `commands/pr.md` goes from 87 to 98 lines, against the ~100 that
  `CONTRIBUTING.md` asks a command to justify. The four lines it added buy the
  ceiling, the said-once rule and the counted-lines check at the end.

## 1.49.0 — 2026-08-24

Both halves of one report: replies still ran long, and they were dense with
terms the reader had no use for.

- **A turn gets one budget, not one per thing it could say.** Every row of the
  budget table is per situation, so a reply that finished some work, mentions
  what it noticed on the way and adds background obeys all three rows and
  arrives three times too long. Each block after the first now has to be paid
  for by what it leaves the reader doing — deciding, running, no longer
  trusting something — and a block that leaves nothing gets one line or goes.
  In `SKILL.md` and in the hook core, which is where most sessions read it.
- **A technical term now faces "will the reader meet it?" before it faces the
  gloss.** The rule was "keep the precise term and gloss it by consequence",
  which reads as a licence to keep every term and explain each one — four
  glosses in a reply is both harder to read and longer. The term stays when
  they will type it, click it, read it on their own screen or approve changing
  it; otherwise the sentence says what the thing does and never names it.
- **One gloss per response is the ceiling.** A second term wanting its own
  explanation is the signal that the reply is carrying the shape of the
  investigation instead of the shape of the answer. The final pass in
  **Before sending** now counts them.
- **Dropping a term is not going vague**, and the skill says so where the rule
  lives: "the column stores the time in UTC" is exact without `timestamptz`;
  "there's a timezone thing" threw the information away and kept the length.
- **Two eval cases**, both aimed at what was reported: 29 grades a response
  that may explain at most one term out of four, and 30 grades a completed-work
  turn carrying one real finding and three inert observations. The suite goes
  from 28 to 30 cases. The rule → case map also gained the four rows it was
  missing for 25–28.

## 1.48.0 — 2026-08-22

- **The eval suite runs eight cases at a time instead of one.** It was 2N
  blocking API calls in a queue — 56 of them for 28 cases — which is the whole
  reason it took long enough to avoid. The cases share nothing, so the only
  thing the queue bought was the order of the report, and that is now restored
  at collection time: a parallel run reads exactly like a serial one.
  `JOBS=1` puts it back in a queue for a rate limit or a log you want to watch.
- **The judge runs on a fast model by default** (`JUDGE_MODEL`, Haiku 4.5). It
  matches a response against a rubric — it does not write — and it is half of
  every case. `JUDGE_MODEL=` empty puts it back on whatever `MODEL` is.
- **A dead CLI now reports one reason and a count**, not the same line
  repeated once per case in flight — which is what parallelism turns a single
  auth failure into.
- **Two offline tests guard the refactor**: the report comes out in filename
  order, and a mute CLI exits 3 instead of scoring silence. Both verified
  against the break they exist for. The hook suite goes from 44 to 46.

## 1.47.0 — 2026-08-22

- **A command pointing at a section that no longer exists now fails the
  suite.** Every `"<name>" section` reference in a command or agent has to
  match a `## <name>` heading in its port's `SKILL.md`. This is the class of
  error that appeared three times between 1.32.0 and 1.41.0 — a rule gets
  renamed or revoked and the files pointing at it go stale in silence.
  Verified against a real rename: turning `## Show the shape` into
  `## Draw the shape` turns the suite red naming `draw.md`. It runs offline,
  so it gates every PR.
- **Eval case 28 covers the one-hanging-note rule from 1.46.0**, which had no
  coverage: a four-hop flow with exactly one thing wrong, so a drawing that
  annotates all four fails. Case 27 could not carry it — that one has two
  costs by construction. The suite goes from 27 to 28 cases, and the hook
  suite from 42 to 44.

## 1.46.0 — 2026-08-22

- **One hanging note per drawing, and it sits on the finding.** Until now the
  rules asked for a label on every arrow and a cost on every hop, which can
  end in a drawing where everything is annotated — and where everything is
  annotated, nothing stands out. This is the first drawing rule that removes
  output rather than asking for more. Two boxes deserving the mark means two
  findings, and probably two drawings.
- **`?` is the one form for an unverified hop** — `webhook retried ×3 ?`. The
  rule already demanded the mark and never said what it looked like, so each
  drawing invented `(?)`, `[unverified]` or `~`, and the mark became the thing
  the reader had to decode.
- **The boxes use the words the surrounding prose uses.** A box reading
  `exporter` under a paragraph about "the export job" hands the reader two
  pictures to hold at once.
- **`CONTRIBUTING.md` now caps command length**, and closes `draw.md` to
  further content at 218 lines against 87 for the next largest: a new drawing
  rule has to replace one rather than join it. A command file is loaded whole
  on every invocation, so its length is a cost paid before any output exists.

## 1.45.0 — 2026-08-22

- **Bug fix: the welcome note still said "Eleven commands" and left `:handoff`
  out of the map.** It is the one thing the plugin says on screen, it shows
  once, and it went stale in 1.43.0 when the twelfth command shipped — so
  anyone installing since then got an incomplete list at the only moment they
  were reading one. Fixed in both ports.
- **A test now makes that regression impossible to ship quietly**: every file
  in `commands/` has to appear in its port's welcome text, so a new command
  fails the suite instead of dropping off the map. Verified against the bug it
  was written for — reverting the fix turns it red. The suite goes from 40 to
  42.

## 1.44.0 — 2026-08-22

- **Seven finishing rules for a drawing**, all about how it looks rather than
  what it says: labels in one register (lowercase, unpunctuated, phrased
  alike), one unit style per drawing, arrow length as a spacer and never a
  signal, a cost column that starts at one column and stays there, shortening
  from the head so the identifying tail survives (`…/auth/refresh.rs:88`), and
  a blank line only between stacked blocks — a gap inside one shape reads as
  two.
- **A drawing's fence is now tagged `text`.** Bare broke the ruleset's own
  tag-every-fence rule; a shell tag makes some renderers colour the
  box-drawing characters as syntax and turn the shape into confetti. Every
  example inside the skill and the command is retagged to match.
- Eval case 27 grades the two new checkable ones — the `text` tag and one
  register for labels.

## 1.43.0 — 2026-08-22

- **New command: `/concise:handoff` (PT `/respostas-curtas:passagem`)** — the
  twelfth. It writes the handoff: the branch, the sha, the PR and its state;
  what is done and verified kept apart from what is left with its done
  criterion; the traps only the person leaving can name; what was decided and
  why; and the exact command that resumes the work.
- **It exists because it is the opposite of a status update**, and the two
  were sharing one command's worth of rules. A status update is the delta and
  earns the right to drop what the reader already has. A handoff assumes the
  reader has nothing — no memory of the conversation, no caveat stated three
  messages ago — so **every standing caveat comes back in full** instead of
  being referred to by a clause. The ruleset already said that under "never
  cut"; nothing produced it.
- **The always-on core routes it**, alongside the six commands it already
  named.

## 1.42.0 — 2026-08-22

- **A commit title now carries the area too, completing the family.** A card
  got the rule in 1.32.0 and a PR title in 1.33.0; the commit title — read in
  `git log --oneline`, the narrowest window in the ruleset — kept saying only
  "what changes, in the shape the log uses". Where the repo holds more than
  one area it now comes first, inside whatever shape the log already gives it
  (`fix(invoices):`, a bare `invoices:`, a ticket code). One area, or a log
  with no prefix: nothing is invented.
- **`/concise:pr create` opens the PR, and `/concise:commit run` commits.**
  Both stay draft-only by default; the literal word in the invocation is the
  permission, and nothing else is — not a base ref, not staged changes, not a
  PR you opened earlier in the same conversation. Anything that would make
  the call wrong (no commits over the base, an unfilled hole, `gh` not
  authenticated, an unpushed branch, two unrelated changes staged) stops
  before it and says which, with the draft delivered anyway.
- **The always-on core routes `:draw` and `:status` too.** It named five of
  the eleven commands, so the two that come up most often outside a release
  — showing a shape and reporting where work stands — were never pointed at.

## 1.41.0 — 2026-08-21

- **Bug fix: the ruleset contradicted itself on PR descriptions.** The PR
  section still opened with "the first line says what the PR does" and called
  every template header decoration — three paragraphs before the 1.35.0 rule
  mandating three headed sections that open on what is being solved. The
  opener now says the same thing the rule does, in both ports.
- **Bug fix: three eval cases enforced revoked rules.** Cases 10 and 17
  demanded the pre-1.35.0 PR shape (first line = what the PR does, no header
  above it) and case 11 demanded verb-first card titles — the exact rule
  1.32.0 replaced with "what changes, located". A response following today's
  ruleset failed the suite. All three rubrics now grade the current rules.
- **Three eval cases the rules never had**: a note on a card at three lines
  with the anchor (1.34.0), a PR title with the area first and the state
  after the merge (1.33.0), and a drawing that holds its shape — one glyph
  set, nothing past 72 columns, labels hanging off their box (1.36.0+). The
  suite goes from 24 to 27 cases.
- **Bug fix: the 1.40.0 update-check bypass only worked at the repo root.**
  The detection read `.claude-plugin/marketplace.json` relative to the
  current directory, so a session opened in a subdirectory silently kept the
  daily stamp. The repo root is now resolved through git; a new hook test
  covers the subdirectory, taking the suite to 40.
- **Stale references caught up**: `/concise:rewrite` pointed at the
  "narrow-panel structure limits" — renamed "two widths" with different
  thresholds in 1.32.0 — and both READMEs described `/concise:draw` without
  any of the craft rules from 1.36.0–1.39.0.

## 1.40.0 — 2026-08-21

- **The self-update hook no longer holds the marketplace cache stale for the
  author.** Inside this repo the once-a-day stamp is ignored and the check runs
  every session. Everywhere else it is unchanged: one check a day.
- **What this actually fixes is the update button.** The client compares the
  installed version against the local marketplace clone, not against GitHub, so
  a clone pinned at yesterday's commit greys the button out no matter how many
  releases shipped since. The clone only advances when the marketplace refresh
  runs — which the daily stamp was blocking.
- Two new hook tests cover it: the stamp is ignored inside the marketplace's
  own repo, and still respected in any other directory. The suite is at 39.

## 1.39.0 — 2026-08-21

- **A closed box now has to earn its three lines.** Bare labels on the line are
  the default: `worker ──> cache` is already a drawing, and the same two things
  inside `┌──────┐` frames cost six lines for identical content — the
  fifteen-line budget is only five boxes deep. A closed box is for a node
  holding two lines, or for the block being compared in a before/after, and
  there is one box style per drawing the way there is one glyph set.
- **The happy path stays on the main line and failure drops below it**, with
  the failure arrow carrying what the reader loses — `timeout: order charged,
  not confirmed` — instead of `error`. An inline error route makes the reader
  work out which of the two is normal before the drawing says anything.
- **Repetition is a count, not boxes.** Eight identical consumers are one box
  and `×8`; drawing all eight spends the budget proving they are the same.
- **No legend, no key.** A drawing needing a line to explain a glyph has
  already failed — the meaning folds into the labels or the distinction goes.
  A `×8` or a unit is a label, not a legend.
- **The audit agent checks all four**, alongside the drawing rules it gained in
  1.37.0 and the mermaid conditions from 1.38.0.

## 1.38.0 — 2026-08-21

- **`mermaid` had one clause and no rules; now it has both conditions and seven
  rules.** GitHub renders it, so `/concise:pr` and `/concise:card` reach it
  routinely, and until now nothing said what a good mermaid block looks like.
- **Two conditions, both required, before it is mermaid at all**: the surface
  renders it, *and* the graph is genuinely two-dimensional — a node with two
  arrows in, a cycle, a mesh. A chain stays ASCII, because ASCII survives the
  copy into a terminal, a commit body, or a field that renders nothing.
- **The rules**: `flowchart LR` for a flow and `TD` for a branch, the visible
  label never the node id, every edge labelled, a node shape that means
  something or stays default, no `style`/`classDef`/colour, ten nodes as the
  cap, and a labelling subset that always parses — a block that fails to parse
  renders as an error box, which is worse than no drawing.
- **The audit agent flags a mermaid block on a surface that will not render
  it**, and one used where ASCII would have carried the same chain.

## 1.37.0 — 2026-08-21

- **`/concise:draw` now carries four canonical layouts** — a flow, a branch, a
  before/after, and a call tree — each with a worked skeleton. The command used
  to name four kinds of subject worth drawing and give no shape for any of
  them, so every drawing invented its own layout and two drawings by the same
  author looked unrelated. They are starting points, not moulds: when the real
  shape is none of the four, the real shape wins.
- **A drawing procedure, in order**, because alignment is not fixable
  afterwards: the main line whole first, then the column of each box counted,
  then the labels hung top down with the leftmost closing first, then the
  longest line measured against the seventy-two column limit. The 1.36.0 rules
  said what alignment had to look like and nothing about how to get it.
- **Bug fix: `/concise:audit` contradicted `/concise:pr`.** Item 7 of the audit
  agent still asked a PR description to open with what the PR does — the shape
  1.35.0 replaced with three named sections opening on what is being solved. An
  audited description could fail the rule it had just passed. Fixed in both
  ports.
- **The audit agent now checks drawings at all**: unlabelled arrows, lines past
  seventy-two columns, mixed glyph sets, floating labels, boxes named after
  internals, and a drawing that repeats the sentence above it.

## 1.36.0 — 2026-08-21

- **A drawing now has a column limit, and it is the strict one: seventy-two.**
  The old rule capped lines at fifteen and said nothing about width, so the
  failure it never caught was the one that destroys a drawing outright — a line
  that wraps in the reader's panel, which is not the panel it was drafted in. A
  before/after that will not fit side by side inside that stacks instead of
  shrinking its labels.
- **One glyph set and one direction per drawing.** Box-drawing or plain ASCII,
  the same arrowhead throughout, left to right for a flow and top to bottom for
  a branch, with parallel paths starting at the same column — a ragged left edge
  reads as a difference that is not there.
- **Every label hangs off what it names**, by a `│` down to a `└─`, instead of
  floating between two boxes. The example in the ruleset itself broke this: its
  `2.1 s p95` sat loose between two hops with nothing saying which one it timed.
  It is redrawn.

## 1.35.0 — 2026-08-21

- **A PR description now has three sections, in a fixed order: what is being
  solved, what was done, how to test it.** The order is the change. The old
  rule opened on what the PR does, which the title already said, and left the
  problem as an optional second sentence — so the one thing the reviewer cannot
  reconstruct from the page was the one thing that could be dropped.
- **Markdown is explicitly welcome in a description**: tables, headers on the
  three sections, lists for the deliverables, code spans on paths and values.
  Three sections are three blocks doing different jobs, so they earn their
  headers under the structure rule rather than fighting it. A description that
  reads well is not padding.
- **What counts as padding is named instead of capped**: the description
  competing with the diff — a file-by-file map, a count of what changed, a
  section per area touched. A discarded alternative gets a line, not a section,
  and the argument that discarded it goes to the commit body or the linked
  card.
- `/concise:pr` audits the three sections and their order before delivering.

## 1.34.0 — 2026-08-21


- **A note on a card now has a length, and it is three lines.** The section
  covering comments had rules about shape — claim first, one point, no filler
  praise — and none about length, so a note on an activity came out at the
  length of a chat reply. It is now the summary of the summary: what changed
  since the card was written, or what the reader has to do, with the anchor.
  One line is common.
- **A note that needs a second paragraph is an edit to the card**, not a
  comment on it. A thread is a chronological feed nobody scrolls back through,
  so reasoning parked there is parked where it gets lost; the card body holds
  the standing description and a linked document holds the reasoning.
- **The budget table gained a row for it**, next to the one for a task or an
  issue. `/concise:comment` audits against the three lines before delivering.
  A review comment anchored to a diff line keeps its own shape — this is the
  note on an activity, not the line-level review.

## 1.33.0 — 2026-08-21


- **A PR title now takes the card's title rule, minus the symptom form.** It
  says what changes on merge, in the shape the repo's log already uses, with
  the area first inside that shape when the list holds more than one — the PR
  list cuts the line the same way a board column does. The symptom form does
  not travel: a card names the broken state so someone picks it up, a PR names
  the state after it merges. And a prefix repeating what the list already shows
  beside the title — the repo, a `bug` label, the branch — is spent characters,
  the same as on a card.
- **"Verb first" is gone from the PR title rule**, where it contradicted the
  commit-title rule it claimed to follow: that one has accepted a declarative
  naming the change since 1.0, and only rejects a label with no change in it.
  A repo whose log is declarative no longer gets told to write imperatives.

## 1.32.0 — 2026-08-21


- **A card title now leads with the area, not with a verb.** The old rule
  asked for the action verb and nothing else, which pushed the area to the end
  of the line — and the column cuts the line. "Documents: bold shows up as raw
  asterisks" now passes where it used to fail for having no verb; the verb is
  still right when the symptom alone wouldn't be recognised. A prefix that
  repeats a label the card already carries (`fix(...)` beside a `bugfix` tag)
  is now called out as spent characters.
- **A card body may now carry a table or a header, at a written threshold**:
  a table at three rows by three columns of values, a header past fifteen
  lines with three blocks doing different jobs. The flat ban assumed the body
  was read in the ~300px column; it is read in the detail view a click opens,
  and the column shows only the title. Cards that were split into a linked
  document purely to escape the ban no longer need to be, and `/concise:audit`
  stops reporting those tables as violations.

## 1.31.0 — 2026-08-20


- **The injected core now points at the commands.** Eleven commands shipped
  and nothing told the model to reach for one, so it wrote from what it
  remembered instead of from the diff. The session that cut 1.30.0 is the
  quotable case: the commit message and the PR body for it were written
  without invoking `/concise:commit` or `/concise:pr`, and they only landed in
  the right register because the whole ruleset happened to be open in that
  conversation. In a session that isn't editing this repo, that coincidence
  does not exist.
- **Only the five that leave the conversation are named** — `pr`, `commit`,
  `card`, `comment`, `release`. They are the ones where the command adds a
  fact-gathering step the rules cannot describe: reading the log for the
  title's convention, the diff for what the PR does, the thread before
  replying to it. `plan`, `decide`, `draw`, `status` and `audit` stay out
  because the core is the most contested space in the plugin and their gain is
  register, not grounding.
- **It is a nudge, not a system rule**, and the difference matters: a hook
  denies, a line in the core competes. The deterministic version — extending
  the `PreToolUse` guard to reject a `gh pr create` whose body carries no test
  step, the way it already rejects AI credit — is not in this release, and
  would need the same escape hatches the credit guard ships with.
- The line lands in `hooks/core.md`, `hooks/nucleo.md` and both output styles,
  which `check-parity.sh` holds byte-identical to their cores. Core bullets go
  from ten to eleven in both ports.

## 1.30.0 — 2026-08-20

- **Six commands, closing the gap between what the ruleset governs and what
  you can ask for.** `/concise:release` drafts the changelog entry and the
  release body; `/concise:plan` the plan you are proposing; `/concise:decide`
  a call that is yours, options side by side; `/concise:draw` the ASCII of a
  shape; `/concise:status` the delta-only update; `/concise:audit` runs the
  audit agent from a slash instead of a sentence. PT: `release`, `plano`,
  `decidir`, `desenhar`, `status`, `auditar`.
- **Changelog and release notes get a section of their own.** The rule was one
  sentence at the end of "Commit messages", which is why no command could
  point at it. It now says that what breaks goes first with the migration in
  the same entry, that an internal refactor earns no entry at all, and that
  the file's own shape is the convention the way the log is for a commit
  title.
- **The three that could have been prompts instead read the source first.**
  `/concise:draw` opens the files for every hop and marks the ones it could
  not follow — and refuses outright when the subject doesn't earn a drawing,
  which is the failure a diagram command otherwise ships by default.
  `/concise:status` finds the previous update and the CI run instead of
  recalling them. `/concise:decide` marks a cost it could not verify rather
  than rounding it off.
- **Nothing publishes and nothing executes.** `release` never runs
  `gh release create` and never pushes a tag, `plan` never starts step 1,
  `status` never posts to a channel you named, `audit` never edits the file it
  read. Naming a destination still says where the text would go, not that it
  may go there.
- **The welcome note listed four commands, and there are eleven.**
  `/concise:comment` shipped in 1.29.0 and never reached that string — a
  command nobody is told about is a command nobody runs. It now groups by
  destination instead of spending a clause per command.
- No rule for chat replies changed, so no eval case moved. The commands are
  graded by the sections they follow; the harness measures chat replies, and a
  slash command is not one.

## 1.29.0 — 2026-08-20

- **`/concise:comment` (PT: `/respostas-curtas:comentario`)** drafts the fifth
  destination the ruleset already governs and no command produced: a review
  comment, a reply in a thread, a note on someone's card, or a message to a
  person. The "Comments and replies" section has existed for as long as the
  ruleset has had destinations; until now it only applied when Claude happened
  to be writing one, never when you asked for one.
- The command carries three things the section states and a draft usually
  misses: it **reads the line or the thread before writing** — a comment
  anchored to a `path:line` nobody opened is a guess wearing an anchor — it
  **says whether the comment blocks**, because the reader's first question is
  whether they have to act before merging, and it splits two points into two
  blocks instead of one comment with a list inside.
- **It does not post by default, and a named destination is not permission
  to.** Naming a PR or a card tells the command where the comment would go;
  posting notifies a person, so it waits for you to say so. `/concise:card`
  creates when a destination is named — opening an issue and replying inside
  someone's thread are not the same act.
- No rule changed, so no eval case moved. The command is graded by the section
  it follows; the harness measures chat replies, and a slash command is not
  one.

## 1.28.0 — 2026-08-20

- **The block holding the reader's decision holds the recommendation too.** A
  long delivery ended with two genuinely different ways to verify the work and
  closed on "tell me which one" — the right shape with the advice taken out of
  it, leaving the reader holding a choice whose costs only the writer had
  measured. The rule that gives a decision its own block now says the block
  carries the recommendation with it.
- Case 06 already tested "does not stop at your call", and it holds. What it
  could not see is the same failure at the end of a five-section report, where
  the choice arrives after the writing feels finished. Case 24 is that shape.
- **Case 24 discriminates weakly** — 3 of 3 with the skill in both ports
  against 2 of 3 at baseline — and the map says so. Two cases in a row now sit
  there, and the reason is the same: the failures worth catching happen across
  a long session with tools, and the harness runs one turn without any.
- Writing case 24 turned up a fault in the case rather than in a rule: the
  facts said the second route left "nothing to clean up" while also saying the
  fixture rows were already written. The model followed the contradiction and
  the rubric blamed it.

## 1.27.0 — 2026-08-20

- **The style covers every line the turn puts on the screen, not only the last
  message.** A real delivery opened with nine lines of itinerary — "now the
  schema", "now the docs", "now regenerating the SDK" — sitting above the
  answer. The cut list already banned process narration, but the whole
  document talked about "the response" and "what leaves the conversation",
  so the lines between tool calls read as exempt. They are the ones a reader
  sees first and looks at longest.
- **A table column holding the same value in every row is not a column.** The
  same delivery reported eight met requirements in a grid whose second column
  was eight identical ticks — a sentence's worth of information charging a
  table to read it. Drop the column, or drop the table with it.
- **Bad news goes ahead of the part that is fine.** Eight confirmations
  followed by two defects makes the reader walk past everything that needs
  nothing from them to reach the two things that do. Case 23 only held once
  this was in the completed-work budget as well as in **Never cut** — the
  placement lesson again.
- The path rule from 1.26.0 was holding about half the time in real use, so it
  now also sits on the code-span entry, which is where the decision to
  abbreviate actually happens: the full path costs nothing inside a span.
- Cases 22 and 23 measure it. Case 23 discriminates cleanly — 3 of 3 with the
  skill in both ports against a failure at baseline. **Case 22 barely does:**
  2 of 3 at baseline against 3 of 3 with the skill, and the map says "weakly"
  rather than pretending otherwise. The suite grades the final message, so it
  can only reach the itinerary habit indirectly.

## 1.26.0 — 2026-08-20

- **A path is the whole path the first time it appears.** The name rule from
  1.22.0 was still leaking into paths at about one run in three, shortening
  `web/src/modules/estoque/movimento/movimento-pdf.ts` to the bare filename.
  Saying "a file path is a value" in the cut list was not enough; the rule now
  sits in the exact-values entry, where what counts as the value is decided,
  and says the basename is a different and weaker one. Later mentions may
  still be short.
- **Three green eval checks on every PR were measuring nothing.** Without
  `ANTHROPIC_API_KEY` the job ran its skip branch and reported `pass`, which
  reads as "the rules were checked" on a run that never called the model — a
  green check that proves nothing is worse than no check. A gate job now turns
  the secret into an output, so the eval jobs report `skipped` instead, and
  say why in the run summary.
- The audit agent had not kept up with two rules it can check: a fence tagged
  for the wrong shell or chaining two commands, and a path shortened to its
  basename on first mention.
- **The opt-in `stop-audit` extra was grading responses against a copy of the
  rules, not the rules.** Four lines written by hand inside the script, frozen
  wherever they were when it shipped — an auditor holding last month's
  checklist is worse than none. It reads `hooks/core.md` now, with
  `CONCISE_CORE` for installs where the plugin root is not in the hook's
  environment and the user's own override winning over both. Four tests cover
  the wiring, which had none: the core reaching the prompt, a violation
  becoming a warning, `OK` staying silent, and a missing core falling back
  instead of dying.
- **A name that is the decision stays, and the first full PT run since 1.21.0
  is what found that.** The Portuguese port dropped the route it had called —
  reporting "it calls a different route depending on the type", which leaves
  the reader unable to say which decision was taken, let alone whether it was
  right. The rule already spared the knob you ask someone to turn; it now
  spares the name that *is* the decision you are reporting.
- **Writing a case's own vocabulary into a rule contaminates the case.** The
  first draft of that clause used the route names from case 19. Portuguese
  went to 3 of 3 and English fell to 1 of 3 — the model optimised for that one
  rubric item and compressed the false premise and the gate warnings out of
  the answer. Replaced with a neutral example, both ports hold. Case 19 in
  Portuguese is still the closest to the edge in the suite: one failure in
  nine attempts.
- **The eval harness had grown a ceiling it was about to hit everywhere.** It
  handed the whole skill to the CLI on the command line, which Windows caps at
  32767 characters; the PT skill reached 31 KB and the full PT run died at
  case 17 with "Argument list too long" — the first run of that suite since
  1.21.0. It uses `--append-system-prompt-file` now, so the limit is gone
  rather than postponed, with a warning and the old path for a CLI too old to
  have the flag.
- `CONTRIBUTING.md` told contributors to run the evals and compare, without
  saying that one run per case is not evidence. It now says to use `RUNS=3`,
  and why: the suite read 21/21 for weeks while two cases were failing about
  one run in three.
- `evals/README.md` claimed 18/18 against a suite of 21, and said the
  discriminating power was "those seven" two lines under a sentence counting
  ten.
- **The first full `RUNS=3` sweep is what surfaced both**, and it is the
  headline of this release: all 21 cases now hold three times each, in place
  of a 21/21 line that meant each case drew well once. Cases 10 and 14 looked
  unstable in that sweep and were not — 14 had hit the session limit, and 10
  passed 3 of 3 on re-measurement.

## 1.25.0 — 2026-08-20

- **The commit command still promised a verb-first title**, in its own
  description and in four places across the two READMEs — the rule 1.18.1
  replaced with "the log decides the shape, never the substance". The command
  body had been right since then; the shop window had not, and this repo's own
  log is declarative, so the promise contradicted the product.
- **The marketplace card had fallen behind the plugin's own description** and
  nothing was checking it: the sentence naming what the style governs — chat
  replies, plans, commits, PRs, cards, review comments — reached anyone
  reading `plugin.json` and nobody browsing the marketplace. Fixed, and
  `check-parity.sh` now compares the two, so it cannot drift again quietly.
- The READMEs said the injected core is ~20 lines. It is 36.
- **The fence rule shipped in 1.24.0 had no answer for "platform unknown", and
  case 07 caught it** — the suite scored a `powershell` fence as a violation
  because its rubric hard-coded `bash` while its facts named no platform, so
  the case was really grading the machine the suite happened to run on. Two
  fixes: the rule now defaults to `bash` when neither the hook nor the
  environment says otherwise, because guessing `powershell` at a reader who
  turns out to be on Linux costs more than the reverse; and cases 07 and 17
  state the platform in their facts, the way case 21 already did.
- Running the suite with `RUNS=3` for the first time is what surfaced that.
  Cases 01 through 14 hold three times each; 15 through 21 have not been swept
  yet, and `evals/README.md` says so rather than implying the whole suite has
  been.

## 1.24.0 — 2026-08-20

- **The session hook now says which machine this is, and the fence tag follows
  it.** A command block tagged for the wrong shell does not run: `&&` is a
  parser error in Windows PowerShell 5.1 rather than a warning, and `bash`
  typed there reaches the WSL stub instead of Git Bash. `inject-core.sh`
  detects the platform through `uname` and appends one line naming it —
  `powershell` fences on Windows, `bash` on macOS and Linux, with a note on
  macOS that BSD `sed`, `date` and `readlink` take different flags from GNU.
- The rule sits in the fence bullet too, for the output-style path that has no
  hook: the tag names the shell the reader will paste into, not the one you
  ran the command in, and two steps are two fences rather than a chain.
- `CONCISE_OS=windows|macos|linux` overrides detection, for a Windows machine
  whose terminal is Git Bash or WSL. Seven new hook tests cover the branches,
  including a `hooks.json` with no platform strings, which prints nothing and
  still exits 0.
- Case 21 measures it: 3 of 3 with the skill in both ports, 1 of 3 without.
- The rule→case map said eight discriminating cases where the column had nine.

## 1.23.0 — 2026-08-20

- **A completed-work report stops buying its ≤5 lines by packing.** The budget
  row now says the item count follows the work rather than the number, and
  names the shortcut it was licensing: folding the tail of the list — the
  dependency, the docs, the smaller file — back into a sentence to land on
  five.
- That was the real cause of case 18 being unstable at about 2 of 3 since the
  day it was written, which 1.22.0 recorded as unfixed. The rule it tests was
  never the problem: a dozen claims against a ≤5-line budget left no layout
  that satisfied both, so each run broke somewhere different — four claims in
  one item, then three parentheticals stacked, then prose. Rewording the list
  rule three times only moved the failure. The case now holds 3 of 3 in both
  ports and still fails at baseline.
- **Grouping by file is what forces the packing**, so the list rule says the
  grouping is what gives: one subject with four claims hanging off it is four
  items, or a table with the subject in the first column.
- A drawing is no exemption from the name rule shipped in 1.22.0. A box
  labelled with a table's name teaches nothing; the same box labelled "daily
  copy" is the diagram doing its job.
- Case 18's rubric demanded a list where the skill offers a list *or* a table
  for that content. It accepts either now, and only prose fails — the same
  miscalibration case 10 had.
- **The overloaded-opening test described a failure it could not detect.** It
  asked whether the reader crosses a comma chain before reaching the answer;
  the failure that actually happens is "Yes" followed by three reasons in one
  breath, where the answer comes first and the chain comes after. The test is
  now mechanical: put a full stop after the verdict, and if the sentence was
  still going it was overloaded. The headline rule says it too — the answer
  goes in the first sentence, and nothing else goes in there with it.
- Case 08 was grading punctuation. An em dash after "yes" with the support
  trailing reads the same as a full stop; what the rule protects is the caveat
  getting a sentence of its own. Recalibrated to that, it passes 3 of 3 — and
  3 of 3 at baseline as well, which confirms in measurement what the rule→case
  map already claimed: case 08 documents what Claude Code does by default
  rather than what the plugin adds.

## 1.22.0 — 2026-08-19

- **A name lifted out of the code stays only if you can say what the reader
  does with it.** An investigation came back carrying the job class, the
  table, the repository method and the constant, one per sentence — and the
  person who asked why a total was wrong will open none of them. Replaced by
  the behaviour they stood for, those sentences got shorter and clearer at the
  same time, which is why this cut is worth a pass of its own.
- It lands in three places because it collides with two existing rules.
  **Never cut** now says the exact value is the value, not the name of the
  constant holding it; **Always cut** carries the item; and the final
  checklist has a third step for it. Written once, in the audience section,
  the rule lost every run — the same placement lesson as 1.20.0 and 1.21.0.
- The setting you are asking the reader to approve changing is the exception:
  name it, because approving the change means approving that specific thing.
  Shas, paths, branches, versions and numbers they will check are untouched.
- Case 20 measures it: 3 of 3 with the skill, 0 of 3 without — the cleanest
  discriminator in the suite. Case 19's rubric used to demand the error
  constant in the response; it no longer does.
- Two boundaries were added because the first draft over-cut in measurement: a
  file path stays whole, directory and all, and a library version stays even
  while the name beside it goes. Both were caught by case 18 dropping them.
- **Case 18 is flaky at about 2 of 3, and was before this release** — on its
  own rule, the packed list item. Checked against the 1.21.0 skill to be sure
  this change was not the cause. The rule behind it is not fixed here; the
  finding is recorded in `evals/README.md`.

## 1.21.0 — 2026-08-19

- **What waits on the reader never shares a block with what merely informs
  them.** A delivery report put one open question — an API change only the
  reader can authorise — in the same list as two decisions already made and
  committed, under a heading that joined the jobs with "or": "three things
  to decide or know". The reader had to hunt for the part needing an
  answer. Splitting it is the rule; a heading with "or" in it is the tell.
- The completed-work budget now says it too, which is where the shape of
  the answer is decided — the same placement lesson as 1.20.0.
- Case 19 measures it: 3 of 3 with the skill, 1 of 3 without.

## 1.20.0 — 2026-08-19

- **A list item is an item, not a paragraph with a dash.** One item carries
  one claim, in one line or two; four helpers with a gloss each are four
  items, not one line holding four parentheses. The failure hid in plain
  sight because it looks like a list — the rule the semicolon ban already
  covered in prose, escaping through the format that promised a scan.
- **First baseline run, in an isolated config: 11 of the 18 cases pass with
  no style at all.** Seven measure what the plugin adds; the rest describe
  what Claude Code already does. The suite says 18/18 with the skill, and
  that number was hiding how much of it the skill is responsible for — the
  rule → case map now carries the answer per case.
- Where the rule sits turned out to matter more than how it was worded.
  Stated only as a prohibition, it held in 1 of 3 runs; moved to where a
  list is decided — the definition of what a list is for — it held in 3 of
  3. Case 18 is what measured both.

## 1.19.0 — 2026-08-19

- **A PR description opens with two sentences: what it does, and what was
  wrong without it.** The ruleset asked for the change and never for the
  symptom, so a reviewer got "fixes the fence handling" where they needed
  "the export truncated its own output whenever the description contained a
  code block". Knowing the symptom is what lets someone judge whether the
  fix is the right one. The second sentence goes when the first already
  carries the problem.
- `/concise:pr` takes the problem from the commits, the linked card or the
  branch name — never invented — and the audit agent checks the opening.
- Cases 10 and 17 check it, so the rule regresses instead of drifting.

## 1.18.1 — 2026-08-19

- **The log decides the shape of a title, never its substance.** Adding the
  convention rule created a contradiction with "verb first", and the first
  real eval run found it: this repo's own titles are declarative ("A
  correção entra no núcleo"), so the two rules could not both hold. What a
  title must do — name what changes, inside 72 characters, no AI credit —
  stands; imperative or declarative is the log's call. A bare label
  ("Invoice filter") still fails.
- First real run of the suite, judge and all. It found two things, both
  ours: a miscalibrated rubric (case 10 demanded a deliverables list from a
  single-change PR — the list check moved to case 17) and the title
  contradiction above.

## 1.18.0 — 2026-08-19

Commit messages learn the repo they land in, and two PR fixes from a
real screenshot.

- **The repo's log is the commit convention.** A `fix(scope):` prefix, a
  ticket code, another language — whatever the recent titles do
  consistently, the new message does too, and a commitlint config makes
  the prefix mandatory. `/concise:commit` reads `git log --oneline -15`
  and the commitlint config before writing, and carries the ticket from
  the branch name the way the log does — never invented.
- `/concise:commit` also gives the exact `git restore --staged <paths>`
  when the staged diff is two unrelated changes, and wraps the body near
  72 columns.
- **PR deliverables must be a real markdown list** — `- ` at the start of
  the line. A real PR came out with the changes chained by dashes inside
  one paragraph: the same wall of text the semicolon rule banned, with
  different punctuation.
- **A feature with no screen is not excused from the test step.** The same
  PR said the route was "reachable by direct call" without giving the
  call; the step is the call itself, route and body included.
- Case 16 (commit convention) and case 17 (a PR with five deliverables)
  keep both from regressing.

## 1.17.0 — 2026-08-19

Shorter corrections, from a real reply that ran three times its budget.

- **The correction rule moved into the always-on core.** It was in the full
  ruleset and being skipped, because most turns run on the core alone — so a
  reply that found its own mistake spent a headed section explaining what it
  had misread, which is the account of the error the rule already banned.
- **Re-announcing after a check is now cut explicitly.** Saying the answer,
  going to verify, then opening the next message with the same sentence is a
  shape the ruleset had no name for.
- Case 15 tests both, so the rules regress instead of drifting.

## 1.16.0 — 2026-08-19

Reach: the same rules, in places they could not go before.

- **The core also ships as an output style.** It lives in the system prompt
  instead of being printed by a shell hook — so it works on Windows without
  Git Bash, where the hook fails silently, and it is cached rather than
  re-sent every session. Pick it in `/config` → Output style. The plugin
  does not force it: forcing would override the output style you chose.
  `check-parity` fails if the style and the hook core ever drift apart.
- **A version bump on `main` now tags and publishes a release**, with that
  version's CHANGELOG section as the notes — twelve versions had shipped
  with no tag to pin, roll back to, or watch.
- **The ruleset installs into other agents** — Cursor, Copilot, Codex,
  Windsurf — via `npx skills add`. Only the document travels; the README says
  plainly what stays behind.

## 1.15.0 — 2026-08-19

Measurement that discriminates. No rule changed; what changed is what can
catch a rule breaking.

- **`BASELINE=1` runs the cases with no style at all.** A case that passes
  there measures the model's habits, not the rules — the suite could not tell
  the difference before, and the maintainer's own `CLAUDE.md` was leaking the
  skill into every comparison.
- **`RUNS=3` reports `FLAKY`** instead of letting one lucky attempt read as a
  pass, and `MODEL=` pins the model so two runs are comparable.
- **`CORE=1` judges the always-on core** — the ~20 lines injected into every
  session, the most-used surface of the product, previously untested.
- **Five cases:** PR description, card that stands alone, status delta,
  bad news plus the second question, and draw-the-shape. Nine to fourteen.
- **A rule → case map** in `evals/README.md`, with the gaps named rather than
  implied.
- CI runs the suite for both ports and for the core, and a maintainer can
  launch it by hand on a fork PR, where secrets never reach the job.

## 1.14.0 — 2026-08-19

The surfaces the ruleset didn't reach, and the escape it never had.

- **Plans you propose** get a budget row and a section: the numbered steps
  you will run, the risk named, what it leaves out — and no retelling of the
  exploration that got you there. It is the text a user reads before
  authorising work.
- **Comments and replies** — review comments, issue replies, notes on a card
  — get a section: the claim then the line that proves it, what would change
  your mind instead of a hedged claim, no praise as filler, one point per
  comment. The credit guard now covers `gh pr review` too.
- **Asked to expand, expand.** "Explain in detail" turns the budgets off for
  that turn and the next turn is concise again, unasked — the padding never
  comes back with the length. It is the objection every always-on terse style
  has to answer.
- **Changelog entries** get two lines of rule: what changes for whoever
  installs, not the diff retold.
- Both descriptions now name every surface the ruleset governs, which is what
  the model reads when deciding to load it.

## 1.13.0 — 2026-08-19

Correctness pass over the whole plugin, from an audit of every surface.

- **`/concise:pr` stopped truncating its own output.** The delivery block is
  fenced with four backticks now: a PR description carries a `bash` block by
  rule, and the old three-backtick wrapper ended at that inner fence — on
  nearly every invocation. Same fix in `card` and `rewrite`.
- **The credit guard grew from two commands to eight**, reads the message
  when it comes from a file (`-F`, `--body-file`), and names Copilot, Gemini,
  Cursor and Codex besides Claude. It also gained two escapes, because a
  deterministic guard has false positives: `CONCISE_ALLOW_CREDIT=1` and
  `~/.claude/.concise-no-credit-guard`.
- **The hook logic moved into four versioned scripts** — `credit-guard.sh`,
  `inject-core.sh`, `self-update.sh`, `notices.sh` — byte-identical across
  ports, with the language passed in from `hooks.json`. The guard regex
  existed in four copies that could drift with CI green; now it exists once.
- **Self-update stamps before it runs**, so a permanent failure retries
  tomorrow instead of at every session start forever; takes a lock, so two
  sessions don't update the same clone at once; and announces the version it
  moved to. Opt out with `~/.claude/.concise-no-self-update`.
- **The welcome note is a `systemMessage`** — it reaches the user's screen
  instead of the model's context, which the style itself tells the model to
  cut.
- `/concise:pr` takes extra context besides a base ref, and states it never
  runs `gh pr create`. `/concise:rewrite` reads a file when the argument is a
  path.
- Rules: the `yes/no` opening yields to a false premise or real uncertainty;
  the hook core stopped banning headers the skill allows; two rules that
  failed the repo's own bar were removed. PT gained "antítese" in the
  rhetorical-flourish cut and the sharp reader in its core; EN gained
  "Required" in the description, which is what makes the model reach for the
  skill.
- The audit agent now knows commit messages and the stands-alone test.
- Tooling: `scripts/test-hooks.sh` (26 offline cases, in CI), CI validates
  every plugin JSON, `check-bump` rejects a version that goes backwards,
  `check-parity` compares hook behaviour instead of counting lines, and the
  eval runner aborts on an empty response, a missing rubric or a dead CLI
  instead of scoring them.
- Docs: install says the style starts next session, a quick-start sits at the
  top, uninstall is documented with its state files, the port guide lists
  what a third port must rename, and the stale "six evals" claim is gone.

## 1.12.0 — 2026-08-19

- Status updates carry only the delta: a new budget row and an always-cut
  entry ban re-summarising work an earlier message already reported — "CI
  green, ready to merge" is a whole turn. Both hook cores name it.

## 1.11.0 — 2026-08-19

- The PR description carries the card or issue that motivated the work, as
  a link — `Closes #N` on GitHub, the card's link or id on a board — when
  it exists in the conversation or a tracker tool can find it, and never
  otherwise. `/concise:pr` (`/respostas-curtas:pr`) gained the lookup step.

## 1.10.0 — 2026-08-19

- Self-update checks once per day instead of every session start — a stamp
  in `~/.claude`, written only when the update pair succeeds, so an offline
  day retries next session.
- The first session after install prints a one-line map of the commands
  and the agent, once.
- Repo side, no plugin change: the repo now practises the templates the
  skill preaches (`.github/PULL_REQUEST_TEMPLATE.md` and two issue forms,
  comment-guided so nothing renders as boilerplate), and the eval suite
  grows to nine cases — the `bash` fence, the overloaded opening, and
  commit messages join the six from the examples.

## 1.9.0 — 2026-08-19

- Cards grow three rules: what the conversation settled goes into the
  destination's fields, not the body and not silently the default; the
  tracker's issue template is a contract to fill; and creation starts by
  looking for the card that already exists.
- `/concise:card` (`/respostas-curtas:card`) creating at a destination now
  searches for duplicates first, honours GitHub issue templates, discovers
  and sets fields, links named blockers or parents, and reports what it set
  and what stayed at default.

## 1.8.0 — 2026-08-19

- PR descriptions grow four rules: the repo's `PULL_REQUEST_TEMPLATE` is a
  contract to fill in the register — no boilerplate sections, no checkbox
  ticked that isn't true; a many-file diff says where to start reading; the
  title follows the commit-title rule; and "and also" means two PRs.
- `/concise:pr` (`/respostas-curtas:pr`) reads the branch's commits for the
  why, fills the repo template when one exists, and delivers the title
  ready for `gh pr create --title` alongside the body.

## 1.7.1 — 2026-08-18

- The credit guard also covers the `PowerShell` tool — on Windows, a commit
  made through it used to walk past the 1.7.0 guard.
- The guard now catches compound commands. The 1.7.0 filter matched by
  prefix, so `git add -A && git commit …` — the most common real shape —
  never triggered it; detection moved into the guard itself, which runs as a
  tiny grep on every shell call. Known limit documented: a message passed
  via `git commit -F <file>` stays out of reach.

## 1.7.0 — 2026-08-18

- Credit guard, enabled by default: a `PreToolUse` hook denies `git commit`
  and `gh pr create` whose text carries AI credit — deterministic string
  match, no API call. The ruleset's hardest rule becomes a system rule.
- "Commit messages" section in the skill, and `/concise:commit`
  (`/respostas-curtas:commit`): drafts the message for what is staged —
  verb-first title ≤72 chars, body says why, draft only.
- The `pr` and `card` commands self-audit against their checklists before
  delivering.

## 1.6.0 — 2026-08-18

- Four aesthetic rules for what the model outputs, at zero budget cost: a
  runnable command gets a `bash` fence of its own (and every fence a
  language tag); table cells hold values with the prose staying outside; a
  PR that ships several deliverables lists them one per line instead of
  chaining semicolons; and the overloaded opening joins "Before sending" —
  verdict in sentence one, support from sentence two.
- Both hook cores name the `bash` fence.

## 1.5.1 — 2026-08-18

- Catalogue and manifest descriptions catch up with 1.5.0: three commands and
  the self-update hook, not just `rewrite`.
- Changelog dates corrected to the real merge dates (every release so far
  landed on 2026-08-18).

## 1.5.0 — 2026-08-18

- `/concise:pr` (`/respostas-curtas:pr`): drafts the pull request description
  for the current branch from the real diff, test steps at the end.
- `/concise:card` (`/respostas-curtas:card`): drafts a task/issue card that
  stands alone, and creates it when a reachable destination is named.
- Local core override: `~/.claude/concise-core-override.md`
  (`~/.claude/respostas-curtas-nucleo-override.md`) replaces what the
  `SessionStart` hook injects, and survives auto-updates — editing the cached
  `core.md` no longer does.
- Opt-in Stop auditor in `extras/stop-audit/`: warns when a turn's final
  response clearly violates the core. One API call per turn; off unless you
  install it.
- CI: `check-bump.sh` fails any PR that changes a plugin without bumping its
  version; evals run as an advisory job on PRs that touch `SKILL.md`.
- README: before/after figure, badges, and a full Portuguese translation
  (`README.pt-BR.md`), with structural parity checked in CI.

## 1.4.0 — 2026-08-18

- `/concise:rewrite` (`/respostas-curtas:reescrever`): rewrites a finished
  text to the ruleset without losing information.
- `audit` (`auditar`) agent: returns only the violations — quote, rule,
  one-line fix — plus required content that is missing.
- Self-update: a second `SessionStart` hook updates the plugin in the
  background at each session start (requires a version bump to move).
- CI parity check between the EN and PT ports; eval harness with six judged
  cases in `evals/`.

## 1.3.0 — 2026-08-18

- `SessionStart` hook injects a ~20-line core of the style into every
  session, making the style always-on without depending on invocation.

## 1.2.0 — 2026-08-18

- Tasks and issues: everything a card carries, what enters under condition,
  and the structure a narrow panel holds (no headers, no tables, bold only
  as item labels).

## 1.1.0 — 2026-08-18

- Tasks and issues as a destination surface; the version-bump rule that makes
  `claude plugin update` actually move.

## 1.0.0 — 2026-08-18

- First plugin release: install via marketplace in two commands instead of
  clone and copy.
