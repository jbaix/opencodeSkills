# Flow Service (Sources)

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Flow Service API - Sources

*Adobe Experience Platform allows data to be ingested from external sources while providing you with the ability to structure, label, and enhance incoming data using Platform services. You can ingest data from a variety of sources such as Adobe applications, cloud-based storages, databases, and many others. The service provides a RESTful API from which all supported sources are connectable. >**NOTE**: Refer to [Flow S...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/flow-service

### `GET /data/foundation/flowservice/connections` — List connections

Retrieve a list of base connections in your organization by making a GET request to the `/connections` endpoint.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...
- `limit` — Restrict the maximum number of items returned for a given request. For example, adding a parameter of `limit=10` in a request to retrieve all base connections returns only a maximum of 10 base connect...
- `orderby` — Sort the listed resources by specified fields. For example, `orderby=name` sorts results by name in ascending order (A-Z). Adding a dash (`-`) before the field name (`orderby=-name`) sorts the results...
- `continuationToken` — An auto-generated string token that is appended to a returned response when there are more results to be read beyond the maximum count of items that can be returned.
- `count` (default `False`) — A boolean value specifying if the count of resources should be returned. By default the count is not returned (`count=false`)

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/connections/{BASE_CONNECTION_ID}` — Retrieve a base connection

Use this endpoint to retrieve a single base connection.

**Path parameters:**
- `BASE_CONNECTION_ID` **(required)** — The ID of the base connection you want to retrieve.

### `GET /data/foundation/flowservice/connections/{BASE_CONNECTION_ID}/test` — Test a base connection's connectivity

Use this endpoint to test the connectivity of an existing base connection.

**Path parameters:**
- `BASE_CONNECTION_ID` **(required)** — The ID of the base connection you want to test.

### `GET /data/foundation/flowservice/connections/{BASE_CONNECTION_ID}/explore` — Explore a connection's contents

Use this endpoint to explore the data structure and contents of a base connection.

**Path parameters:**
- `BASE_CONNECTION_ID` **(required)** — The ID of the connection you want to explore.

**Query parameters:**
- `objectType` — object Type
- `object` — Path or TableName
- `FileType` — object Type
- `CompressionType` — The compression type used to compress the file.

### `GET /data/foundation/flowservice/connections/{BASE_CONNECTION_ID}/configs` — Retrieve configs for the properties of a given connection.

Use this endpoint to retrieve the configs of a given connection.

**Path parameters:**
- `BASE_CONNECTION_ID` **(required)** — The ID of the base connection to query.

### `GET /data/foundation/flowservice/connectionSpecs` — List connection specs

Use this endpoint to list all connection specs in your organization.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/connectionSpecs/{CONNECTION_SPEC_ID}` — Retrieve a connection spec

Use this endpoint to retrieve a single instance of a connection spec.

**Path parameters:**
- `CONNECTION_SPEC_ID` **(required)** — The ID of the connection specification that you want to retrieve.

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/connectionSpecs/{CONNECTION_SPEC_ID}/explore` — Explore objects of a connection spec.

Use this endpoint to explore the objects of a given connection spec.

**Path parameters:**
- `CONNECTION_SPEC_ID` **(required)** — The ID of the queried connection spec.

### `GET /data/foundation/flowservice/connectionSpecs/{CONNECTION_SPEC_ID}/configs` — Retrieve config options for a connection spec.

Use this endpoint to retrieve the available config options for a given connection spec.

**Path parameters:**
- `CONNECTION_SPEC_ID` **(required)** — The ID of the queried connection spec.

### `GET /data/foundation/flowservice/flows` — List flows

Retrieve a list of flows in your organization by making a GET request to the `/flows` endpoint.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...
- `limit` — Restrict the maximum number of items returned for a given request. For example, adding a parameter of `limit=10` in a request to retrieve all base connections returns only a maximum of 10 base connect...
- `orderby` — Sort the listed resources by specified fields. For example, `orderby=name` sorts results by name in ascending order (A-Z). Adding a dash (`-`) before the field name (`orderby=-name`) sorts the results...
- `continuationToken` — An auto-generated string token that is appended to a returned response when there are more results to be read beyond the maximum count of items that can be returned.
- `count` (default `False`) — A boolean value specifying if the count of resources should be returned. By default the count is not returned (`count=false`)

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/flows/{FLOW_ID}` — Retrieve a flow's details

Use this endpoint to retrieve a single instance of an existing flow.

**Path parameters:**
- `FLOW_ID` **(required)** — The flow entity with the corresponding ID.

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/flowSpecs` — List flow specifications

Retrieve a list of flow specifications by making a GET request to the `/flowSpecs` endpoint.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/flowSpecs/{FLOW_SPEC_ID}` — Retrieve a flow spec

Use this endpoint to retrieve an instance of a flow spec.

**Path parameters:**
- `FLOW_SPEC_ID` **(required)** — The flow spec with the corresponding ID.

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/runs` — List flow runs

Use this endpoint to list all flow run iterations in your organization.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...
- `limit` — Restrict the maximum number of items returned for a given request. For example, adding a parameter of `limit=10` in a request to retrieve all base connections returns only a maximum of 10 base connect...
- `orderby` — Sort the listed resources by specified fields. For example, `orderby=name` sorts results by name in ascending order (A-Z). Adding a dash (`-`) before the field name (`orderby=-name`) sorts the results...
- `continuationToken` — An auto-generated string token that is appended to a returned response when there are more results to be read beyond the maximum count of items that can be returned.
- `count` (default `False`) — A boolean value specifying if the count of resources should be returned. By default the count is not returned (`count=false`)

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/runs/{RUN_ID}` — Retrieve a single flow run

Use this endpoint to retrieve a single flow run iteration.

**Path parameters:**
- `RUN_ID` **(required)** — The ID of the run you want to retrieve.

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/sourceConnections` — List all source connections

Use this endpoint to retrieve a list of all source connections.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...
- `limit` — Restrict the maximum number of items returned for a given request. For example, adding a parameter of `limit=10` in a request to retrieve all base connections returns only a maximum of 10 base connect...
- `orderby` — Sort the listed resources by specified fields. For example, `orderby=name` sorts results by name in ascending order (A-Z). Adding a dash (`-`) before the field name (`orderby=-name`) sorts the results...
- `continuationToken` — An auto-generated string token that is appended to a returned response when there are more results to be read beyond the maximum count of items that can be returned.
- `count` (default `False`) — A boolean value specifying if the count of resources should be returned. By default the count is not returned (`count=false`)

### `GET /data/foundation/flowservice/sourceConnections/{SOURCE_CONNECTION_ID}` — Retrieve a source connection by ID

Retrieve a single source connection by making a GET request to the `/sourceConnections/{SOURCE_CONNECTION_ID}` endpoint while providing the ID of the source connection you want to retrieve.

**Path parameters:**
- `SOURCE_CONNECTION_ID` **(required)** — The ID of the source connection you want to retrieve.

**`Accept`:** `application/json`

### `GET /data/foundation/flowservice/targetConnections` — List all target connections.

Use this endpoint to retrieve a list of all target connections.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. This parameter is used to filter the response data based on the properties provided. For example, `property=lastRu...
- `limit` — Restrict the maximum number of items returned for a given request. For example, adding a parameter of `limit=10` in a request to retrieve all base connections returns only a maximum of 10 base connect...
- `orderby` — Sort the listed resources by specified fields. For example, `orderby=name` sorts results by name in ascending order (A-Z). Adding a dash (`-`) before the field name (`orderby=-name`) sorts the results...
- `continuationToken` — An auto-generated string token that is appended to a returned response when there are more results to be read beyond the maximum count of items that can be returned.
- `count` (default `False`) — A boolean value specifying if the count of resources should be returned. By default the count is not returned (`count=false`)

### `GET /data/foundation/flowservice/targetConnections/{TARGET_CONNECTION_ID}` — Retrieve a target connection

Retrieve a single target connection by making a GET request to the `/targetConnections/{TARGET_CONNECTION_ID}` endpoint while providing the ID of the target connection you want to retrieve.

**Path parameters:**
- `TARGET_CONNECTION_ID` **(required)** — The ID of the target connection you want to retrieve.

**`Accept`:** `application/json`

