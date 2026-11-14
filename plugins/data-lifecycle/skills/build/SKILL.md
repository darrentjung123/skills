---
name: build
description: "Implement one slice of the plan to the pack's code standards and prove it works."
disable-model-invocation: true
---

# build

Implement one slice of work and show that it works. The aim is code that is correct, small, and reads as if the person who maintains the rest of the codebase wrote it.

Read `references/code-standards.md` before writing anything. It is short, and the self-check at the end of this skill depends on it.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Build from the plan and spec if they are in the conversation or the repository. If there is no plan, state the slice and its gate in two lines and confirm them before writing.
- **One slice at a time.** Build the slice that was asked for and nothing beside it. Do not refactor neighbouring code, add a dependency, or widen the scope without asking. Note anything you would change and leave it.
- **Stop when done.** Report and wait. Do not start the next slice, commit, deploy, or invoke another skill unless asked.

## 1. Read before writing

- Read the code around the change: its structure, naming, error handling, tests, and how it is configured and deployed. The new code follows those conventions, including ones you would not have chosen.
- Look for something that already does part of the job. Reuse it instead of writing a second version.
- Identify the gate: the exact check that proves this slice works, and its expected result.

## 2. Write the smallest change that passes the gate

- Keep logic separate from input and output, so the logic can be run on a fixed input without touching a real system.
- Write for the case in front of you. Shared helpers, options, and extension points wait for a second real use.
- Follow the standards reference for comments, validation, error handling, configuration, and infrastructure definitions.

## 3. Verify

- Run the gate and show its output. Then run whatever checks the project already has, such as its linter and tests.
- If something fails, fix the cause. Do not weaken the check, skip the test, or catch the error to make it pass.
- If you cannot run the gate here, say so and give the exact command for the user to run. A slice is not done until the gate's output has been seen.

## 4. Self-check the diff

Reread your own diff against the residue list at the end of the standards reference and remove what it catches. This is the step that keeps generated-code habits out of the result, so do it every time, including on small changes.

## 5. Report

Keep it short:

1. What changed, by file.
2. The gate and its result.
3. Anything assumed, deferred, or noticed but left alone.
4. The next slice, if there is a plan.
