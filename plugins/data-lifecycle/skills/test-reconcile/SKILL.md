---
name: test-reconcile
description: "Design pipeline tests and a cross-system reconciliation that classifies every variance."
disable-model-invocation: true
---

# test-reconcile

Produce the checks that show a pipeline is correct, and the reconciliation that shows two systems agree or explains exactly where they do not.

## Ground rules

- **Stay platform-neutral.** Design in terms of what has to happen, not which product does it. When concrete syntax is needed, write it for the platform and language the user has named. If they have not named one, ask. Never assume a dialect or a vendor.
- **Separate verified from assumed.** Mark anything not confirmed by the user or by evidence you have actually seen as `[assumed]`. An invented specific that reads like a fact is the most damaging thing this skill can produce, because later work gets built on it.
- **Scale to the work.** One small flow needs a fraction of what a new platform feed needs. Leave out what does not apply instead of filling it with boilerplate.
- **Use what already exists.** Take grain, keys, rules, and edge cases from the spec and source profile if they are in the conversation or the files.
- **Test behaviour, not only shape.** Null and uniqueness checks are the minimum. The defects that cost money are quiet ones: a join that multiplies rows, a date that shifts across a cut-off, a retried event counted twice, a refund with the wrong sign, a record that is dropped.
- **Run them when you can.** If you can execute the tests, do so and report the results. If you cannot, deliver them and wait for the user's results. Do not describe unrun tests as passing.
- **Stop when done.** Deliver the suite and wait. Do not invoke another skill.

## Tier 1: edge-case fixtures

A small fixed set of input records with the expected output, covering at least:

1. **Exact replay:** the same record delivered twice. Only one survives.
2. **Out of order:** an older version arriving after a newer one. State does not go backwards.
3. **Cut-off boundary:** records just either side of the business day boundary, in the source timezone and the reporting timezone.
4. **Missing key and negative value:** a record with no match on a join, and a refund or reversal. Nothing is silently dropped and signs are right.

Add the cases specific to this pipeline's rules.

## Tier 2: contract assertions

- **Grain:** the key is unique and never null.
- **Domain and references:** status and type fields hold only expected values, and references resolve.
- **Freshness and volume:** data is no older than the service level allows, and record counts fall within expected bounds.

## Tier 3: idempotency and fan-out

1. **No fan-out:** the record count after each join matches the intended grain, and totals are not inflated by one-to-many matches.
2. **Rerun:** running the pipeline twice on the same input produces no change in counts, totals, or keys.

## Tier 4: cross-system reconciliation

Use when two systems should hold the same numbers.

1. **Summary tie-out** by date, entity, or location: count in each system and the difference, amount in each system and the variance, absolute and as a percentage.
2. **Variance classification.** Every difference goes into exactly one bucket:
   - `MATCHED`: within the agreed tolerance.
   - `MISSING_IN_TARGET`: dropped, failed, or filtered out.
   - `MISSING_IN_SOURCE`: created directly in the target.
   - `TIMING`: present in both with the same amount, on adjacent dates because of timezone or cut-off.
   - `AMOUNT_MISMATCH`: same record, different amount.
3. **Record-level drill-down:** the identifiers and fields of the mismatched records only, so someone can resolve them one by one.

Ask what tolerance the business accepts instead of choosing one. If you have to proceed without an answer, state the tolerance you used and mark it `[assumed]`.

## Finishing

Present the suite, say which checks were run and what they showed, and list the ones still to be run.
