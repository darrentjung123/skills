---
name: impact
description: "Map what depends on a table, field, job, or interface before changing it."
disable-model-invocation: true
---

# impact

Answer "if I change this, what breaks?" before the change is made. This skill never makes the change.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Find dependencies, do not recall them.** A dependency counts when it is found in a definition, in code, or in a log. Search every place logic can live: code repositories, database objects, orchestrator and job definitions, report and dashboard definitions, low-code flows, exports, and spreadsheets with live connections.
- **Say where you could not look.** "Nothing found in the places searched" is a different statement from "nothing depends on it". List the places you had no access to, because that is where the surprise will come from.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the analysis and wait. Do not make the change or invoke another skill.

## Steps

1. **Name the thing.** The table, field, job, or interface to change, and the change intended: rename, retype, remove, change of meaning, change of timing.
2. **Upstream.** What it is built from, stage by stage.
3. **Downstream.** Every dataset, job, report, export, and integration that reads it, with where each reference was found.
4. **Consumers.** Who actually used the downstream outputs recently, from usage or query logs where they exist. A report nobody has opened in a year carries a different risk from one opened daily.
5. **Coverage.** The checks and tests that cover it, and which of them the change will break.
6. **Blast radius in numbers.** Count of datasets, jobs, reports, and consumers affected.
7. **Safe order.** What to change first, how old and new coexist during the change (for example, add the new alongside the old, move consumers across, then remove the old), what to compare before and after, and who to tell.
8. **Unknowns.** Dependencies that cannot be ruled out, and the check that would settle each one.

## Output

An **Impact analysis** with the blast-radius numbers first, then a dependency diagram with the changed item marked, the lists behind it, the safe order, and the unknowns.
