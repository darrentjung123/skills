---
name: incident
description: "Work a failed run or a wrong number from symptom to root cause and repair."
disable-model-invocation: true
---

# incident

Take a failure from the first symptom to a root cause, a workaround, and a log entry. This skill proposes and drafts. It does not fix, rerun, or send anything without the user's say-so, because a rerun can duplicate data or destroy the evidence, and a message once sent cannot be recalled.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Evidence before conclusions.** A root cause is stated only when something you have seen supports it: an error, a log line, a before-and-after comparison, a reproduction. Until then it is a hypothesis and is labelled as one.
- **One hypothesis at a time.** Rank the candidates, name the single check that best separates them, and run or request that check. Changing several things at once leaves nobody sure which one mattered.
- **Keep the output where the next step can find it.** In a repository, offer to save the document alongside the project's other documentation, asking where if there is no obvious place. A later session starts without this conversation, and the other skills read these files.
- **Stop when done.** Deliver the write-up and wait. Do not apply a fix or invoke another skill.

## Steps

1. **What failed.** For a failed run: the job, the step, the error, the time. For wrong data: which number, what it should be, what it is, and since when.
2. **Status.** Severity, who is affected, and whether bad data is still flowing or already published. If it is, recommend how to contain it first (pause, hold the publish step, flag the report) before any diagnosis.
3. **Timeline.** The run stage by stage, with what each stage read, wrote, and checked.
4. **Root cause.** Ask what changed: the source's data or structure, volume, code, configuration, permissions, an expired credential, the platform itself, or the schedule. List the hypotheses with the evidence for and against each, and the next check.
5. **Seen before.** Look for the same failure in any incident log or history available, and its known fix.
6. **Workaround.** How consumers get correct data today.
7. **Fix options.** Two options, with the effort for each and a recommendation. Include the data repair: which records or periods need reprocessing, and how the repair will be verified.
8. **Same weakness elsewhere.** Other pipelines that share the cause, and which are safe.
9. **Drafts.** A message to the consumers and one to the source owner if the cause is upstream. An entry for the incident log.

## Output

An **Incident report** with the status and current impact at the top, then one section per step. Mark the root cause as confirmed or as the leading hypothesis.
