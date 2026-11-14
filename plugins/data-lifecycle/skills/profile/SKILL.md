---
name: profile
description: "Profile a data source before designing on it: grain, keys, types, quality, and traps."
disable-model-invocation: true
---

# profile

Understand new data before anything is built on it. The output is a report. Nothing else is written and nothing in the source is changed.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Count, never eyeball.** If the data or a connection to it is available, run the profile and report measured numbers. If you only have a schema or documentation, say which findings are measured and which are read off the documentation, and give the user the checks to run for the rest.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the report and wait. Do not start a spec or invoke another skill.

## What to establish

1. **Grain.** One sentence stating what a single row, event, or object represents. Be exact about the difference between, for example, one order and one change to one line of an order.
2. **Keys.** Candidate primary keys, composite keys, and identifiers shared with other systems. Measure uniqueness and null rate. If the grain or key cannot be confirmed from what you have, list it as an unverified risk instead of choosing one.
3. **Change and delete behaviour.** Append-only, updated in place, or reloaded in full. How a deleted record shows up, if it shows up at all.
4. **Field audit.** A table of the fields that matter:

   | Field or path | Observed type | Recommended type | Null or blank rate | Traps |
   | :--- | :--- | :--- | :--- | :--- |

   Look in particular for:
   - **Time:** zone, missing offsets, dates stored as text, epoch values in seconds versus milliseconds.
   - **Numbers:** money or quantities held as floating point, negative values on refunds and adjustments, mixed units or currencies.
   - **Nested and repeated structures:** lists inside a record that multiply rows when flattened.
   - **Text:** stray whitespace, inconsistent case on join keys, placeholder values standing in for null, embedded delimiters and line breaks.
   - **File format:** delimiter, quoting, encoding, decimal separator, header rows.
5. **Relationships.** For each reference to another entity, the child records whose parent is missing.
6. **Gaps.** Periods with no records, entities that never change, sudden shifts in volume.
7. **Sensitive data.** Fields holding personal, financial, or credential data. Mask the values in the report.
8. **Extraction constraints.** How changes can be detected, paging behaviour, rate and size limits, ordering guarantees, and whether retries on the source side produce duplicates.
9. **Documentation drift.** If documentation or metadata exists, the fields it does not mention and the fields it describes that did not arrive.

## Output

A **Source profile** with:

1. Headline numbers: record count, date range, key uniqueness.
2. Findings ranked by impact. Each states how many records it affects and the design decision it forces.
3. The top traps the design must handle.
4. Checks not yet run, written for the user's platform, with what each would settle.
