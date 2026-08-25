# Card — labelled lines, not five paragraphs of prose

## Facts

The product is a web app with a collapsible sidebar. You are writing the card
for a change nobody has started.

Collapsing the sidebar on desktop today leaves a 56px strip of icons behind.
The width comes from `RAIL_WIDTH` in `web/lib/ui/sidebarPreference.ts:33`, and
the grid that reserves it is at `web/components/shell/AppShell.tsx:123`. What
is wanted instead: the column disappears completely when collapsed, the 56px
go back to the content, and the whole navigation lives behind the header's
panel button — which already exists on desktop and already calls
`sidebar.toggle`.

This reverses a decision taken on purpose in the card "Sidebar: collapse and
resize", id `dc4349ac-3d4d-4371-a6b4-54bfc2b097a9`, shipped in PR 201. That
card weighed disappearing entirely and chose the strip, so that Inbox and
search would not become two clicks. In practice the strip does not buy that:
with no labels it takes screen width without telling anyone where they are,
and the person collapsing is asking for the screen back.

What still holds from that card: the collapsed state survives a refresh
through the key `vx-sidebar-collapsed`, the chosen width stays stored in
`vx-sidebar-width` for when it expands again, and below 760px nothing changes
— the bar is already out of the grid there and becomes a drawer.

It is finished when collapsing leaves no strip of the bar on screen, the
header's panel button opens the navigation while the bar is collapsed, and
expanding gives the bar back at the width the person had chosen.

Out of scope: touching the resize limits, `MIN_WIDTH` 200 and `MAX_WIDTH` 420,
and changing what appears inside the bar.

The board holds several areas, and this one is the app shell. Priority,
assignee and due date are fields nobody has set.

## Prompt

escreva o card dessa mudança.

## Rubric

- **The body opens with two short paragraphs — current, then expected — and
  neither runs past two sentences.** A first paragraph that also carries the
  reversal, the storage keys or the done criterion is a fail.
- **The recurring slots are labelled lines, each opening in bold on its own
  line**: done criterion, out of scope, and the reversal of the earlier card.
  A body that buries the done criterion inside a paragraph fails, even when
  the sentence is correct.
- **No prose paragraph carries more than two code spans, and no parenthesis
  sits inside another parenthesis.** A line that opens with a bold label is
  not a prose paragraph: its spans are not counted, and the where-line
  carrying three or four of them is exactly right. Count spans only in the
  two opening paragraphs and in any other unlabelled prose. This is a layout
  rule, not a licence to drop values: `RAIL_WIDTH`, `web/lib/ui/sidebarPreference.ts:33`,
  `web/components/shell/AppShell.tsx:123`, `sidebar.toggle`,
  `vx-sidebar-collapsed`, `vx-sidebar-width` and the 56px still have to be
  findable in the card. The two code pointers belong on a labelled line of
  their own — a "where" line — not stacked inside the sentence that describes
  the behaviour.
- The earlier card is named with its id `dc4349ac-3d4d-4371-a6b4-54bfc2b097a9`
  or PR 201, and the reason the strip is being dropped is there in **two
  sentences or fewer** — the reversal is a line on the card, not that card's
  argument replayed.
- **Out of scope keeps its values**: `MIN_WIDTH` 200 and `MAX_WIDTH` 420.
- The title says what changes and opens with the area, and the body carries
  no `##` header at all.
- Priority, assignee and due date do not appear **in the card body**. A line
  outside the body telling the user those fields were left unset is not a
  violation — it is what the reader of this conversation needs, and it is not
  part of the card.
- Nothing that only makes sense to someone who read this conversation, and no
  credit to an AI agent.
