# Optional: always-on rules

The skills in this pack run only when you invoke them. The two blocks below are for `~/.claude/CLAUDE.md` (all projects) or a project's `CLAUDE.md`. Paste either or both.

## Code standards

Applies the core code standards to everything Claude Code writes, not only to `/build`.

```markdown
## Code standards

- Match the conventions of the surrounding code before any other preference.
- Write the smallest change that does the job. No abstractions, options, or helpers until there is a second real use.
- Comments explain why, never what. No comments that restate code, narrate the change, or decorate.
- Validate data once, where it enters from outside. Do not handle states that cannot occur.
- Never catch an error to ignore it or replace it with a default. Fail with enough context to diagnose.
- No secrets or environment-specific values in code.
- Infrastructure definitions declare only what is needed, with explicit minimal permissions.
- Do not create documentation files, examples, or summaries unless asked.
- Do not claim something works until its check has been run and the output seen.
```

## Grilling

For use with Matt Pocock's `grill-me`. The first line makes a session end with the summary that `/requirements` and `/spec` read. The second adds data-specific coverage, and only when the subject is a pipeline or integration.

```markdown
## Grilling

- When a grilling session ends, write a summary: decisions, facts verified, items to verify, open questions.
- When grilling a pipeline or integration, before finishing check that these are settled or not applicable: consumers and freshness, source mechanics, grain and keys, late data, idempotency and recovery, sensitive data, how failure is detected, cutover.
```
