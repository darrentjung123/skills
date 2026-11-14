# Data lifecycle skills

Twelve platform-neutral skills for building and running data pipelines and integrations end to end, written for Claude Code. They cover the framework of the work: discovery, design, build, verification, and day-two operations. They contain no product, vendor, or language specifics. Each skill asks which platform you are on when it needs concrete syntax, and platform or language skills can be added alongside later.

## The skills

| Stage | Skill | Produces |
| :--- | :--- | :--- |
| Discover | `/profile` | Source profile: grain, keys, field audit, traps |
| Discover | `/requirements` | Requirements document for stakeholder sign-off |
| Design | `/spec` | Technical specification, with deeper references for orchestration and security |
| Design | `/plan` | Vertical-slice implementation plan with verification gates |
| Build | `/build` | One slice implemented to the code standards, with its gate run |
| Verify | `/test-reconcile` | Edge-case fixtures, contract assertions, idempotency proofs, reconciliation |
| Verify | `/review` | Severity-ranked review, including a check for generated-code residue |
| Operate | `/impact` | What breaks if a table, field, job, or interface changes |
| Operate | `/incident` | Failed run or wrong number, from symptom to root cause and repair |
| Operate | `/migrate` | Migration plan: behaviour capture, parallel run, cutover, rollback |
| Maintain | `/cleanup` | Dead weight found and removed in safe tiers |
| Maintain | `/improve-architecture` | Visual report of structural friction, then a design interview on the chosen candidate |

## Which ones to use

- **Small job** (one flow, one function, one feed): grill it, then `/spec`, `/build`, `/review`.
- **New pipeline:** grill it, then `/profile`, `/requirements`, `/spec`, `/plan`, then `/build` slice by slice, `/test-reconcile`, `/review`.
- **Changing something that exists:** `/impact` first.
- **Something broke:** `/incident`.
- **Moving platforms or replacing an implementation:** `/migrate`.
- **An inherited or overgrown codebase:** `/cleanup` first, then `/improve-architecture`. Cleanup removes. Architecture restructures. Doing them in that order avoids restructuring something that should have been deleted.

## Grilling

This pack has no interview skill of its own. Use Matt Pocock's `grill-me`, which is generic and works as well for a single view or a semantic model as for a pipeline. In Claude Code:

```zsh
claude plugin install mattpocock-skills@claude-plugins-official
```

That installs his whole set as a self-updating plugin, including the `grilling` skill that `grill-me` depends on.

His `grill-me` writes nothing down, and `/requirements` and `/spec` read a grill summary when one exists. The grilling block in `claude-md-snippet.md` makes a session end with that summary, and adds a coverage check that applies only when the subject is a pipeline or integration.

## How they work together

Every skill is manual-only (`disable-model-invocation: true`). It runs when you type its name, finishes with its output, and stops. None of them starts another.

They do share information. Each skill reads the outputs of earlier ones from the conversation or the repository, and offers to save its own output alongside the project's documentation so a later session can pick it up.

Three rules appear in every skill:

1. **Platform-neutral.** Design is stated as what must happen. Syntax is written only for a platform you have named.
2. **Verified versus assumed.** Anything not confirmed by you or by evidence is marked `[assumed]`.
3. **Scale to the work.** Sections that do not apply are left out.

## Code standards

`/build` writes to `plugins/data-lifecycle/skills/build/references/code-standards.md` and rereads its own diff against the residue list at the end of that file. `/review` checks for the same residue afterwards.

Because the skills run only when invoked, those standards do not apply to code Claude Code writes outside `/build`. `claude-md-snippet.md` holds a short always-on version to paste into `~/.claude/CLAUDE.md` if you want that.

## Install

**Linked from a clone (recommended).** Keeps one copy, and `git pull` updates every project at once.

```zsh
git clone <your-repo-url> ~/skills/data-lifecycle-skills
zsh ~/skills/data-lifecycle-skills/scripts/install.zsh
```

This links each skill into `~/.claude/skills/`. It skips any skill name that already exists there as a real folder and tells you, so an existing skill of the same name is not overwritten unless you pass `--force`. Use `--copy` to copy instead of link.

**As a plugin.** Add the repository as a plugin marketplace in Claude Code and install `data-lifecycle`. Skills are then namespaced, for example `/data-lifecycle:spec`, which avoids clashes with other packs.

Use one method, not both, or each skill will appear twice.

## Layout

```
.claude-plugin/marketplace.json        marketplace catalogue (plugin install)
plugins/data-lifecycle/
  .claude-plugin/plugin.json           plugin manifest
  skills/<skill>/SKILL.md              the skills
  skills/<skill>/references/           detail a skill loads only when needed
scripts/install.zsh                    links or copies the skills into ~/.claude/skills
claude-md-snippet.md                   optional always-on rules for code and grilling
```

## Notes

- **claude.ai.** These files use a Claude Code frontmatter field that claude.ai uploads reject. To use a skill there, remove the `disable-model-invocation` line and upload that skill's folder as a zip.
- **Short names.** `review`, `plan`, and `build` are common skill names. If one clashes with another pack or a built-in command, install as a plugin to get the namespace, or rename the folder and the `name` field together.

See `CREDITS.md` for the projects these skills draw on.
