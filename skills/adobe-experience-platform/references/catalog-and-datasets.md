# Catalog, Datasets & Data Ingestion

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Catalog Service API

*Catalog is the system of record for data location and lineage within Adobe Experience Platform. Catalog Service does not contain the actual files or directories that contain the data. Instead, it holds the metadata and description of those files and directories. Catalog acts as a metadata store or "catalog" where you can find information about your data within Experience Platform. Use Catalog to answer the following ...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/catalog

### `GET /data/foundation/catalog/batches` — Retrieve a list of batches

This request retrieves a list of batches for operations and applications that have been performed on objects tracked by the system.

**Query parameters:**
- `limit` — Limit response to a specified positive number of objects. The maximum number of objects that can be returned is 100.
- `createdAfter` — Exclusively filter records created after this timestamp.
- `createdBefore` — Exclusively filter records created before this timestamp.
- `created` — Filter by the Unix timestamp (in milliseconds) when this object was persisted.
- `createdClient` — Filter by the ID of the IMS client that created this object.
- `updated` — Filter by the Unix timestamp (in milliseconds) for the time of last modification.
- `createdUser` — Filter by the ID of the user who created this object.
- `updatedUser` — Filter by the ID of the user who changed this object.
- `version` — Filter by Semantic version of the account. Updated when the object is modified.
- `tags` — Filter response by the specified tags.
- `status` — Filter by the current (mutable) status of the batch.
- `recordCount` — Filter by the total number of data records (rows or documents) processed in the batch.
- `failedRecordCount` — Filter by the number of records that could **not** be processed in the batch.
- `size` — The number of bytes processed in the batch.
- `started` — Filter by the Unix timestamp (in milliseconds) when the batch processing action was started. Subtracting "started" from "completed" will yield the total processing time.
- `completed` — Filter by the Unix timestamp (in milliseconds) when the batch processing action was completed. Subtracting "started" from "completed" will yield the total processing time.
- `startAfter` — Filter for batches with availability dates that start after the specified timestamp.
- `startBefore` — Filter for batches with availability dates that start before the specified timestamp.
- `endAfter` — Filter for batches with availability dates that end after the specified timestamp.
- `endBefore` — Filter for batches with availability dates that end before the specified timestamp.
- `batch` — Filter on the ID of the batch.
- `externalId` — Filter on the ID of the external object.
- `dataSet` — Filter on the ID of the dataset.
- `orderBy` — Sort parameter and direction for sorting the response. Ex. orderBy=asc:created,updated. This was previously called sort.
- `start` (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `property` — Regex used to filter objects in the response.
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/batches/uniques/{FIELD}` — Look up the unique values stored in a field

This endpoint retrieves the unique values stored in a field, as specified by the ID.

**Path parameters:**
- `FIELD` **(required)** — Field to get unique values for. **Note:** This endpoint will be deprecated soon.

**Query parameters:**
- `limit` — Limit response to a specified positive number of objects. The maximum number of objects that can be returned is 100.
- `createdAfter` — Exclusively filter records created after this timestamp.
- `createdBefore` — Exclusively filter records created before this timestamp.
- `created` — Filter by the Unix timestamp (in milliseconds) when this object was persisted.
- `createdClient` — Filter by the ID of the IMS client that created this object.
- `updated` — Filter by the Unix timestamp (in milliseconds) for the time of last modification.
- `createdUser` — Filter by the ID of the user who created this object.
- `updatedUser` — Filter by the ID of the user who changed this object.
- `version` — Filter by Semantic version of the account. Updated when the object is modified.
- `status` — Filter by the current (mutable) status of the batch.
- `recordCount` — Filter by the total number of data records (rows or documents) processed in the batch. 100 objects is the maximum that can be returned by requests.
- `failedRecordCount` — Filter by the number of records that could **not** be processed in the batch.
- `size` — The number of bytes processed in the batch.
- `started` — Filter by the Unix timestamp (in milliseconds) when the batch processing action was started. Subtracting "started" from "completed" will yield the total processing time.
- `completed` — Filter by the Unix timestamp (in milliseconds) when the batch processing action was completed. Subtracting "started" from "completed" will yield the total processing time.
- `startAfter` — Filter for batches with availability dates that start after the specified timestamp.
- `startBefore` — Filter for batches with availability dates that start before the specified timestamp.
- `endAfter` — Filter for batches with availability dates that end after the specified timestamp.
- `endBefore` — Filter for batches with availability dates that end before the specified timestamp.
- `batch` — Filter on the ID of the batch.
- `externalId` — Filter on the ID of the external object.
- `dataSet` — Filter on the ID of the dataset.
- `transform` — Filter on the ID of the transform.
- `orderBy` — Sort parameter and direction for sorting the response. Ex. orderBy=asc:created,updated. This was previously called sort.
- `start` (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `property` — Regex used to filter objects in the response.
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/batches/{BATCH_ID}` — Look up a batch

This request retrieves a specific batch based on the {BATCH_ID} entered.

**Path parameters:**
- `BATCH_ID` **(required)** — The ID of the batch you are performing the operation on.

**Query parameters:**
- `aggregate` — If true, then return the aggregated status, metrics, and errors in the root level status, metrics, and errors (default is false).

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/lastBatches` — List last batches

Fetches a list of last batches per dataset. A list of datasetIds is returned, which lets you check the last batch status, last successful batch, and last failed batch per dataset.

**Query parameters:**
- `dataSetId` — Filter by a datasetId. A list can be provided by separating the values with comma. The number of datasets requested is limited by the max-http-header-size config.
- `lastBatchId` — Filter by the ID of the last related batch of a dataset
- `lastBatchStatus` — Filter by the status of the last related batch of the dataset
- `lastSuccessfulBatchId` — Filter by the ID of the last successful batch related to a dataset
- `lastFailedBatchId` — Filter by the ID of the last failed batch related to a dataset
- `created` — Filter by the Unix timestamp (in milliseconds) when this object was persisted.
- `updated` — Filter by the Unix timestamp (in milliseconds) for the time of last modification.
- `orderBy` — Sort parameter and direction for sorting the response. Ex. orderBy=asc:created,updated. This was previously called sort.
- `limit` — Limit response to a specified positive number of objects. The maximum number of objects that can be returned is 100.
- `start` (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.

### `GET /data/foundation/catalog/dataSets` — Retrieve a list of datasets

This request lets you retrieve a list of datasets which are the building blocks for data transformation and tracking in Catalog Service.

**Query parameters:**
- `version` — Filter by Semantic version of the account. Updated when the object is modified.
- `created` — Filter by the Unix timestamp (in milliseconds) when this object was persisted.
- `updated` — Filter by the Unix timestamp (in milliseconds) for the time of last modification.
- `createdClient` — Filter by the ID of the IMS client that created this object.
- `createdUser` — Filter by the ID of the user who created this object.
- `updatedUser` — Filter by the ID of the user who changed this object.
- `name` — Filter on the name of the dataset.
- `description` — Filter on the description of the dataset.
- `enableErrorDiagnostics` — A field that provides the ability to opt in to generating diagnostic files for the errors while ingesting data.
- `orderBy` — Sort parameter and direction for sorting the response. Ex. orderBy=asc:created,updated. This was previously called sort.
- `limit` — Limit response to a specified positive number of objects. The maximum number of objects that can be returned is 100.
- `start` (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `property` — Regex used to filter objects in the response.
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.
- `tags` — Filter response by the specified tags.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/dataSets/{DATASET_ID}` — Look up a dataset

This request allows you to retrieve a dataset using the {DATASET_ID}.

**Path parameters:**
- `DATASET_ID` **(required)** — The ID of the dataset.

**Query parameters:**
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/dataSets/{id}/credentials` — Retrieve a dataset's credentials

This request fetches credentials for the requested dataset ID.

**Path parameters:**
- `id` **(required)** — Object ID

**Query parameters:**
- `batchId` — If wishing to write, the batchId used during writing. Required for building a stage path.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog` — Retrieve a list of batched requests

This request allows you to retrieve a list of batched requests which can be ordered as required. For example, the list can be ordered by created date in ascending order.

**Query parameters:**
- `orderBy` — Sort parameter and direction for sorting the response. Ex. orderBy=asc:created,updated. This was previously called sort.
- `limit` — Limit response to a specified positive number of objects. The maximum number of objects that can be returned is 100.
- `start` (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `property` — Regex used to filter objects in the response.
- `properties` — A comma separated allowlist of top-level object properties to be returned in the response. Used to cut down the number of properties and amount of data returned in the response bodies.

**`Accept`:** `application/json`

### `GET /data/foundation/catalog/tags/{tagNamespace}` — Retrieve a list of aggregated values

**Note:** This endpoint has been deprecated. This endpoint retrieves a list of aggregated values for all tags within an Organization, specified by namespace.

**Path parameters:**
- `tagNamespace` **(required)** — Tag namespace or key as defined within a tag inside dataSet, batch or transform.

**`Accept`:** `application/json`


## Dataset Service API

*Use the several endpoints provided by The Dataset Service API to manage data usage labels for existing datasets within the Data Lake. Data usage labels are part of Adobe Experience Platform Data Governance, which allows you to manage customer data and ensure compliance with regulations, restrictions, and policies applicable to data use. Dataset Service is separate from Catalog Service, which manages other dataset met...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/dataset-service

### `GET /data/foundation/dataset/datasets/{DATASET_ID}/labels` — Retrieve data usage labels for a specific dataset

You can use this endpoint to retrieve data usage labels for a specified dataset. >**NOTE**: See the tutorial on [managing labels for datasets using APIs](https://experienceleague.adobe.com/docs/experience-platform/data-governance/labels/dataset-api.html) for more information on using this endpoint.

**Path parameters:**
- `DATASET_ID` **(required)** — The ID of an existing dataset. Dataset IDs can be retrieved using the [Catalog Service API](https://www.adobe.io/apis/experienceplatform/home/api-reference.html#!acpdr/swagger-specs/catalog.yaml).

**`Accept`:** `application/json`


## Batch Ingestion API

*Batch ingestion allows you to ingest data into Adobe Experience Platform as batch files. Batches are units of data that consist of one or more files to be ingested as a single unit. Once ingested, batches provide metadata that describes the number of records successfully ingested, as well as any failed records and associated error messages. Use the Batch Ingestion API to create batches, upload files, check on upload ...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/batch-ingestion

### `GET /data/foundation/import/batches/{batchId}/datasets/{datasetId}/preview` — Retrieve a preview for a batch

This endpoint generates a data preview for the files uploaded to the batch so far. The preview can be generated either collectively for all the batch datasets, or for only selected datasets.

**Path parameters:**
- `batchId` **(required)** — The ID of the batch that you are trying to preview.
- `datasetId` **(required)** — The ID of the dataset that you are trying to preview.

**Query parameters:**
- `format` **(required)** — The file format for the uploaded file.
- `isMultiLineJson` (default `False`) — This flag indicates whether the files to be ingested are in a multi-line json format.
- `delimiter` (default `,`) — The character used to specify boundaries between separate strings when parsing column values.
- `quote` (default `"`) — The character used to quote a value when parsing data.
- `escape` (default `\`) — The character used to escape a reserved character when parsing data.
- `charset` (default `UTF-8`) — The character encoding used for parsing data.
- `header` (default `True`) — The flag to indicate if the header is supplied in the dataset files.
- `nrow` (default `0`) — The number of rows to parse.

**`Accept`:** `application/json`


## Data Access API

*Data Access supports limited data egress from Adobe Experience Platform for very particular synchronous use cases. This API has a 60-second response time limit. For large data exports or regular data integration, you should use dataset export destinations. - **Related documentation**: - [Data Access documentation](https://www.adobe.com/go/data-access-overview-en) - **Visualize API calls with Postman (a free, third-pa...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/data-access

### `GET /data/foundation/export/batches/{batchId}/files` — List a batch's dataset files

By default, 100 dataset files are shown. Additionally, 100 dataset files is the maximum number of files that can be returned in a single API request.

**Path parameters:**
- `batchId` **(required)** — The batch ID.

**Query parameters:**
- `start` — A paging parameter to specify the start of the page of results. For example: `page=1`
- `limit` — A paging parameter to specify the number of results per page. For example: `limit=10`

**`Accept`:** `application/json`

### `GET /data/foundation/export/batches/{batchId}/failed` — Retrieve a failed batch's dataset files

By default, 100 failed files are shown. Additionally, 100 failed files is the maximum number of files that can be returned in a single API request.

**Path parameters:**
- `batchId` **(required)** — The ID of the batch.

**Query parameters:**
- `start` — A paging parameter to specify the start of the page of results. For example: `page=1`
- `limit` — A paging parameter to specify the number of results per page. For example: `limit=10`
- `path` — The full name of the file. The contents of the file would be downloaded if this parameter is provided. For example: `path=profiles.csv`

**`Accept`:** `application/json`

### `GET /data/foundation/export/batches/{batchId}/meta` — Retrieve a batch's meta files

Lists files under a batch's meta directory or download a specific file under it. The files under a batch's meta directory may include the following: - row_errors: A directory containing 0 or more files with parsing, conversion, and/or validation errors found at the row level. - input_files: A direct...

**Path parameters:**
- `batchId` **(required)** — The ID of the batch.

**Query parameters:**
- `start` — A paging parameter to specify the start of the page of results. For example: `page=1`
- `limit` — A paging parameter to specify the number of results per page. For example: `limit=10`
- `path` — The full name of the file. The contents of the file would be downloaded if this parameter is provided. For example: `path=row_error_samples.json` Possible values for this query include the following: ...

**`Accept`:** `application/json`

### `GET /data/foundation/export/files/{dataSetFileId}` — Retrieve a file

Returns either a complete file or a directory of chunked data that makes up the file. The response contains a data array that may contain a single entry or a list of files belonging to that directory.

**Path parameters:**
- `dataSetFileId` **(required)** — The ID of the dataset file you are retrieving.

**Query parameters:**
- `start` — A paging parameter to specify the start of the page of results. For example: `page=1`
- `limit` — A paging parameter to specify the number of results per page. For example: `limit=10`
- `path` — The full name of the file. The contents of the file would be downloaded if this parameter is provided. For example: `path=profiles.csv`

**`Accept`:** `application/json, application/octet-stream`

### `GET /data/foundation/export/datasets/{id}/preview` — Preview the files

This endpoint lets you preview the first 100 rows of the retrieved CSV or Parquet files.

**Path parameters:**
- `id` **(required)** — The ID of the dataset you want to preview.

**`Accept`:** `application/json`


## Data Prep API

*Data Prep allows data engineers to map, transform, and validate data to and from Experience Data Model (XDM). Use the Data Prep API to programmatically create mapping sets and functions, and transform your data between source and destination schemas. - Related documentation: - [Data Prep documentation](https://experienceleague.adobe.com/docs/experience-platform/data-prep/home.html) - **API paths**: - Platform Gateway...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/data-prep

### `GET /data/foundation/conversion/languages/el/functions` — List the available mapping set functions

**`Accept`:** `application/json`

### `GET /data/foundation/conversion/languages/el/operators` — List the available mapping set operators

**`Accept`:** `application/json`

### `GET /data/foundation/conversion/mappingSets` — List mapping sets

**Query parameters:**
- `limit` **(required)** (default `10`) — The total number of records to fetch per page.
- `start` **(required)** (default `0`) — Specifies the offset of the pages of results. To get the first page of results, set the value to `start=0`.
- `name` — Filter the mapping sets by name.
- `orderBy` (default `lastUpdateDate`) — Sorts the order of the results. Supported fields are: `createdDate` and `updatedDate`. Prepend the property name with `+` for ascending order and `-` for descending order.
- `expandSchema` — Determines whether the full output schema is returned as part of the response.

**`Accept`:** `application/json`

### `GET /data/foundation/conversion/mappingSets/{MAPPING_SET_ID}` — Retrieve a mapping set

**Path parameters:**
- `MAPPING_SET_ID` **(required)** — The ID of the mapping set you are retrieving.

**Query parameters:**
- `expandSchema` (default `False`) — Determines whether to return the output schema as part of the response.
- `version` (default `0`) — Determines which version of the mapping set to retrieve.

**`Accept`:** `application/json`

### `GET /data/foundation/conversion/mappingSets/{MAPPING_SET_ID}/mappings` — Retrieve a list of mappings for a specified mapping set

**Path parameters:**
- `MAPPING_SET_ID` **(required)** — The ID of the mapping set you are retrieving mappings for.

**`Accept`:** `application/json`

### `GET /data/foundation/conversion/mappingSets/{MAPPING_SET_ID}/mappings/{MAPPING_ID}` — Retrieve a mapping from a specified mapping set

**Path parameters:**
- `MAPPING_SET_ID` **(required)** — The ID of the mapping set you want to retrieve a specific mapping from.
- `MAPPING_ID` **(required)** — The ID of the mapping you want to retrieve.

**`Accept`:** `application/json`

