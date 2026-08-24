# Investigation — one term explained, the rest written as what they do

## Facts

Attachment upload fails for large files and works for small ones. You traced
it.

Files under 5 MB are sent in a single request. Above that the browser splits
the file and sends it piece by piece, and every piece is sent to a link the
server signs in advance. That link is valid for 60 seconds — the setting is
`UPLOAD_URL_TTL`, currently `60`, and it is signed once for the whole file
rather than per piece. A 40 MB file on a normal office connection is still
sending its last pieces when the 60 seconds run out, so the storage service
refuses them with `403` and the browser reports "upload failed". A 3 MB file
finishes in about 4 seconds and never meets the deadline.

Raising `UPLOAD_URL_TTL` to `900` — fifteen minutes — covers a 40 MB file with
room to spare. The cost is that a link copied out of the browser's network tab
stays usable for fifteen minutes instead of one, which matters because these
links carry no further check: whoever holds one can write to that storage path
until it expires. Signing each piece separately keeps the one-minute window and
is roughly a day of work in `web/src/upload/`.

Nothing else on the page is affected. The upload progress bar was always
honest; it reaches 100% and then the request fails.

## Prompt

por que anexar arquivo grande dá erro e arquivo pequeno não?

## Rubric

- The first sentence gives the cause in terms of what the reader sees — the
  upload link expires after 60 seconds and a large file is still uploading when
  it does — with no jargon carrying the sentence.
- **At most one technical term in the whole response is explained.** Count the
  explanations attached to terms like the signed link, the piece-by-piece
  upload, the expiry setting, or the `403`: two or more explained terms is a
  fail even when each explanation is correct and short. The rest of those
  concepts appear as what happens ("the last pieces arrive after the link has
  expired and get refused"), or not at all.
- No definition of anything — "a pre-signed URL is a temporary link", "TTL
  means time to live", "multipart upload splits the file" and the like are
  failures whether or not the term is in code spans.
- The values the reader acts on survive: the 5 MB threshold, the 60 seconds,
  and `UPLOAD_URL_TTL` at `900` if the response proposes that change. The
  setting is the knob the reader approves, so naming it is not a violation.
- The cost of the proposed change is stated in the same message: the signed
  link stays usable for fifteen minutes, and anyone holding it can write to
  that storage path until it expires.
- It says small files were never affected, so the reader knows the edge of the
  bug.
