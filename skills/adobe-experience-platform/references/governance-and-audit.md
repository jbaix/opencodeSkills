# Governance, Privacy, Audit & Observability

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Policy Service API

*Adobe Experience Platform Data Governance simplifies and streamlines the process of categorizing data and creating data usage policies. Once data labels have been applied and data usage policies are in place, marketing actions can be evaluated to ensure the correct use of data. Use the Policy Service API to programmatically manage data usage labels, policies, and marketing actions. The API also provides endpoints to ...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/policy-service

### `GET /data/foundation/dulepolicy/labels/core` — List core labels

>**NOTE**: For more information on using this operation, see the [labels endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/labels.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/labels/core/{LABEL_NAME}` — Retrieve a core label

>**NOTE**: For more information on using this operation, see the [labels endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/labels.html) on Experience League.

**Path parameters:**
- `LABEL_NAME` **(required)** — The name of the core label.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/labels/custom` — List custom labels

>**NOTE**: For more information on using this operation, see the [labels endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/labels.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/labels/custom/{LABEL_NAME}` — Retrieve a custom label

>**NOTE**: For more information on using this operation, see the [labels endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/labels.html) on Experience League.

**Path parameters:**
- `LABEL_NAME` **(required)** — The name of the custom label.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/policies/core` — List core policies

>**NOTE**: For more information on using this operation, see the [policies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/policies.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.
- `duleLabels` — A comma-separated list of data usage label names. Using this parameter returns only those policies whose `deny` expression references any of the labels in the list.
- `marketingAction` — Restricts returned policies to those that reference a given marketing action ID.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/policies/core/{POLICY_ID}` — Retrieve a core policy

>**NOTE**: For more information on using this operation, see the [policies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/policies.html) on Experience League.

**Path parameters:**
- `POLICY_ID` **(required)** — The ID of the policy to be retrieved.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/policies/custom` — List custom policies

>**NOTE**: For more information on using this operation, see the [policies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/policies.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.
- `duleLabels` — A comma-separated list of data usage label names. Using this parameter returns only those policies whose `deny` expression references any of the labels in the list.
- `marketingAction` — Restricts returned policies to those that reference a given marketing action ID.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/policies/custom/{POLICY_ID}` — Retrieve a custom policy

>**NOTE**: For more information on using this operation, see the [policies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/policies.html) on Experience League.

**Path parameters:**
- `POLICY_ID` **(required)** — The ID of the custom policy being retrieved.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/core` — List core marketing actions

>**NOTE**: For more information on using this operation, see the [marketing actions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/marketing-actions.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/core/{MARKETING_ACTION_NAME}` — Retrieve a core marketing action

>**NOTE**: For more information on using this operation, see the [marketing actions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/marketing-actions.html) on Experience League.

**Path parameters:**
- `MARKETING_ACTION_NAME` **(required)** — The name of the marketing action to be retrieved.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/core/{MARKETING_ACTION_NAME}/constraints` — Evaluate a core marketing action based on data usage labels

This call returns a set of constraints that would govern an attempt to perform the given marketing action on a hypothetical source of data containing specific data usage labels. You can also evaluate a marketing action based on the labels contained in an actual dataset in your data stores. See the P...

**Path parameters:**
- `MARKETING_ACTION_NAME` **(required)** — The name of the marketing action to test data usage labels against.

**Query parameters:**
- `duleLabels` **(required)** — A comma-separated list of data usage labels that would be present on data that you want to test for policy violations.
- `includeDraft` (default `False`) — If true, the system checks for policy violations among policies with `DRAFT` status as well as `ENABLED` status. Otherwise, only `ENABLED` policies are checked.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/custom` — List custom marketing actions

>**NOTE**: For more information on using this operation, see the [marketing actions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/marketing-actions.html) on Experience League.

**Query parameters:**
- `property` — Filters responses based on whether a specific property exists, or whose value passes a conditional expression (e.g. `?property=name==C1`). Only the `name` property is supported for core resources. For...
- `orderby` — A comma-separated list of properties by which the returned list of resources will be sorted.
- `start` — Indicates the pagination value for the returned list. This value should be obtained from a previous call's `_page.next` property. Should be omitted for a first page of results.
- `limit` — A positive integer, indicating the number of results to limit the response to.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/custom/{MARKETING_ACTION_NAME}` — Retrieve a custom marketing action

>**NOTE**: For more information on using this operation, see the [marketing actions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/marketing-actions.html) on Experience League.

**Path parameters:**
- `MARKETING_ACTION_NAME` **(required)** — The name of the marketing action to be retrieved.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/marketingActions/custom/{MARKETING_ACTION_NAME}/constraints` — Evaluate a custom marketing action based on data usage labels

This call returns a set of constraints that would govern an attempt to perform the given marketing action on a hypothetical source of data containing specific data usage labels. You can also evaluate a marketing action based on the labels contained in an actual dataset in your data stores. See the P...

**Path parameters:**
- `MARKETING_ACTION_NAME` **(required)** — The name of the marketing action to test data usage labels against.

**Query parameters:**
- `duleLabels` **(required)** — A comma-separated list of data usage labels that would be present on data that you want to test for policy violations.
- `includeDraft` (default `False`) — If true, the system checks for policy violations among policies with `DRAFT` status as well as `ENABLED` status. Otherwise, only `ENABLED` policies are checked.

**`Accept`:** `application/json`

### `GET /data/foundation/dulepolicy/enabledCorePolicies` — List all enabled core policies

>**NOTE**: For more information on using this operation, see the [policies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/data-governance/api/policies.html) on Experience League.

**`Accept`:** `application/json`


## Privacy Service API

*Adobe Experience Platform Privacy Service provides a common, centralized facilitation of access/delete requests and opt-out-of-sale requests for private data on Adobe Experience Cloud applications. The service includes a UI for selecting and creating requests, a business layer that processes incoming and outgoing traffic, a data store for audit and logging information, and temporary storage for data retrieval while r...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/privacy-service

### `GET /data/core/privacy/jobs` — List privacy jobs

>**NOTE**: For more information on using this operation, see the [privacy jobs endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/privacy/api/privacy-jobs.html) on Experience League.

**Query parameters:**
- `regulation` **(required)** — The privacy regulation to return jobs from.
- `size` (default `25`) — The number of jobs to return in the response body.
- `page` (default `1`) — The page index to return results from when the result count exceeds the limit defined by the `size` parameter.
- `status` — Filters jobs by processing status.
- `fromDate` — Limits results to those processed after a specified date. Accepts the format YYYY-MM-DD. If this parameter (and a corresponding `toDate`) is not provided, the resulting jobs default to the last seven ...
- `toDate` — Limits results to those processed before a specified date. Accepts the format YYYY-MM-DD. If this parameter (and a corresponding `fromDate`) is not provided, the resulting jobs default to the last sev...
- `filterDate` — Limits results to those processed on a specified date. Accepts the format YYYY-MM-DD.

**`Accept`:** `application/json`

### `GET /data/core/privacy/jobs/{JOB_ID}` — Retrieve a privacy job

>**NOTE**: For more information on using this operation, see the [privacy jobs endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/privacy/api/privacy-jobs.html) on Experience League.

**Path parameters:**
- `JOB_ID` **(required)** — The unique ID of a privacy job.

**`Accept`:** `application/json`

### `GET /data/core/privacy/jobs/{JOB_ID}/content` — Retrieve customer access information

Use the `/jobs/{JOB_ID}/content` endpoint to securely retrieve access information for your customers. The download URL provided in the response to a `/jobs/{JOB_ID}` GET request points to an Adobe service endpoint. You can then make a GET request to `/jobs/{JOB_ID}/content` to return your customer d...

**Path parameters:**
- `JOB_ID` **(required)** — The unique identifier for the privacy job whose data is being requested.


## Audit Query API

*Adobe Experience Platform allows you to audit user activity for various services and capabilities in the form of audit logs. Each action recorded in a log contains metadata that indicates the action type, date and time, the email ID of the user who performed the action, and additional attributes relevant to the action type. Use the Audit Query API to programmatically view and export audit logs recorded by the system....*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/audit-query

### `GET /data/foundation/audit/events` — List audit events

**Query parameters:**
- `property` — You can filter list results by including a `property` query parameter. The value must be an array that contains one or more of a list of properties, where each property is prefixed with `property` and...
- `limit` (default `50`) — The maximum number of results to return, with a limit of 1000.
- `start` — A pointer to the first item for the returned search results. To access the next page of results, this parameter should increment by the same amount indicated by `limit`. For example, to access the nex...
- `queryId` — When making a query to the `/audit/events` endpoint, the response includes a `queryId` string property. If you wish to make the same query in a separate call, you can include the ID value as a single ...

**`Accept`:** `application/json`

### `GET /data/foundation/audit/export` — Export a list of audit events

**Query parameters:**
- `property` — You can filter list results by including a `property` query parameter. The value must be an array that contains one or more of a list of properties, where each property is prefixed with `property` and...

**`Accept`:** `application/octet-stream`


## Observability Insights API

*Use the Observability Insights API to programmatically retrieve and monitor metric data for various Adobe Experience Platform features. * **Related documentation**: * [Observability Insights documentation](http://www.adobe.com/go/observability-overview-en) * **Visualize API calls with Postman (a free, third-party software)**: * [Observability Insights API Postman collection on GitHub](https://github.com/adobe/experie...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/observability-insights

### `GET /data/infrastructure/observability/insights/metrics` — Retrieve metrics data (V1)

>**NOTE**: This method is now deprecated. For the latest functionality, please the POST method for this endpoint instead. The first version of the API allows you to retrieve metric data by supplying applicable metrics in the request path as query parameters.

**Query parameters:**
- `metric` **(required)** — Metrics you wish the API to return insights from. Refer to the documentation for a list of [accepted metrics](http://www.adobe.com/go/observability-metrics-en).
- `id` — ID associated with the resourceType in the metric.
- `dateRange` — A Date Range in ISO 8601 format. Defaults to 30 days if not present for time-series metrics. Defaults to the last day if not present for single-stat metrics.

**`Accept`:** `application/json, application/problem+json`


## Access Control API

*Access Control in Adobe Experience Platform allows organization administrators to assign roles and permissions for various Platform capabilities. The Access Control API provides a public endpoint to retrieve effective policies for a user on given resources within a specified sandbox. All other access control capabilities are provided through the [Adobe Admin Console](https://adminconsole.adobe.com). - Related documen...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/access-control

### `GET /data/foundation/access-control/acl/reference` — List all available permission names and resource types

**`Accept`:** `application/json`

### `GET /data/foundation/access-control/administration/roles` — List all existing roles

### `GET /data/foundation/access-control/administration/roles/{ROLE_ID}` — Retrieve a role

**Path parameters:**
- `ROLE_ID` **(required)** — The ID of the role you want to retrieve.

### `GET /data/foundation/access-control/administration/roles/{ROLE_ID}/subjects` — Retrieve subjects

**Path parameters:**
- `ROLE_ID` **(required)** — The ID of the role you want to retrieve.

### `GET /data/foundation/access-control/administration/policies` — List all existing policies in your organization

### `GET /data/foundation/access-control/administration/policies/{POLICY_ID}` — Retrieve a policy

**Path parameters:**
- `POLICY_ID` **(required)** — The ID of the policy you want to retrieve.

### `GET /data/foundation/access-control/administration/products` — List all entitled products

### `GET /data/foundation/access-control/administration/products/{PRODUCT_ID}/categories` — Retrieve permission categories

**Path parameters:**
- `PRODUCT_ID` **(required)** — The ID of the product you want to retrieve.

### `GET /data/foundation/access-control/administration/products/{PRODUCT_ID}/permission-sets` — Retrieve permission sets

**Path parameters:**
- `PRODUCT_ID` **(required)** — The ID of the product you want to retrieve.

