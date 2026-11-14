# Code standards

Language-neutral standards for pipeline, integration, and infrastructure code. Where a project's own conventions differ, the project wins.

## Fit the codebase

- Match the existing structure, naming, formatting, and idioms. Consistency with the surrounding code matters more than any preference in this file.
- Reuse existing helpers and patterns before writing new ones.
- Use the project's existing dependencies. Ask before adding one.

## Structure

- A function does one thing and its name says what.
- Keep control flow flat. Return early instead of nesting.
- Keep entry points thin: they read input, call the logic, and write output. The logic takes plain values and returns plain values, so it can be tested with a fixed input.
- Do not add an abstraction, a base class, a wrapper, or a configuration option until there is a second real use for it. Reuse comes from small clear functions and a clean contract, not from flexibility built in advance.
- Do not write a function that is called once and only passes its arguments along.
- Delete code that is no longer used. Do not leave it commented out or keep a compatibility path for something that never shipped.

## Naming

- Names say what a thing holds or does in the domain's own terms. Use the project's glossary where it has one.
- No abbreviations a new reader would have to look up, and no type or scope encoded in the name.

## Comments

- A comment explains why: a business rule, a constraint, a workaround and what it works around, a decision that would otherwise look wrong.
- Do not write a comment that restates the line below it, labels an obvious block, or narrates the change ("added", "updated", "now handles").
- Do not address the reader or the reviewer.
- No banner or divider comments, and no decorative characters.
- Document a public entry point or a non-obvious contract: what goes in, what comes out, what it assumes. A small private function with a clear name needs no description.
- If code needs a comment to be understood, first try to make the code clearer.

## Validation and errors

- Validate data once, where it crosses into the system from outside: a source payload, a file, a request, a parameter from a caller you do not control. Past that point, trust it. Rechecking the same thing at every internal call is noise.
- Do not handle states that cannot occur.
- Never catch an error only to ignore it, log it and carry on, or replace it with a default. Either handle it in a way the design calls for, or let it fail with enough context to diagnose: what was being processed and which record.
- Retry only where the design says to, and only errors that can succeed on a second attempt.
- A run that did not do its job must not look like a success.

## Data handling

- Writes are safe to repeat: the same input run twice leaves the same result.
- Timezones are explicit wherever a time is read, compared, or written.
- Money and quantities use exact numeric types.
- Any ordering used to choose between records is fully determined, so two runs choose the same record.
- Read only the fields and the range needed.
- Pass values to queries and commands as parameters. Never build them by joining strings with input.

## Configuration and secrets

- Anything that differs between environments comes from configuration, not from the code.
- Secrets come from the project's secret store. They never appear in code, configuration files, defaults, examples, or logs.
- Do not add a setting nobody asked to be able to change.

## Infrastructure definitions

- Declare only the resources this slice needs.
- Permissions are explicit and minimal: named actions on named resources, no wildcards.
- No parameters, outputs, or conditions that nothing uses.
- Names and tags follow the project's convention.
- Set timeouts, retention, and limits deliberately instead of leaving platform defaults where the default is unbounded.

## Logging

- Log what an engineer needs during an incident: which run, what window, how many records read, written, and set aside, and how long it took.
- Do not log whole payloads, sensitive fields, or credentials.
- Do not log a line for every step that succeeded.

## Tests

- Test behaviour through the entry point a caller would use, with fixed inputs and expected outputs.
- Cover the edge cases the spec names. Do not write tests that restate the implementation or can never fail.

## Residue list

Check the finished diff for each of these and remove what you find:

- Comments that restate code, narrate the change, or decorate.
- Descriptions on trivial functions.
- Checks or error handling for conditions that cannot happen on this path.
- Errors caught and swallowed, or replaced with a default.
- Wrappers, helpers, classes, or options with a single use.
- Parameters, settings, resources, permissions, or outputs that nothing uses.
- Leftover debugging output, placeholder notes, unused imports and variables.
- Commented-out code and compatibility paths for code that never shipped.
- Deep nesting that early returns would flatten.
- Anything styled differently from the file around it.
- Documentation files, examples, or summaries nobody asked for.
