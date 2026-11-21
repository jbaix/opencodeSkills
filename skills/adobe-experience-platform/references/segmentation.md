# Segmentation Service

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Segmentation Service API

*Adobe Experience Platform Segmentation Service provides a user interface and RESTful API that allows you to create audiences through segment definitions or other sources from your Real-Time Customer Profile data. These audiences are centrally configured and maintained on Platform, and are readily accessible by any Adobe solution. Use the Segmentation Service API to programmatically integrate the service's various fun...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/segmentation

### `GET /data/core/ups/audiences` — List audiences

**Query parameters:**
- `start` — A query parameter that specifies the starting offset for the audiences returned.
- `limit` — A query parameter that specifies the total number of audiences returned per page.
- `sort` — A query parameter that specifies the field to sort the results by. This is written in the format `[attributeName]:[desc/asc]`
- `property` — A query parameter that specifies which audiences to return. The audiences returned must **exactly** match the attribute value given. This is written in the format `property=[attributeName]==[attribute...
- `name` — A query parameter that filters for audiences that contain the string in the name. This value is case **insensitive**.
- `description` — A query parameter that filters for audiences that contain the string in the description. This value is case **insensitive**.
- `entityType` — A query parameter that lets you filter the type of audience you're looking for.

### `GET /data/core/ups/audiences/{AUDIENCE_ID}` — Retrieve an audience

**Path parameters:**
- `AUDIENCE_ID` **(required)** — The ID of the audience you want to retrieve.

### `GET /data/core/ups/export/jobs` — List export jobs

**Query parameters:**
- `limit` — Limit the number of export jobs returned in the list.
- `offset` — Offset the page of results returned, ordered by created time of resource.
- `status` — Filter the export jobs returned by job status.

**`Accept`:** `application/json`

### `GET /data/core/ups/export/jobs/{EXPORT_JOB_ID}` — Retrieve an export job

**Path parameters:**
- `EXPORT_JOB_ID` **(required)** — The ID of the export job you want to retrieve.

**`Accept`:** `application/json`

### `GET /data/core/ups/segment/definitions` — List segment definitions

**Query parameters:**
- `start` — The page offset, as per created time of resource.
- `limit` — The maximum size of the page.
- `page` — The page number.
- `sort` — The parameters used to sort the results.

**`Accept`:** `application/json`

### `GET /data/core/ups/segment/definitions/{SEGMENT_ID}` — Retrieve a segment definition

**Path parameters:**
- `SEGMENT_ID` **(required)** — The ID of the segment definition.

**`Accept`:** `application/json`

### `GET /data/core/ups/segment/jobs` — List all segment job requests

**Query parameters:**
- `snapshot.name` — The snapshot name.
- `start` — The page offset, as per the created time of the resource.
- `limit` — The maximum number of segment jobs retrieved per page.
- `status` — The job status.
- `sort` — Used to order the segment jobs. Is written in the format [attributeName]:[desc|asc]
- `property` — Used to get exact matches within an attribute in the segment job. Is written in the format [arrayTypeAttributeName]~[objectKey]==[value]

**`Accept`:** `application/json`

### `GET /data/core/ups/segment/jobs/{SEGMENT_JOB_ID}` — Retrieve a segment job request

**Path parameters:**
- `SEGMENT_JOB_ID` **(required)** — The ID of the segment job request.

**`Accept`:** `application/json`

### `GET /data/core/ups/preview/{PREVIEW_ID}` — Retrieve the results of a preview job

**Path parameters:**
- `PREVIEW_ID` **(required)** — The ID of the preview job.

**Query parameters:**
- `offset` — The offset of the page.
- `limit` — The number of entries that should be present on a page. If not specified, this value will be 1000.

**`Accept`:** `application/json`

### `GET /data/core/ups/estimate/{ESTIMATE_ID}` — Retrieve the results of an estimate job

**Path parameters:**
- `ESTIMATE_ID` **(required)** — The ID of the estimate job.

**`Accept`:** `application/json`

### `GET /data/core/ups/config/schedules` — List schedules

**Query parameters:**
- `start` — Return results from a specific page offset. For example, `start=3`.
- `limit` — Limit response to a specific number of objects. Must be a positive number. For example, `limit=10`

**`Accept`:** `application/json`

### `GET /data/core/ups/config/schedules/{SCHEDULE_ID}` — Retrieve a schedule

The scheduler is updated periodically (approximately every 30 minutes), so changes to a schedule may not go into effect immediately.

**Path parameters:**
- `SCHEDULE_ID` **(required)** — The ID of the schedule against which the operation is being performed.

**`Accept`:** `application/json`

### `GET /data/core/ups/search/namespaces` — List search count results

This endpoint is used to retrieve a list of search count results, which is queried across all namespaces.

**Query parameters:**
- `schema.name` **(required)** — The schema class value associated with the search objects. Currently, only `_xdm.context.segmentdefinition` is supported.
- `s` — The search query, based on the Lucene query syntax.

**`Accept`:** `application/json`

### `GET /data/core/ups/search/entities` — List full-text indexed objects

This endpoint retrieves a list of all full text indexed objects contained within a namespace.

**Query parameters:**
- `schemaClass` **(required)** — The schema class value associated with the search objects. Currently, only `_xdm.context.segmentdefinition` is supported.
- `namespace` **(required)** — The namespace you want to search within.
- `s` — The search query, based on the [Lucene query syntax](https://docs.microsoft.com/en-us/azure/search/query-lucene-syntax).
- `entityId` — The ID of the folder you want to search for external segment definitions in.
- `limit` — The number of search results to return per page. The maximum is 50.
- `page` — The offset of the page. The first page starts at 0.

**`Accept`:** `application/json`

### `GET /data/core/ups/search/taxonomy` — Retrieve a search object's taxonomic information

Show the search object's organization

**Query parameters:**
- `schema.name` **(required)** — The name of the schema being searched.
- `namespace` **(required)** — namespace
- `entityId` **(required)** — The ID of the object you want to get structural information about.

**`Accept`:** `application/json`

