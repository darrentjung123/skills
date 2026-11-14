---
name: improve-architecture
description: "Scan existing pipelines for structural friction, report the deepening opportunities visually, then interview through the chosen one."
disable-model-invocation: true
---

# improve-architecture

Find where the structure of an existing data estate makes work harder than it needs to be, and propose **deepening opportunities**: changes that put more behaviour behind a smaller contract. The aims are that one engineer can change a thing in one place, test it without production, and understand it without opening five tools.

Read `references/vocabulary.md` before starting. Use its terms exactly (**module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**) in every suggestion. Consistent language is what makes the candidates comparable.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Respect what is already decided.** If the project has a glossary or decision records, read them first. Use the glossary's names for things. Raise a candidate that contradicts a recorded decision only when the friction is bad enough to justify reopening it, and say so on the candidate.
- **Leaving it alone is a valid answer.** Restructuring data pipelines costs more than restructuring code, because data has history and consumers. Do not propose a change whose cutover costs more than the friction it removes, and do not deepen something that is about to be retired.
- **Stop when done.** No restructuring happens until the user asks for it. Do not invoke another skill.

## 1. Scope before scanning

Deepening pays back when the thing is changed again, so look where change and pain concentrate.

- If the user named an area or a pain point, start there.
- Otherwise find the hot spots from whatever history exists: version control, change tickets, failure and incident records, runs that need manual intervention, jobs whose duration keeps growing. If nothing stands out, widen the net.
- Skip anything scheduled for replacement.
- If the area is cluttered with things nothing uses, say so and recommend a cleanup pass first. Deepening something that should be deleted is wasted work.

## 2. Explore

Work from whatever the estate is made of: repositories, exported job and flow definitions, database object definitions, schedules, run history, report definitions, documentation. Much of a data estate lives outside version control, so state which places you examined and which you could not reach. If the environment supports sub-agents, use one with a fresh context for the walk.

Explore without a fixed checklist and note where you meet friction:

- Where is the same business rule implemented in more than one place, such as several reports, flows, or queries each computing the same measure?
- Where does understanding one number mean following it through several tools?
- Which hops only copy data onward and add nothing?
- Where do consumers read internal or intermediate objects instead of a published output?
- Where does one job depend on another only through schedule timing?
- Which logic can only be run against production, with no way to feed it a fixed input?
- Where is state, configuration, or a credential duplicated across jobs?
- What exists that nothing reads?

Apply the **deletion test** to anything that looks shallow. If deleting it makes complexity vanish, it was a pass-through. If the complexity reappears in everything that used it, it was earning its place.

## 3. Report

Present the candidates as a visual report. See `references/report.md` for the format. Each candidate is a card with:

- **Where:** the pipelines and objects involved
- **Problem:** the friction, in one sentence
- **Change:** what would be different, in plain language
- **Wins:** stated as locality, leverage, or testability
- **Cutover cost:** consumers affected, whether a parallel run is needed, what history has to be rebuilt
- **Before and after diagram**
- **Strength:** `Strong`, `Worth exploring`, or `Speculative`

End with a top recommendation: the one to do first and why. If nothing clears the bar, say so.

Do not design the new contracts yet. Ask the user which candidate they want to explore.

## 4. Interview

Once the user picks a candidate, interview them to settle its design. Work in rounds. Each round asks every question whose prerequisites are settled, numbered, each with your recommended answer on its own line and worded so that "yes" accepts it. Look facts up yourself and put only decisions to the user.

Cover: the constraints, the dependencies and their category (see the vocabulary reference), the shape of the deepened module and its contract, what sits behind the seam, how it will be tested with fixed inputs, how consumers move across, and what gets deleted afterwards.

As decisions firm up:

- If the deepened module is named after a concept the glossary lacks, or a fuzzy term gets sharpened, offer the glossary entry.
- If the user rejects the candidate for a reason a future review would need to know, offer to draft a decision record so it is not proposed again. Skip this for passing reasons such as "not now".
- If the user wants alternatives, design the contract two or three clearly different ways (smallest possible contract, most flexible, easiest for the most common consumer), compare them on depth, locality, and seam placement, and say which you would choose.

Finish with a summary of the decisions and stop.
