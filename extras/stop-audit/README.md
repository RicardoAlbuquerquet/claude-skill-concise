# Stop auditor (opt-in)

A `Stop` hook that judges each turn's final response against four rules —
answer in the first sentence, no preamble or process narration, a
recommendation carries its cost, exact values and caveats kept — and shows a
one-line warning when it clearly violates one. It judges that fixed list,
not the shipped core and not your `~/.claude/concise-core-override.md`: a
per-turn judge has to stay cheap, so the prompt is short by design. It is the
enforcement layer the plugin deliberately doesn't ship enabled: **it costs
one API call and a few seconds per turn**, and a style judge is a model
grading prose — expect occasional false positives. Install it only if that
trade reads as worth it to you.

Install:

```bash
mkdir -p ~/.claude/hooks && cp extras/stop-audit/stop-audit.sh ~/.claude/hooks/
```

Then add to `~/.claude/settings.json` (merge with your existing `hooks` key
if you have one):

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/stop-audit.sh",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

It judges against the same core the `SessionStart` hook injects, read from
`$CLAUDE_PLUGIN_ROOT/hooks/core.md`. When the plugin root is not in the hook's
environment, point `CONCISE_CORE` at the file:

```bash
CONCISE_CORE=~/.claude/plugins/concise/hooks/core.md bash ~/.claude/hooks/stop-audit.sh
```

Your own `~/.claude/concise-core-override.md` wins over both, so the auditor
grades against whatever governs your sessions. With none of the three
readable it falls back to a four-line summary, which is enough to keep
working and not enough to be current.

Limits, before you rely on it:

- **Experimental.** It reads the last assistant message out of the session
  transcript, whose format is not a public contract; on any parse failure it
  exits silently instead of blocking your session. Needs the `claude` CLI on
  PATH, plus `jq` or `node` for the JSON handling.
- The judge call is not exercised against the real model in CI — there is no
  API key there. `scripts/test-hooks.sh` covers the wiring with a fake
  `claude`: that the core reaches the prompt, that a violation becomes a
  warning, that `OK` stays silent, and that a missing core falls back instead
  of dying. Test the judgement itself once after installing: ask something
  trivial and check whether a deliberately bloated answer draws the warning.
- Remove it by deleting the `Stop` entry from your `settings.json`.
