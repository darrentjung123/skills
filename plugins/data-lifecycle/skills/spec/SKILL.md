---
name: spec
description: "Write the technical specification for a pipeline or integration."
disable-model-invocation: true
---

# spec

Write the document the pipeline is built from. Its readers are the engineer who builds it and whoever is woken up by it later.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Read the requirements, source profile, and grill summary if they are in the conversation or the files. Refer to business rules by their place in the requirements instead of restating them. The requirements say what is needed. This document says how it is done.
- **Ask before guessing the foundations.** If the output grain, the way the source emits data, or the target runtime is unknown, ask first, in one numbered round with a recommended answer per question.
- **No implementation code.** Schemas, contracts, and pseudo-logic only. The build comes after the spec is approved.
- **Prefer the simplest design that meets the requirement.** Assume one engineer maintains this alone. Every hop, tool, and abstraction has to justify its running cost. Name the lighter option you considered.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the spec and wait for approval. Do not start a plan or code, and do not invoke another skill.

## Document

Include the sections that apply and drop the rest. A small job may need only sections 1, 3, 5, 7, and 10, at a few lines each.

```markdown
# Technical specification: [name]

## 1. Summary and decision
- Context and objective:
- Chosen approach:
- Options considered:
  | Option | Strengths | Weaknesses and running burden | Cost and lock-in | Verdict |
  | :--- | :--- | :--- | :--- | :--- |
- Non-goals:

## 2. Architecture and flow
- Diagram of every hop from source to consumer
- Numbered walk-through of one record from creation to consumption

## 3. Contracts
- Source: how it is accessed, extraction mode (full, incremental, change capture, pushed event), the field that marks change
- Target: grain statement (required), key, physical organisation
- Field mapping:
  | Target field | Type | Nullable | Source field or expression | Rule | Sensitivity |
  | :--- | :--- | :--- | :--- | :--- | :--- |
- Structure-change policy: what happens when the source adds, removes, renames, or retypes a field

## 4. Transformation and edge cases
- Deduplication rule, with a tie-break that always picks the same record
- Time normalisation and business cut-off
- Late-arriving data and how far back each run looks
- Deletes, voids, and negative adjustments

## 5. Idempotency, state, and backfill
- Why running the same input again leaves the target unchanged
- Where progress is tracked and when it advances
- How a date range is reprocessed
- How quarantined records are replayed

## 6. Orchestration and service levels
- Trigger and dependencies
- Overlap rule: what happens if a run starts while the last one is still going
- Timeouts and rate limits
- Freshness target and the point at which an alert fires

## 7. Failure handling
| Scenario | How it is detected | Automatic response | Where bad data goes | Manual recovery |
| :--- | :--- | :--- | :--- | :--- |
Cover at least: source unavailable, malformed or unexpected input, target write failure, and silent failure (no rows, a volume drop, or a trigger that stops firing).

## 8. Security and governance
- Identity the job runs as and its permissions
- Where secrets live and how they rotate
- Protection of sensitive fields
- Retention

## 9. Cost
- What drives cost
- Guardrails

## 10. Verification and rollout
- Edge cases that must pass before release
- Reconciliation gate against the source
- Rollout steps and how to roll back
```

## Deeper references

Read these only when the work calls for them.

- `references/orchestration.md`: read when the pipeline has more than a simple schedule, for example event triggers, multi-step dependencies, retries with quarantine, or backfill runbooks.
- `references/security.md`: read when the data is sensitive, crosses a trust boundary, or the pipeline exposes an endpoint.

## Finishing

Present the spec, list the assumptions that carry the most risk, and ask the user to approve it or name the sections to revise.
