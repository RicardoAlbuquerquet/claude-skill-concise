---
name: audit
description: Audits text against the `concise` checklist. Reports violations with the offending text, broken rule, one-line fix, and missing required content. Audit only; rewriting belongs to `/concise:rewrite`.
---

## tools: Read, Grep, Glob
Audit one text against the `concise` style rules.
The caller provides inline text or a file path. Read the file when a path is provided.
Do not rewrite the text. Report only what must change.

## Destination
Identify the destination first:
* chat reply;
* PR description;
* task/issue card;
* commit message.

If unclear, assume **chat reply** and state the assumption.
Then audit in this order.

## 1. First sentence
The first sentence must contain the answer or main finding.
Flag anything placed before it:
* preamble;
* unnecessary header;
* restatement of the question.

## 2. Always-cut violations
Flag:
* preamble or postamble;
* process narration;
* narration of upcoming tool calls;
* prose repeating code or tool output;
* unnecessary justification;
* option menus when the writer should decide;
* rhetorical flourishes;
* mid-text self-corrections;
* hedging on confirmed facts;
* internal codebase names the reader will not use;
* authorship/bylines other than the user's.

Keep exact values the reader may need, including paths, hashes, branches, versions, and numbers.

## 3. Structure
### Inflation
Flag:
* a header over one paragraph;
* bullets splitting one idea unnecessarily;
* list items carrying multiple claims;
* unnecessary parentheses;
* excessive bold or backticks;
* decorative emoji;
* table columns that do not vary.

### Over-compression
Flag:

* one block covering multiple subjects;
* prose comparisons better represented as a table;
* blocks mixing information with a decision required from the reader.

### Runnable code
Flag:
* multiple independent commands in one fence;
* commands mixed with output;
* untagged fences;
* the wrong shell tag.

Commands must match the shell the reader will use.

### Diagrams
Flag:
* unlabeled arrows;
* lines over 72 columns;
* inconsistent glyphs or direction;
* detached labels;
* irrelevant internal names;
* diagrams repeating the surrounding prose;
* unnecessary legends;
* failure paths mixed into the happy path;
* repeated identical nodes where `×N` is clearer;
* Mermaid when the destination cannot render it or ASCII is sufficient.

## 4. Recommendations
Every recommendation needs:
* the recommendation;
* ≤3 lines of reasons;
* ≤3 lines of costs, risks, or trade-offs.

A missing downside is a violation.

## 5. User-owned choices
For decisions involving money, risk, or irreversible actions:
* show viable options side by side;
* compare their consequences;
* still provide a recommendation;
* explain why it wins over the alternatives.

## 6. Always-keep holes
Report missing:
* bad news or failures;
* exact values;
* real uncertainty;
* excluded scope;
* shared-state changes.

Also flag:
* a path shortened to its basename on first mention when the reader must open it;
* bad news placed after successful results instead of before them.

## 7. Destination-specific rules
### PR description
Must contain, in order:
1. problem being solved;
2. what was done;
3. how to test.

The PR should open with the problem, not repeat the title.

It must end with:
* exact test command;
* expected success result;
* evidence that would indicate failure.

Flag:
* prose repeating the diff;
* file-by-file summaries;
* counts of changed files or lines without decision value.

### Task or issue

Must stand alone and include:
* what changes in the title;
* area first when needed for board context;
* current → expected behavior;
* exact values;
* done criterion;
* explicit scope.

Use headers and tables only when the content earns them.
Flag references to missing conversation context such as:

* "as discussed";
* "the problem you mentioned".

### Commit message

Require:
* title ≤72 characters;
* title ending in a letter;
* title describing what changes;
* body explaining **why**, not repeating the diff.

The body should exist only when needed.
Flag references to conversation context.

## 8. Sentence shape
Flag clear cases of:
* announcing clauses: "it is worth noting that...";
* hidden actors/passive constructions: "validation is performed".

Prefer direct subject + action.

## Report format

Return only:
1. First line: `N violations, M holes` or `clean`.
2. Numbered violations, each containing:
   * shortest useful quote;
   * broken rule;
   * one-line fix.
3. Missing content, each starting with **Missing:**.

If clean, return only:
`clean`
