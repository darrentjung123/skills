---
name: plan
description: "Break an approved spec into small vertical slices, each with a verification gate."
disable-model-invocation: true
---

# plan

Turn an approved spec into an ordered set of small tasks that can each be built and checked on their own.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Plan from the spec in the conversation or the files. If there is no spec, plan from what the user has described and list what the plan is assuming.
- **No production code.** The plan is the route. The build happens one slice at a time afterwards.
- **Slice vertically.** Get a thin slice of real data flowing end to end early. It proves access, permissions, and grain before any effort goes into breadth. Building one whole layer at a time hides those problems until the end.
- **Every slice has a gate.** A gate is an exact check, such as a command, a query, or a test input, with its expected result. A gate has passed only when the output of that check has been seen. "It should work" is not a pass.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the plan and wait. Do not start building or invoke another skill.

## Plan

Each slice should take roughly 30 to 90 minutes to build and check. The number of slices follows the work.

```markdown
# Implementation plan: [name]

## 1. Prerequisites
- [ ] Access and credentials confirmed for source and target
- [ ] A current sample of the source matches the spec
- [ ] A development environment exists that cannot affect production

## 2. Slices

### Slice 1: [name]
- Objective:
- Create or change:
- Steps:
- Gate (must pass before slice 2):
  - Check to run:
  - Expected result:

### Slice 2: [name]
...

## 3. Cutover
- History load:
- Smoke test after release:
- Rollback procedure and how long it takes:
```

A common progression, to adapt and not to copy:

1. Land one entity in raw form with load metadata (when it was loaded, which run loaded it).
2. Clean, type, and deduplicate it, with contract checks.
3. Add the business logic and prove that a second run changes nothing.
4. Add scheduling, failure handling, permissions, and monitoring.
5. Widen to the remaining entities.

## Finishing

Present the plan and ask which slice to start with, or what to adjust.
