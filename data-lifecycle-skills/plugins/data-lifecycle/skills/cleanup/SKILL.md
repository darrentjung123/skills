---
name: cleanup
description: "Audit existing code or pipelines for dead weight, asking whether each thing should exist, then remove it in safe tiers."
disable-model-invocation: true
---

# cleanup

Audit something that already exists and make it smaller. The first question about anything is "should this exist?", and only then "how could it be better?". The usual failure in cleanup work is polishing something that should have been deleted, or adding new structure to something already over-built.

Removal comes before refactoring, and simplification before restructuring. A cleanup that ends with more code than it started with has gone wrong.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **The owner decides what stays.** Present findings before changing anything. Something that looks pointless may be the part the owner values most.
- **Prove it is unused before calling it dead.** Find every reference first. For data objects and jobs, absence from the code is not proof: check usage or run history over a window long enough to include a period end, and say where you could not look.
- **Verify before and after every change.** Know the working state before you start, and confirm it after each removal.
- **Stop when done.** Do not invoke another skill, and do not carry on into restructuring.

## 1. Understand what it is for

Read the documentation, any design or decision records, recent change history, and the dependency list. You are looking for the gap between what the project says it is and what it contains.

## 2. Establish the baseline

Run whatever the project has: build, linter, tests. Record the counts. If any of them already fails, that is the first finding, and it is fixed before anything is removed.

Where there is nothing to run, as with many flows, jobs, and database objects, capture the current outputs so there is something to compare against afterwards.

## 3. Scan and count

Search across the whole thing instead of reading file by file, and report numbers.

- **Dead weight:** files, functions, objects, and jobs that nothing references or runs. Commented-out code. Copies kept beside the original with a suffix such as old, backup, or a version number. Disabled jobs. Unused dependencies. Configuration for tools no longer used. Deployed resources and permissions that nothing uses.
- **Quality signals:** swallowed errors, unresolved to-do notes, very long functions and files, duplicated logic, checks that are disabled or skipped, tests that cannot fail.
- **Scope creep:** features unrelated to the stated purpose, half-finished work, a dependency pulled in for one minor use.
- **Structure:** does the layout match the stated design, do two areas overlap in responsibility, is one file doing several unrelated jobs.

## 4. Question existence

For each major piece: does it serve the stated purpose, is it actually used, was it ever finished? If the answer to any of these is no, it is a removal candidate before it is an improvement candidate.

## 5. Classify

| Tier | What it is | Typical effort |
| :--- | :--- | :--- |
| T1 Safe deletes | Dead code, unused files and objects, abandoned experiments | Minutes |
| T2 Quick fixes | Isolated improvements with no structural effect | Hours |
| T3 Focused refactors | Targeted work on one area | Days |
| T4 Structural changes | Changes that span several areas | Weeks |

Keep the tiers apart. T3 and T4 are listed for the owner and left alone. They are restructuring, which is a separate piece of work with its own design step.

## 6. Agree the scope

Present the findings with their counts, tier by tier, and ask which removals to proceed with and which of the questionable pieces the owner wants to keep.

## 7. Remove, safest first

Work through T1, then T2, one change at a time. After each: build and test, or compare against the captured outputs. If something breaks, put it back and investigate before continuing.

For data objects, jobs, and deployed resources, prefer a reversible step first: disable or rename, wait an agreed period, then delete. Keep the definition somewhere it can be restored from.

## Signs the cleanup has gone wrong

- More is being written than deleted.
- New files or new abstractions are appearing.
- The plan has grown phases that span weeks.
- The owner has not been asked what to keep.
- The baseline was never checked.

## Output

A **Cleanup report**: the baseline, findings by tier with counts, what was removed and the verification result for each, and the T3 and T4 items left for the owner.
