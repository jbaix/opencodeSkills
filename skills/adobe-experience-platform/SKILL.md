---
name: adobe-experience-platform
description: Query and inspect Adobe Experience Platform (AEP) resources through the authenticated REST API using GET (curl) calls. Use when the user wants to read data from Adobe Experience Platform / AEP / Adobe I/O — for example list or look up XDM schemas, field groups, classes, data types, descriptors and unions (Schema Registry), datasets, batches and dataset credentials (Catalog / Dataset Service / Data Access), mapping sets (Data Prep), source flows, connections, flow specs and runs (Flow Service), destinations and destination-authoring configs (Destination SDK), identity namespaces, identities, mappings and clusters (Identity Service), merge policies, profile entities, computed attributes, projections and profile system jobs (Real-Time Customer Profile), segment definitions, segment jobs, estimates, previews and export jobs (Segmentation), SQL queries, schedules, query templates and alerts (Query Service), data usage labels, policies and marketing actions (Policy Service / governance), privacy jobs (Privacy Service), audit events (Audit Query), observability metrics, sandboxes and sandbox tooling, Adobe tags companies, properties, rules, libraries, builds, environments, extensions and data elements (Reactor), and Sensei / Data Science Workspace engines, models and ML services. Handles AEP authentication headers (ACCESS_TOKEN, API_KEY, ORG_ID), the x-sandbox-name sandbox header, vendor Accept media types, and pagination. Read-only: GET requests only.
---

# Adobe Experience Platform REST API (read-only)

Help the user explore Adobe Experience Platform by issuing authenticated **GET** requests and
explaining the JSON that comes back. This skill ships an endpoint catalog built from Adobe's
official OpenAPI specs plus the user's Postman collection, and two helper scripts that handle
authentication and the sandbox header.

## Hard rules

1. **GET only.** Never issue POST, PUT, PATCH or DELETE, whatever the user asks. If they want to
   create/update/delete, say the skill is read-only and link the relevant Adobe doc.
2. **Authenticate every call** with `Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`
   and `x-gw-ims-org-id: <ORG_ID>`.
3. **Always confirm the sandbox** for the session unless the user has already named one. Send it
   as `x-sandbox-name: <SANDBOX_NAME>` (Platform services only, never Reactor).
4. **Never invent parameters.** If a required path/query parameter was not provided, ask for it
   (or offer to look it up with another GET).

## Session setup (do this once, before the first call)

### 1. Credentials — ask only if there is no session yet

Check for an existing session first:

```powershell
& "<skill>/scripts/aep-session.ps1" -Show
```

- If it lists an `ACCESS_TOKEN`, `ORG_ID`, `API_KEY` and `SANDBOX`, reuse them. Do **not** ask again.
- If there is no session, ask the user for the three values (they can be copied from Adobe
  Developer Console → the OAuth Server-to-Server credential, or from the "Get credentials" block
  on any developer.adobe.com API reference page):
  - `ACCESS_TOKEN` — a Bearer token (expires after 24 h)
  - `ORG_ID` — the IMS Organization ID (looks like `123ABC@AdobeOrg`)
  - `API_KEY` — the Client ID
- Then store them (this also sets the sandbox if the user already named one):

```powershell
& "<skill>/scripts/aep-session.ps1" -AccessToken "<token>" -OrgId "<org>" -ApiKey "<key>" -Sandbox "<sandbox>"
```

Never echo the token back to the user and never print it in clear text.

### 2. Sandbox — confirm it (unless the user already said which one)

If the user did not mention a sandbox, ask which sandbox to use. To help them choose, list the
org's sandboxes (this endpoint does **not** need the sandbox header):

```powershell
& "<skill>/scripts/aep-get.ps1" -Url "https://platform.adobe.io/data/foundation/sandbox-management/sandboxes" -NoSandbox
```

Show the `name`, `title`, `type` and `state` of each sandbox, then ask the user to pick one.
Save the chosen value:

```powershell
& "<skill>/scripts/aep-session.ps1" -Sandbox "<name>"
```

The sandbox header takes the sandbox **`name`** (for example `prod`), not its title.

### 3. Sanity check (optional)

`GET /data/foundation/schemaregistry/stats` returns the tenant ID and is a good first call to
confirm the credentials work.

## Choosing the right endpoint

Read `references/index.md` and `references/conventions.md` first, then open the service file that
matches the request:

| User wants… | Read |
| --- | --- |
| XDM schemas, field groups, classes, data types, descriptors, unions, sample data, audit log | `references/schema-registry.md` |
| Datasets, batches, dataset credentials, batch previews, dataset files, mapping sets | `references/catalog-and-datasets.md` |
| Identity namespaces, identities, mappings, clusters; profiles, merge policies, entities, computed attributes, projections | `references/identity-and-profile.md` |
| Segment definitions, segment jobs, estimates, previews, schedules, export jobs, search | `references/segmentation.md` |
| SQL queries, schedules, query templates, alerts | `references/query-service.md` |
| Source connections, base connections, connection specs, flows, flow specs, runs | `references/flow-service.md` |
| Destination configurations, destination servers, audience templates, credentials, publishing | `references/destination-authoring.md` |
| Data usage labels, policies, marketing actions, policy evaluation; privacy jobs; audit events; observability metrics; access control roles/policies | `references/governance-and-audit.md` |
| Sandboxes and sandbox tooling (packages, import/export, transfers) | `references/sandbox.md` |
| Adobe Tags / Reactor: companies, properties, rules, data elements, libraries, builds, environments, extensions | `references/reactor.md` |
| Sensei / Data Science Workspace: engines, ML instances, experiments, models, MLServices, insights | `references/sensei-machine-learning.md` |

Each catalog entry gives the full path, the summary, the required path/query parameters and the
`Accept` header. Pick the entry whose summary matches the user's intent; if several match, ask
which one they mean.

## Running a call

Use the helper script — it reads the session credentials, adds the auth + sandbox headers and
always performs a GET:

```powershell
& "<skill>/scripts/aep-get.ps1" -Url "https://platform.adobe.io/data/foundation/schemaregistry/tenant/schemas?limit=10" -Accept "application/vnd.adobe.xed-id+json"
```

Useful switches:

- `-Accept "<media type>"` — override the `Accept` header (default `application/json`).
- `-NoSandbox` — do not send `x-sandbox-name` (use for sandbox-management endpoints).
- `-Sandbox "<name>"` — one-off sandbox override.
- `-IncludeHeaders` — include the HTTP response headers in the output.
- `-DryRun` — print the curl command that would run, with secrets masked, without sending it.

The script runs `curl.exe` under the hood, so it satisfies "execute the curl calls". If you ever
need to run curl directly (script unavailable), use `curl.exe` explicitly — in Windows PowerShell
the bare `curl` alias is `Invoke-WebRequest` and will not accept these flags:

```powershell
curl.exe -sS -X GET "https://platform.adobe.io/data/foundation/catalog/dataSets?limit=5" `
  -H "Authorization: Bearer <ACCESS_TOKEN>" `
  -H "x-api-key: <API_KEY>" `
  -H "x-gw-ims-org-id: <ORG_ID>" `
  -H "x-sandbox-name: <SANDBOX>" `
  -H "Accept: application/json"
```

## Asking for missing parameters

Before every call, verify the endpoint's required parameters (they are marked **(required)** in
the catalog):

- Missing required **path** parameter (an ID, a namespace, a field name, …) → ask the user.
- If the ID is discoverable with another GET, offer to find it first (for example, list datasets
  to get a `DATASET_ID`, list segment definitions to get a `SEGMENT_ID`).
- Missing required **query** parameter → ask for it.
- If a service exposes several response representations and the user's intent depends on it
  (typically Schema Registry), ask which `Accept` representation they want.

## Reporting results

- Summarise the JSON in a small table or bullet list; do not dump huge payloads verbatim.
- If the response is paginated, mention how to get the next page (the relevant parameter:
  `start`, `continuationToken` or `page[number]`).
- On an error, report the HTTP status and the `title`/`detail` from the body, and suggest the fix
  (expired token → new `ACCESS_TOKEN`; `403` → permissions or wrong sandbox; `404` → wrong ID or
  sandbox).

## Housekeeping

- Credentials live in a JSON file in the OS temp folder (`%TEMP%\opencode\aep-session.json`) so
  they survive for the whole session. Clear them when the user is done:

```powershell
& "<skill>/scripts/aep-session.ps1" -Clear
```

- `<skill>` is this skill's directory
  (`.opencode/skills/adobe-experience-platform`).
