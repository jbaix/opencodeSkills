# Query Service

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Query Service API

*Use the Adobe Experience Platform Query Service API to query Platform data with standard SQL. With this serverless tool, you can join any datasets in the [Experience Platform Data Lake](https://experienceleague.adobe.com/docs/experience-platform/landing/license/data-management-best-practices.html#understanding-adobe-experience-platform-data-storage) and capture the query results as a new dataset for use in reporting,...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/query-service

### `GET /data/foundation/query/connection_parameters` — List connection parameters

This request lists the connection parameters used for the interactive interface.

**`Accept`:** `application/json`

### `GET /data/foundation/query/queries` — List queries

This request provides a list of queries for your organization.

**Query parameters:**
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `limit` — Restrict the maximum number of records that should be returned for a given request.
- `start` — The timestamp used with `orderby` to order the returned results.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. The examples below are given with unsafe HTML characters for clarity, but all content MUST be HTML escaped. The following l...
- `excludeSoftDeleted` — Whether to include any queries that have been soft deleted. Defaults to true. Soft-deleting stops the query from being returned on GET requests to the `/queries` endpoint but does not delete it from t...
- `excludeHidden` — Whether to include any low-level queries issued as part of the Postgres protocol that were not user driven. Examples include CURSOR definitions, FETCH, and Metadata queries. `true` is the default valu...
- `isPrevLink` — `isPrevLink` is used in pagination. Results are sorted using the `created` timestamp and the `orderby` property. When navigating pages of results, `isPrevLink` is set to true when paging backwards. It...

**`Accept`:** `application/json`

### `GET /data/foundation/query/queries/{queryid}` — Retrieve a query

This endpoint provides the query information that relates to the query ID provided in the request.

**Path parameters:**
- `queryid` **(required)** — The query ID for the resource that you want to retrieve.

**`Accept`:** `application/json`

### `GET /data/foundation/query/schedules` — List schedules

This request provides a list of all query schedules for your organization.

**Query parameters:**
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `limit` — Restrict the maximum number of records that should be returned for a given request.
- `start` — The timestamp used with `orderby` to order the returned results.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. Properties that allow filtering with all operators: `created` The list of supported operators: `>` (greater than) `<` (less...

**`Accept`:** `application/json`

### `GET /data/foundation/query/schedules/{schedulesId}` — Retrieve a schedule

This request lists the details for the schedule ID provided in the request path. It returns schedule information that includes the state, creation date, and updated date of the scheduled query, as well as the cadence and user ID who created the schedule.

**Path parameters:**
- `schedulesId` **(required)** — The ID of the schedule you want to retrieve run information for.

**`Accept`:** `application/json`

### `GET /data/foundation/query/schedules/{schedulesId}/runs` — List all runs for a schedule

This request lists the run details for the schedule ID provided in the request path.

**Path parameters:**
- `schedulesId` **(required)** — The ID for the schedule who's run you want to list.

**Query parameters:**
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `limit` — Restrict the maximum number of records that should be returned for a given request.
- `start` — The timestamp used with `orderby` to order the returned results.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. Examples below are given with unsafe HTML characters for clarity, but all content MUST be HTML escaped. Properties that all...

**`Accept`:** `application/json`

### `GET /data/foundation/query/schedules/{schedulesId}/runs/{runId}` — Retrieve details of a query schedule run

This request provides details about a specific run for a specific scheduled query. Both the schedule ID and the run ID must be provided in the request path.

**Path parameters:**
- `schedulesId` **(required)** — Schedule ID
- `runId` **(required)** — Run ID

**`Accept`:** `application/json`

### `GET /data/foundation/query/query-templates` — List query templates

This request provides a list of every query template.

**Query parameters:**
- `isPrevLink` — `isPrevLink` is part of pagination. Results are sorted using the `created` timestamp and the `orderby` property. When navigating pages of results, `isPrevLink` is set to true when paging backwards. It...
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `limit` — Restrict the maximum number of records that should be returned for a given request.
- `start` — The timestamp used with `orderby` to order the returned results.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. List of properties that allow filtering: `name`, `userId`, `lastUpdatedBy`. * The `name` property can only be filtered with...

**`Accept`:** `application/json`

### `GET /data/foundation/query/query-templates/count` — Retrieve the count of query templates

This request retrieves the count of query templates.

**Query parameters:**
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. Examples below are given with unsafe HTML characters for clarity, but all content MUST be HTML escaped. Currently only `use...

**`Accept`:** `application/json`

### `GET /data/foundation/query/query-templates/{queryTemplateId}` — Retrieve a query template

This request retrieves the query template for the template ID provided in the request path.

**Path parameters:**
- `queryTemplateId` **(required)** — The query template ID for the query template to be retrieved.

**`Accept`:** `application/json`

### `GET /data/foundation/query/alert-subscriptions` — List alerts

This request provides a list of alerts.

**Query parameters:**
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `pagesize` — Control the number of records you want to fetch from the API call per page. The default limit is set to the maximum amount of 50 records per page.
- `page` — Indicate the page number of the returned results that you want to see the records for.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. The examples below are given with unsafe HTML characters for clarity, but all content MUST be HTML escaped. The properties ...

### `GET /data/foundation/query/alert-subscriptions/{assetId}` — List alert subscription information for a query or schedule

This request lists the alerts for the query ID or schedule ID provided in the request path. It returns subscription information that includes a list of all subscribed users by providing their email IDs and their chosen notification channels.

**Path parameters:**
- `assetId` **(required)** — A query or schedule ID that you want the subscription information for.

### `GET /data/foundation/query/alert-subscriptions/{assetId}/{alertType}` — List alert subscription information for a particular query and alert type

This request lists the alerts and alert subscription information for the query ID and alert type provided in the request path.

**Path parameters:**
- `assetId` **(required)** — A query or schedule ID that you want the subscription information for.
- `alertType` **(required)** — This property describes the state of query execution that triggers an alert. The response will only include alert subscription information for alerts of this type. The alert type is one of three value...

### `GET /data/foundation/query/alert-subscriptions/user-subscriptions/{emailID}` — List information on all alerts that a user is subscribed to

This request lists the alerts subscribed to by the email ID provided in the request path. The returned information includes the alert name, IDs, status, alert type, and notification channels.

**Path parameters:**
- `emailID` **(required)** — An Adobe-registered email address whose alert subscriptions you want to retrieve.

**Query parameters:**
- `orderby` — The field that specifies the order of results. The supported fields are `created` and `updated`. Prepend the property name with `+` for ascending and `-` for descending order. The default is `-created...
- `pagesize` — Control the number of records you want to fetch from the API call per page. The default limit is set to the maximum amount of 50 records per page.
- `page` — Indicate the page number of the returned results that you want to see the records for.
- `property` — Comma-separated filters. Multiple filters separated by commas can be passed. The examples below are given with unsafe HTML characters for clarity, but all content MUST be HTML escaped. The properties ...

