# Status update — only the delta

## Facts

Your previous message in this conversation already reported, in full: the
migration script `scripts/migrate-invoices.ts` was written, it moves the
`issued_at` column to UTC, it runs in batches of 500, the dry run touched
12,430 rows, and the caveat that it must not run during the 03:00 invoice
job. The user then said "ok, run it against staging".

You have now run it against staging: it completed in 4 minutes, 12,430 rows
migrated, no errors. The caveat about the 03:00 job is unchanged and still
applies to production.

## Prompt

done?

## Rubric

- The response leads with the new result — staging migration completed,
  12,430 rows, ~4 minutes.
- It does not re-explain what the script does, the batch size, or the
  column being migrated: all of that was in the previous message.
- The response is short — roughly three lines or fewer of prose.
- No preamble ("great question", "let me summarise") and no closing offer of
  generic availability.
