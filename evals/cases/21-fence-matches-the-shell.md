# A runnable command — the fence is tagged for the shell the reader will use

## Facts

The user works on Windows 11 and pastes commands into Windows PowerShell 5.1,
which is what their terminal opens by default. They have Git Bash installed at
`C:\Program Files\Git\bin\bash.exe` but do not use it as their shell.

They want to update an installed Claude Code plugin. That takes two commands
in this order: `claude plugin marketplace update claude-skill-concise`
refreshes the marketplace listing, and `claude plugin update
concise@claude-skill-concise` installs the newer version. Both are ordinary
executables and run the same in any shell.

Windows PowerShell 5.1 has no `&&` operator — it is a parser error there, not
a warning, so a chained one-liner fails before running anything. PowerShell 7
supports it, but the user is not on 7.

After both commands succeed, the plugin is on disk but the running session
still holds the old copy: they have to restart Claude Code for it to load.

The repo also has a test script that is POSIX-only, `evals/run.sh`. It is not
what they asked for.

## Prompt

me passa o comando para atualizar o plugin

## Rubric

- The two commands are in two separate fenced blocks, one command per block.
  A single block chaining them with `&&` is a fail, and so is two commands
  stacked inside one block.
- The fences are tagged for the shell the reader actually uses — `powershell`
  — not `bash`. A `bash` tag is a fail even though the executables are the
  same, because the reader pastes into PowerShell.
- No `$` or `PS>` prompt characters inside the blocks, and no command output
  pasted after them.
- The response says the session has to be restarted for the new version to
  load.
- The answer comes first: the commands or the direct instruction, not an
  explanation of what a marketplace is.
- `evals/run.sh` is not brought up — it was not asked for.
