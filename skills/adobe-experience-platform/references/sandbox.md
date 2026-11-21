# Sandbox Service

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Sandbox API

*Adobe Experience Platform provides virtual sandbox environments which provide isolation and access control for Platform integrations. Use sandboxes for application lifecycle management, project management, and to build customized development ecosystems. Use sandbox tooling to seamlessly export and import sandbox configurations between sandboxes through the use of packages. - **Related documentation**: - [Sandbox docu...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/sandbox

### `GET /data/foundation/sandbox-management/` — List available sandboxes

Use this endpoint to retrieve a list of available sandboxes for the current user.

**`Accept`:** `application/json`

### `GET /data/foundation/sandbox-management/sandboxTypes` — List all supported sandbox types

Use this endpoint to list your organization's supported sandbox types.

**`Accept`:** `application/json`

### `GET /data/foundation/sandbox-management/sandboxes` — List sandboxes

Use this endpoint to list all the sandboxes that belong to your organization.

**Query parameters:**
- `property` — Regex used to filter objects in the response. For example: "property=name==test."
- `orderBy` — Parameter used to identify a property to order listed responses by, including sort direction ("asc:" for ascending, "desc:" for descending). For example, "orderBy=asc:created,updated".

**`Accept`:** `application/json`

### `GET /data/foundation/sandbox-management/sandboxes/{sandboxName}` — Retrieve a sandbox

Use this endpoint to retrieve a sandbox by name.

**Path parameters:**
- `sandboxName` **(required)** — The name of a sandbox, used as an identifier.

**`Accept`:** `application/json`

### `GET /data/foundation/exim/packages` — List packages

Use this endpoint to list all packages. Make use of the query parameters to filter the list of returned packages.

**Query parameters:**
- `limit` — The maximum number of records to be returned in the response. The default limit is 20.
- `start` — The start of where a sub-setted list of items should begin.
- `orderBy` — Parameter used to identify a property to order listed responses by, including sort direction ("asc:" for ascending, "desc:" for descending). For example, "orderBy=asc:created,updated".
- `status` — The status of the package. This value can be `DRAFT`, `PUBLISHED`, `PUBLISH_IN_PROGRESS`, or `PUBLISH_FAILED`.

### `GET /data/foundation/exim/packages/jobs` — List export/import jobs

Use this endpoint to retrieve all current export/import jobs. Make use of the query parameters to filter the list of returned packages.

**Query parameters:**
- `limit` — The maximum number of records to be returned in the response. The default limit is 20.
- `start` — The start of where a sub-setted list of items should begin.
- `orderBy` — Parameter used to identify a property to order listed responses by, including sort direction ("asc:" for ascending, "desc:" for descending). For example, "orderBy=asc:created,updated".
- `status` — The status of the package. This value can be `DRAFT`, `PUBLISHED`, `PUBLISH_IN_PROGRESS`, or `PUBLISH_FAILED`.
- `jobType` — The type of job. This value can be `NEW`, `RESUME`, or `ROLLBACK`.
- `jobStatus` — The status of the job. This value can be `PENDING`, `IN_PROGRESS`, `SUCCESS`, `FAILED`, or `CANCELLED`.
- `requestType` — The type of request. This value can be `EXPORT`, `IMPORT`, or `COPY`.

### `GET /data/foundation/exim/packages/{packageID}` — Look up a package

Use this endpoint to look up an individual package.

**Path parameters:**
- `packageID` **(required)** — The ID of a package.

### `GET /data/foundation/exim/packages/{packageID}/export` — Publish a package

Use this endpoint to publish a package by ID, enabling it to be imported. The package status must be `PARTIAL` or `PUBLISH_FAILED`. If the `packageType` is `PARTIAL` it must contain artifacts.

**Path parameters:**
- `packageID` **(required)** — The ID of a package.

**Query parameters:**
- `expiryPeriod` — This user-specified time period defines the package expiration date (in days) from the time the package was published. This value should not be negative. If no value is specified, the default will be ...

### `GET /data/foundation/exim/packages/{packageID}/import` — Import a package

Use this endpoint to fetch conflicting objects in the specified target sandbox before submitting an import. Conflicting objects represent similar objects that are already present in the target sandbox.

**Path parameters:**
- `packageID` **(required)** — The ID of a package.

**Query parameters:**
- `targetSandbox` **(required)** — Represents the sandbox name where you want to import your artifacts.

### `GET /data/foundation/exim/packages/payload/{packageID}` — Copy package payload

Use this endpoint to copy a package's payload.

**Path parameters:**
- `packageID` **(required)** — The ID of a package.

### `GET /data/foundation/exim/packages/preflight/{packageID}/export` — Check role-based permissions to import all package artifacts

Use this endpoint to check if you have permissions to import package artifacts.

**Path parameters:**
- `packageID` **(required)** — The ID of a package.

**Query parameters:**
- `targetSandbox` **(required)** — Represents the sandbox name where you want to import your artifacts.

### `GET /data/foundation/exim/handshake/list` — List partnership requests

Use this endpoint to list all incoming and outgoing partnership requests and their current status. Currently, ordering is only supported with `createdDate`.

**Query parameters:**
- `limit` — The maximum number of records to be returned in the response. The default limit is 20.
- `start` — The start of where a sub-setted list of items should begin.
- `orderBy` — Parameter used to identify a property to order listed responses by, including sort direction ("asc:" for ascending, "desc:" for descending). For example, "orderBy=asc:created,updated".
- `property` — Regex used to filter objects in the response. For example: "property=name==test."
- `requestType` **(required)** — The type of request. This value can be `INCOMING`, or `OUTGOING`.

### `GET /data/foundation/exim/transfer/{transferID}` — Fetch share request by ID

Use this endpoint to fetch the details of a specified share request.

**Path parameters:**
- `transferID` **(required)** — The ID of the request you want to fetch.

### `GET /data/foundation/exim/transfer/list` — List share requests

Use this endpoint to fetch a list of share requests. Currently, ordering is only supported with `createdDate`.

**Query parameters:**
- `property` — Regex used to filter objects in the response. For example: "property=name==test."
- `start` — The start of where a sub-setted list of items should begin.
- `limit` — The maximum number of records to be returned in the response. The default limit is 20.
- `orderBy` — Parameter used to identify a property to order listed responses by, including sort direction ("asc:" for ascending, "desc:" for descending). For example, "orderBy=asc:created,updated".
- `requestType` **(required)** — The type of request. This value can be `PUBLIC`, or `PRIVATE`.

### `GET /data/foundation/exim/tools/job/{jobID}` — Job details

Use this endpoint to fetch the details of a specific job.

**Path parameters:**
- `jobID` **(required)** — The ID of the job you want to fetch.

