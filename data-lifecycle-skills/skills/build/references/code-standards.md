# Code standards

The global CLAUDE.md rules, with the detail `/build` needs. Project conventions win on style. These win on correctness and safety.

## Fit
- Match the project's structure, naming, and idioms. Reuse existing helpers and dependencies; ask before adding one.
- Match style, not defects: never copy swallowed errors, hardcoded secrets, string-built queries, unbounded reads, or dead code. Write it correctly and note the difference.
- Don't refactor or reformat outside the slice. Note it instead.
- If the user says the code is being cleaned up or replaced, these standards beat local style.

## Size and structure
- Smallest change that passes the gate. No abstraction, wrapper, option, or helper without a second real use.
- One job per function, named for it. Return early to keep nesting flat.
- Thin entry points: read input, call the logic, write output. Logic takes and returns plain values so it runs on fixed input.
- Delete unused code; don't comment it out.

## Comments
- Explain why: a business rule, a constraint, a workaround, a decision that looks wrong. Never restate code, narrate changes, or decorate.
- Document public entry points and non-obvious contracts only.

## Inputs and failures
- External input (payloads, files, responses, user input, anything another team owns) is untrusted. Validate it once where it enters, then trust it.
- Handle what the environment can produce: nulls in external data, timeouts, partial failures, rate, size, and quota limits, duplicate deliveries. Not states your own logic rules out.
- Unsure whether a case can occur? Check the code, schema, or docs, or ask. Say when a case is left unhandled on purpose.
- Never swallow errors or default them away. Fail with context: what was being processed, which record.
- Retry only transient errors, and only where the design says to.
- A failed run must not look successful.

## Data
- Reruns are safe: same input, same result.
- Explicit timezones, exact numeric types for money and quantities, deterministic ordering when choosing between records.
- Read only the fields and range needed. Parameterise queries and commands.

## Stakes
One-off and exploratory code: correctness and clarity only. Unattended code or code that touches shared data: everything here.

## Configuration, infrastructure, logging
- Environment values come from configuration. Secrets come from the secret store, never code, config files, examples, or logs.
- Infrastructure declares only what's needed: named actions on named resources, no wildcards, deliberate timeouts and retention.
- Log run id, window, records read, written, and set aside, and duration. No payloads, sensitive fields, or credentials.

## Tests
Test behaviour through the caller's entry point with fixed inputs. Cover the spec's edge cases. No tests that can't fail.

## Residue check
Before reporting, remove from the diff:
- Comments that restate, narrate, or decorate
- Checks for states your logic rules out (boundary validation stays)
- Swallowed or defaulted errors
- Single-use wrappers, helpers, or options
- Unused parameters, settings, resources, permissions, outputs, or imports
- Debug output, placeholder notes, commented-out code
- Nesting that early returns would flatten
- Style that doesn't match the file
- Docs or summaries nobody asked for
