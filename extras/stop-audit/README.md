# Stop auditor (opt-in)

A `Stop` hook that judges each turn's final response against the concise core
and shows a one-line warning when it clearly violates it. It is the
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

Limits, before you rely on it:

- **Experimental.** It reads the last assistant message out of the session
  transcript, whose format is not a public contract; on any parse failure it
  exits silently instead of blocking your session. Needs the `claude` CLI on
  PATH, plus `jq` or `node` for the JSON handling.
- The judge call was not exercised end-to-end in CI — there is no API key
  there. Test it once after installing: ask something trivial and check
  whether a deliberately bloated answer draws the warning.
- Remove it by deleting the `Stop` entry from your `settings.json`.
