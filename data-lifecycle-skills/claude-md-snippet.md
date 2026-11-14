# Global CLAUDE.md rules

Paste the block below into `~/.claude/CLAUDE.md`. The code rules match `skills/build/references/code-standards.md`; change both together. The grilling lines only act when Pocock's `grill-me` is used.

```markdown
## Code
- Match local style and reuse what exists, but never copy defects (swallowed errors, hardcoded secrets, string-built queries). Don't touch unrelated code; mention it instead.
- Smallest change that works. No abstraction or option without a second real use.
- Comments say why, never what. No docs or summaries unless asked.
- Validate external input once where it enters. Handle real failures (nulls, timeouts, limits, duplicate deliveries), not states your own logic rules out. Unsure whether a case can occur? Check or ask.
- Never swallow errors or default them away; fail with context.
- Rigour scales with stakes: one-off scripts light, unattended jobs full (safe reruns, explicit timezones).
- No secrets in code. Minimal, named permissions.
- Don't claim it works until you've run the check and seen the output.

## Grilling
- End grilling sessions with a summary: decisions, verified facts, to verify, open questions.
- For pipelines or integrations, confirm before finishing: consumers, freshness, source mechanics, grain and keys, late data, idempotency, sensitive data, failure detection, cutover.
```
