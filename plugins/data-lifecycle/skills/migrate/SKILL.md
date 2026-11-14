---
name: migrate
description: "Plan a migration: behaviour capture, parallel run, cutover, and rollback."
disable-model-invocation: true
---

# migrate

Plan a move so that consumers either cannot tell it happened, or see only the differences that were chosen on purpose. That standard means capturing what the old implementation really does, including behaviour nobody documented and defects that consumers have come to rely on.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Read any spec, impact analysis, or documentation for the old implementation that is in the conversation or the files. Where the only documentation is the implementation itself, read that.
- **Keep the move and the redesign apart unless there is a reason to combine them.** When logic changes during a platform move, a reconciliation difference could be a migration defect or an intended change, and nobody can tell which. If the user wants both, make each intended change explicit and listed.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the plan and wait. Do not start the migration or invoke another skill.

## Steps

1. **Inventory.** What exists: jobs, logic, schedules, credentials, consumers. Include implicit behaviour: ordering that happens by accident, default values, swallowed errors, manual steps someone performs. Identify what is dead and should not be moved at all.
2. **Behaviour capture.** For each item: inputs, outputs, rules. For each quirk, decide whether to preserve it or fix it deliberately. Deliberate fixes are documented and the consumers are told.
3. **Mapping.** Old to new, item by item. Call out anything with no equivalent on the new side and how the gap is closed.
4. **History.** What history moves, how it is moved, and how it is validated.
5. **Parallel run.** How long old and new run side by side (long enough to include a period end or a peak), what is compared (counts, totals, record level), the tolerance, and who signs off. Classify every difference as a defect in the new, a defect in the old, an intended change, or timing.
6. **Cutover.** The order in which consumers are repointed, any freeze window, the point of no return, and the smoke tests afterwards.
7. **Rollback.** How to go back, how long the old implementation stays runnable, and what happens to data written while the new one was live.
8. **Decommission.** Removing the old jobs, schedules, credentials, and documentation, with a date. Old implementations left running "just in case" become the next undocumented system.

Where there is a lot to move, plan it in waves, starting with the simplest and least risky item so that the method is proven before it matters.

## Output

A **Migration plan** with the inventory and mapping as tables, the parallel-run design, the cutover and rollback steps as numbered runbooks, and the risks ranked.
