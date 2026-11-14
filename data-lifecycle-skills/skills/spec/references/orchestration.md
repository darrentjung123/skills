# Orchestration and reliability

Detail for section 6 and section 7 of the spec. Use the parts the pipeline needs.

## Triggers and dependencies

- State the trigger type: time-based, event-driven (a pushed message, a file arriving, a queue item), or state-driven (an upstream dataset completing).
- Express dependencies explicitly. A job that runs at a fixed time because the one before it usually finishes by then has a hidden dependency that fails silently on a slow night.
- Draw the dependency flow, showing which steps run in sequence and which in parallel.
- Set the overlap rule. If a run starts while the previous one is still going, it either waits, is skipped, or is prevented. Say which.
- Use one orchestrator where one will do. Each extra scheduling layer is another place where a run can be lost and another thing to check during an incident.

## State and checkpoints

- Say where progress is stored: a timestamp, a cursor, or a manifest of processed files.
- Advance it only after the target write has committed. Advancing first loses data on failure. Advancing after means a failure repeats work, which the idempotency design already has to tolerate.

## Retries, timeouts, and quarantine

| Step | Timeout | Retry policy (count, backoff, jitter) | Retryable errors | Non-retryable errors | Where failures go |
| :--- | :--- | :--- | :--- | :--- | :--- |

- Retry what is transient: throttling, timeouts, temporary unavailability, lock contention.
- Do not retry what will fail the same way again: rejected credentials, malformed input, a contract violation. Route these to quarantine with the original input preserved.
- One bad record should not halt a batch unless correctness requires it. Say which applies.

## Observability

- Log the same fields on every run: run identifier, pipeline name, start and end of the source window, records read, records written, records quarantined, duration.
- Tier the alerts so the urgent channel stays meaningful:
  - **Urgent:** retries exhausted, service level breached, reconciliation failed.
  - **Digest:** transient retries, quarantine count above a threshold.
- Add a check for absence. A trigger that stops firing produces no error, so something has to alert when an expected run has not happened.

## Runbooks

Write each as numbered steps one engineer can follow at night.

1. **Reprocess a date range** without disturbing current runs.
2. **Replay quarantined records** once the cause is fixed.
3. **Stop the pipeline** in under a minute when the source starts sending bad data.
