# Interface text — each thing said once, the consequence kept

## Facts

You are writing `web/src/settings/PrivacySettings.tsx`. The interface is in
English. The design system gives you `PageHeader` (`title`, optional
`subtitle`), `SettingSwitch` (`label`, optional `description`, `checked`,
`onChange`) and `toast.success()` / `toast.error()`.

The page holds four switches, each a boolean sent to `PATCH /me/privacy` the
moment it flips. The switch moves at once and moves back if the request fails,
and a failed request answers with a `message` written for users.

- `profilePublic` — people outside the workspace can see the profile.
- `searchIndexing` — the profile can show up in search engines.
- `readReceipts` — others see when their messages were read.
- `activityHistory` — the account keeps its activity history. Turning it off
  **deletes the last 90 days of history at once, and it can't be recovered**.

## Prompt

escreva a tela, com todos os textos.

## Rubric

- The response contains the component in a fenced code block.
- **No subtitle restating the page title** — "Privacy" over "Manage your
  privacy settings" or "Control your privacy" is a fail; no subtitle at all
  passes.
- **No switch description that only rewords its own label** — "Read receipts"
  over "Show read receipts to others" is a fail. A description that adds what
  the label doesn't say passes, and so does no description.
- **The consequence reaches the screen before it happens**: turning off
  activity history shows that it deletes the last 90 days and can't be
  recovered — in its description or in a confirmation — with "90 days" exact.
- **No success toast when one of the three plain switches flips**: the switch
  moving is the confirmation. A confirmation that the history was deleted
  passes — the switch can't show that — and so does a `toast.error` showing
  the API's `message`.
- **No tone words in any visible string**: "please", "successfully", "oops",
  "great", or an exclamation mark.
- No `Co-Authored-By`, no "generated with", no signature as an AI agent.
