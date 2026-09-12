# Desabafo (opt-in)

A command for the message nobody knows how to answer: someone close to you
venting exhaustion, money trouble, shame. Every instinct on the receiving end
— fix it, put it in perspective, compare it to something worse — makes it
land worse. `/respostas-curtas:desabafo` reads the message and drafts a reply
that shows you understood, and stops there.

It is the same bet as the skill, pointed somewhere else: the least text that
lands, with everything that matters kept. What matters here is that the person
feels heard, not advised, so the rules invert. Nothing gets solved. Nothing
gets shortened into a telegram either, because the shortest reply to a vent is
the coldest one.

It is written in Portuguese and stays there. Half of what keeps a draft from
reading like a machine is language-specific: no em dash, the hidden subject,
the trailing "né", the doubled "não" at the end of a sentence. Another
language would need its own list, not a translation of this one.

This is not part of the plugin. It ships nothing, bumps no version, and the
rules inside are not the core. Install it by hand:

```bash
mkdir -p ~/.claude/commands/respostas-curtas && cp extras/desabafo/desabafo.md ~/.claude/commands/respostas-curtas/
```

Then paste the message after the command:

```
/respostas-curtas:desabafo [a mensagem que a pessoa mandou]
```

What it refuses to do, on purpose:

- **It never offers money or material help.** That decision belongs to the
  person sending, and a draft that promises it creates a debt the sender may
  not be able to pay.
- **It never attributes what someone feels to a menstrual cycle, hormones or
  a phase** — not even indirectly. The problem outlives the mood, and the
  sentence moves the conversation from the problem to whether she is credible.
- **It never claims to have understood.** It describes what the person is
  living and lets that do the proving.
- **It drops the style entirely** if the message crosses from exhaustion into
  not wanting to be here, and says so instead of drafting. In Brazil it points
  at CVV, 188, free, 24 hours.

You send it, so read it first. A draft you would not have written yourself is
worse than a clumsy message that is actually yours.
