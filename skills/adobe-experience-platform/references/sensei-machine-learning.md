# Sensei Machine Learning (Data Science Workspace)

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Sensei Machine Learning API

*Sensei Machine Learning API provides a mechanism for data scientists to organize and manage ML services from algorithm onboarding through experimentation and to service deployment. Related documentation: * [Data Science Workspace documentation](http://www.adobe.com/go/data-science-overview-en) Visualize API calls with Postman (a free, third-party software): * [Sensei Machine Learning API Postman collection on GitHub]...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/sensei-machine-learning

### `GET /data/sensei/engines` — List all engines

Lists all engines providing mechanisms for pagination, filtering, and sorting.

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=engineListing.v1.json`

### `GET /data/sensei/engines/dockerRegistry` — Get Docker registry information

Get Docker registry information

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=enginesDockerRegistryInfo.v1.json`

### `GET /data/sensei/engines/{engineId}` — Retrieve an Engine

Retrieves a specific Engine

**Path parameters:**
- `engineId` **(required)** — The identifier of the Sensei Engine

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=engine.v1.json`

### `GET /data/sensei/mlInstances` — List MLInstances

MLInstances may be searched by name or tags.

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=mlInstanceListing.v1.json`

### `GET /data/sensei/mlInstances/{mlInstanceId}` — Retrieve an MLInstance

**Path parameters:**
- `mlInstanceId` **(required)** — The identifier of the Sensei ML instance

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=mlInstance.v1.json`

### `GET /data/sensei/experiments` — Retrieve an MLInstance's experiments

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=experimentListing.v1.json`

### `GET /data/sensei/experiments/{experimentId}` — Retrieve an experiment

**Path parameters:**
- `experimentId` **(required)** — The identifier of the experiment

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=experiment.v1.json`

### `GET /data/sensei/experiments/{experimentId}/runs` — List experiment runs

**Path parameters:**
- `experimentId` **(required)** — The identifier of the experiment

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=experimentRunListing.v1.json`

### `GET /data/sensei/experiments/{experimentId}/runs/{experimentRunId}` — Retrieve experiment run information

**Path parameters:**
- `experimentId` **(required)** — The identifier of the experiment
- `experimentRunId` **(required)** — The identifier of the experiment run

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=experimentRun.v1.json`

### `GET /data/sensei/experiments/{experimentId}/runs/{experimentRunId}/status` — Retrieve an experiment run status

**Path parameters:**
- `experimentId` **(required)** — The identifier of the experiment
- `experimentRunId` **(required)** — The identifier of the experiment run

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=experimentRunStatus.v1.json`

### `GET /data/sensei/models` — List all Models.

List all Models providing mechanisms for pagination, filtering, and sorting.

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=modelListing.v1.json`

### `GET /data/sensei/models/{modelId}` — Retrieve a Model

Retrieves a specific Model

**Path parameters:**
- `modelId` **(required)** — The identifier of the trained or published Model

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=model.v1.json`

### `GET /data/sensei/models/{modelId}/artifact` — Retrieve a binary Model artifact

**Path parameters:**
- `modelId` **(required)** — The identifier of the trained or published Model

**`Accept`:** `application/octet-stream`

### `GET /data/sensei/models/{modelId}/transcodings` — List a model's transcodings

**Path parameters:**
- `modelId` **(required)** — The identifier of the trained or published Model

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=modelTranscodingListing.v1.json`

### `GET /data/sensei/models/{modelId}/transcodings/{modelTranscodingId}` — Retrieve a Model transcoding

**Path parameters:**
- `modelId` **(required)** — The identifier of the trained or published Model
- `modelTranscodingId` **(required)** — The identifier of the transcoded Model artifact

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=modelTranscoding.v1.json`

### `GET /data/sensei/insights` — List all insights

Lists all insights for all experiment runs

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=insightListing.v1.json`

### `GET /data/sensei/insights/{insightId}` — Retrieve an insight

Retrieves a specific insight

**Path parameters:**
- `insightId` **(required)** — The identifier of the Sensei Insight

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=insight.v1.json`

### `GET /data/sensei/insights/metrics` — List default metrics for algorithms

Lists all default metrics available for algorithms

**Query parameters:**
- `algorithm` — The identifier of the algorithm type

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=defaultMetricsListing.v1.json`

### `GET /data/sensei/mlServices` — List all filtered MLServices

MLServices may be searched by name or tags.

**Query parameters:**
- `start` — Start value for pagination. Indicates the starting index for the items to return.
- `limit` (default `25`) — Limit value for pagination. Indicates the requested number of items to return. The service may return a different number of items than requested.
- `orderby` (default `["-updated"]`) — Sort order for pagination. Indicates the fields and direction to use for sorting in priority order.
- `property` — Property matching expression for filtering paginated results. Indicates the comparison expression that items must match in order to be returned.

**`Accept`:** `application/vnd.adobe.platform.sensei+json;profile=mlServiceListing.v1.json`

### `GET /data/sensei/mlServices/{serviceId}` — Retrieve an MLService

**Path parameters:**
- `serviceId` **(required)** — The identifier of the Sensei Service

**`Accept`:** `, application/vnd.adobe.platform.sensei+json;profile=mlService.v1.json`

