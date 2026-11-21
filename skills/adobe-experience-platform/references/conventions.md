# Adobe Experience Platform REST API — shared conventions

Read this once per session. Every endpoint catalog in this skill assumes these rules.

## Base hosts

| Service group | Host |
| --- | --- |
| All Platform services | `https://platform.adobe.io` |
| Reactor API (Tags) | `https://reactor.adobe.io` |

Platform services live under a service base path, for example
`https://platform.adobe.io/data/foundation/schemaregistry`, `.../data/foundation/catalog`,
`.../data/core/ups`, `.../data/foundation/flowservice`. The full path for each endpoint is
shown in the catalog headings, so you can copy it verbatim.

Adobe also exposes a staging environment (`platform-stage.adobe.io`) for some services. Use it
only if the user asks for it.

## Required headers

Every request must send these three authentication headers:

| Header | Value |
| --- | --- |
| `Authorization` | `Bearer <ACCESS_TOKEN>` |
| `x-api-key` | `<API_KEY>` |
| `x-gw-ims-org-id` | `<ORG_ID>` |

`{ACCESS_TOKEN}` expires after 24 hours. If a call returns `401`, the token is missing, expired
or malformed — ask the user for a fresh token.

## Sandbox header

Almost all Platform resources are isolated per sandbox, so most Platform endpoints also require:

| Header | Value |
| --- | --- |
| `x-sandbox-name` | `<SANDBOX_NAME>` (the sandbox `name`, e.g. `prod`, `dev`) |

Exceptions / notes:

- The Reactor API (`reactor.adobe.io`) does **not** use `x-sandbox-name`.
- The sandbox-management endpoints (`/data/foundation/sandbox-management/...`) list sandboxes
  across the org and do not need the header. Use them to help the user pick a sandbox:
  `GET /data/foundation/sandbox-management/sandboxes`.
- The sandbox value must be the sandbox **`name`**, not its `title`.

## `Accept` header (response representation)

Platform APIs use content negotiation. The default is `application/json`, but several services
require a vendor media type to control the shape/version of the response:

| Service | Typical `Accept` values |
| --- | --- |
| Schema Registry | `application/vnd.adobe.xed-id+json` (summary list), `application/vnd.adobe.xed-full+json` (full definition), `application/vnd.adobe.xed+json` (full, with `$ref`s) |
| Identity Service | `application/vnd.adobe.identity+json;version=1.2` |
| Sensei (Data Science Workspace) | `application/vnd.adobe.platform.sensei+json;profile=<resource>` |
| Profile edge projections | `application/vnd.adobe.platform.projectionConfig+json; version=1`, `...projectionConfigList+json`, `...projectionDestination+json`, `...projectionDestinationList+json` |
| Reactor API | `application/vnd.api+json;revision=1` |
| Everything else | `application/json` |

The catalog lists the exact `Accept` value for each endpoint. When an endpoint offers several
representations and the user cares about the level of detail (for example, Schema Registry),
ask which representation they want instead of guessing.

## Pagination

Pagination style depends on the service:

- **Catalog, Query Service, Segmentation, Privacy, Sandbox, Profile** — offset based:
  `start` (0-based offset) + `limit`, usually with `orderBy`/`orderby`. Catalog responses also
  return `_links.next.href` and a `_page` object.
- **Flow Service** — `limit` + `orderby` + `continuationToken`; pass `count=false` to omit the
  total count for speed. Responses include `_links.next`.
- **Reactor API** — `page[size]` + `page[number]` (1-based); responses include `meta.pagination`.

When listing many resources, request a small `limit` first, show the result, and page on demand
rather than pulling everything at once.

## Response codes and error handling

| Code | Meaning | What to do |
| --- | --- | --- |
| `200` | OK | Parse and summarise the JSON. |
| `400` | Bad request | A parameter is malformed or missing — re-read the endpoint's parameters and fix. |
| `401` | Unauthorized | Token missing/expired/invalid — ask the user for a new `ACCESS_TOKEN`. |
| `403` | Forbidden | Valid credentials but missing ABAC permissions, or wrong sandbox. Tell the user which permission/sandbox is likely at fault. |
| `404` | Not found | Wrong ID or the resource does not exist in the selected sandbox. |
| `429` | Too many requests | Back off and retry later. |
| `5xx` | Server error | Transient; retry once, then report. |

Error bodies are usually JSON: `{ "status": ..., "title": "...", "type": "...", "detail": "..." }`.
Quote the `title`/`detail` when reporting a failure.

## GET-only rule (hard constraint of this skill)

This skill may only issue **GET** requests. Never send POST, PUT, PATCH or DELETE, even if the
user asks to create/update/delete a resource. If asked, explain that this skill is read-only and
point the user to the corresponding write operation in the Adobe documentation.

## Reading values the user did not give you

Before calling an endpoint, check its **Path parameters** and **Query parameters** in the catalog:

- A parameter marked **(required)** that you do not have must be asked for. Do not invent IDs.
- If a required value can be discovered with another GET (for example, list datasets to find a
  `DATASET_ID`), offer to look it up first.
- Optional query parameters: only add them when they serve the user's request.
