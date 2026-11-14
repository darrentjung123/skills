---
name: review
description: "Review pipeline code, queries, flows, or configuration, with findings ranked by severity."
disable-model-invocation: true
---

# review

Review what the user has built before it runs in production. Say plainly what would break and how to fix it. Agreeing to be polite helps nobody here: the cost of a missed defect lands on the same engineer later, usually at a worse time.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** If a spec or requirements document is in the conversation or the files, review against it and report where the build departs from it.
- **Rank by severity.** `BLOCKER` corrupts data, exposes something, or breaks a budget. `WARNING` is an edge case or an operational burden. `NIT` is style.
- **Judge on evidence.** A verdict covers only what you have seen. If no test results or run output were provided, say that the verdict is on the code as read and list what remains unverified. Do not call something ready on the strength of how it looks.
- **Stop when done.** Deliver the review and wait for the user to decide which fixes to apply. Do not apply them or invoke another skill.

## Passes

Work through each pass that applies to what was submitted.

### 1. Correctness and grain
- Can any join multiply rows because the other side is not unique on the join key?
- Are fields that can be empty used in comparisons, exclusions, concatenation, or arithmetic without handling the empty case?
- Does deduplication always pick the same record, or can two runs pick different ones?
- Are timezone conversions and date cut-offs explicit?
- Are amounts held in exact numeric types?

### 2. Idempotency, incremental logic, and state
- What happens if this runs twice, or is retried after failing most of the way through?
- Does the incremental filter miss late-arriving records? Does the write update existing records or blindly append?
- Does progress advance only after the write succeeds?
- What happens when the source adds, removes, or retypes a field?

### 3. Cost and performance
- Full-history scans where a filtered or incremental read would do.
- Reading every field when a few are needed.
- Filters written so the engine cannot use partitioning or indexes.
- Calls to an external interface inside a loop where a batch call exists, and missing paging limits.
- Per-run or per-record costs that grow with volume, and missing limits on runtime or spend.

### 4. Security and error handling
- Secrets in code or configuration, permissions broader than needed, input concatenated into queries or commands.
- Sensitive values or credentials reaching logs or error messages.
- Transient failures retried with backoff, and bad records routed aside without halting everything or being silently dropped.
- Does a failure announce itself, or would the run look successful?

### 5. Maintainability
- Could one engineer understand and debug this in a few minutes, six months from now?
- Are business rules visible and named, or buried as unexplained constants?
- Is there anything here that exists for a future that may not come?

Check for generated-code residue as part of this pass. Each of these is a `WARNING` when it hides behaviour and a `NIT` otherwise:

- Comments that restate the code, narrate the change, or decorate, and descriptions on trivial functions.
- Checks or error handling for conditions that cannot occur on that path. Validation where outside data enters is not residue. Repeating it at every internal call is.
- Errors caught and swallowed, or replaced with a default.
- Wrappers, helpers, classes, or options with a single use.
- Parameters, settings, resources, permissions, or outputs that nothing uses.
- Leftover debugging output, placeholder notes, commented-out code.
- Deep nesting that early returns would flatten.
- Anything styled differently from the file around it.

## Output

1. **Verdict:** `READY`, `READY WITH FIXES`, or `NOT READY`, with one line on what the verdict is based on.
2. **Findings**, grouped by severity. For each blocker and warning:
   - Location
   - What goes wrong, as a concrete scenario
   - Fix, with corrected code for blockers
3. **Downstream impact:** datasets, reports, or contracts this change could affect.
4. **Not verified:** what the review could not establish from the material provided.
