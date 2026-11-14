# Security and governance

Detail for section 8 of the spec. Use the parts the pipeline needs, and keep the design small enough for one engineer to maintain.

## Identity and least privilege

- List the exact permissions the job's identity needs for extraction, loading, and orchestration. State what it is denied as well, in particular administrative rights and write access to source systems.
- Use a few functional roles instead of per-object grants:
  - **Loader:** writes to the landing area only.
  - **Transformer:** reads the landing area, writes the cleaned and serving areas.
  - **Reader:** reads the serving area only.
- People and jobs use separate identities.

## Secrets and endpoints

- Secrets live in a managed secret store. They do not appear in code, repositories, plain configuration, or logs.
- State how each secret rotates and what breaks when it expires. Expired credentials are one of the most common causes of silent pipeline failure.
- For an inbound endpoint: verify the sender's signature and reject stale or replayed requests.
- For outbound calls: say how tokens are refreshed.
- State any network restrictions the design relies on.

## Sensitive data

| Field | Sensitivity | Protection in landing | Protection in serving | Who may see it unmasked |
| :--- | :--- | :--- | :--- | :--- |

- The cheapest protection is not ingesting a sensitive field that nobody needs.
- Otherwise mask it, or tokenise it when it is needed as a join key.
- State whether consumers should be limited to a subset of rows, and where that limit is enforced.

## Logs and retention

- Error handlers, quarantine stores, and run histories must not contain personal data, payment details, or authorisation headers. Check failure paths in particular, because they often log the whole input.
- State how long landing data and outputs are kept, how they are purged, and how an erasure request would be honoured.

## Closing checklist

End the section with five to eight pass or fail items specific to this pipeline, for example: no secret in code or configuration, job identity cannot write to the source, sensitive fields masked in serving, failure logs checked for personal data, retention configured.
