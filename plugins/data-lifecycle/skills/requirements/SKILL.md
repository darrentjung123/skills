---
name: requirements
description: "Write a short requirements document that stakeholders can sign off."
disable-model-invocation: true
---

# requirements

Write the document a business stakeholder signs off before design starts. It says what is needed and why. It does not say how it will be built. Keeping the two apart stops this document and the spec from restating each other and drifting.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Draw on a grill summary, a source profile, tickets, emails, or notes if they are in the conversation or the files. Do not ask again for anything they already settle.
- **Write for the stakeholder.** Plain language, no implementation choices, no product names unless the stakeholder chose them.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the document and wait. Do not start a spec or invoke another skill.

## Before writing

Check that you know the business goal, the consumers, the sources, and the freshness needed. If any of these is missing, ask in one numbered round, giving a recommended answer with each question. If the user would rather proceed, write the document and carry the gaps as open questions.

## Document

Use the sections that apply. A small automation is half a page.

```markdown
# Requirements: [name]

## 1. Problem and objective
- Current pain:
- Outcome wanted:
- Success measures: (measurable, for example "matches the manual report to the cent" or "available by 08:00 local time")

## 2. Consumers and use
- Who or what consumes the output:
- How it is consumed:
- Freshness: business cut-off and timezone, time the output is needed, longest tolerable delay and what breaks beyond it

## 3. Sources
| Source | Owner | Entities | How it changes | Volume and peak |
| :--- | :--- | :--- | :--- | :--- |

## 4. Business rules
- Output grain: what one record of the deliverable represents
- Matching rules: how records from different sources are tied together
- Definitions and calculations:
- Exclusions: (voids, test records, deleted records)
- History required:

## 5. Sensitivity and access
- Classification:
- Who may see raw data, and who may see the output:
- Retention:

## 6. Out of scope

## 7. Open questions
| ID | Question | Owner | Impact if unresolved | Status |
| :--- | :--- | :--- | :--- | :--- |
```

## Finishing

Present the document and list the open questions that block design.
