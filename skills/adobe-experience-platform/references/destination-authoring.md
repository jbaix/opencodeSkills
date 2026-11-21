# Destination Authoring (Destination SDK)

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Destination Authoring API

*Adobe Experience Platform Destination SDK (also referred to as the *Destination Authoring API*) is a suite of configuration APIs that allow you to configure destination integration patterns for Experience Platform to deliver audience and profile data to your endpoint, based on data and authentication formats of your choice. - **Related documentation**: - [Destination SDK overview](http://www.adobe.com/go/destination-...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/destination-authoring

### `GET /data/core/activation/authoring/destinations` — Retrieve a list of destination configurations

You can retrieve a list of all destination configurations for your IMS Organization by making a GET request to the `/destinations` endpoint.

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/destinations/{INSTANCE_ID}` — Retrieve a destination configuration

You can retrieve detailed information about a specific destination configuration by making a GET request to the `/destinations` endpoint and providing the ID of the destination configuration you want to retrieve.

**Path parameters:**
- `INSTANCE_ID` **(required)** — The ID of the destination configuration that you want to retrieve.

### `GET /data/core/activation/authoring/destination-servers` — Retrieve a list of destination server configurations

You can retrieve a list of all destination server configurations for your IMS Organization by making a GET request to the `/destination-servers` endpoint.

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/destination-servers/{INSTANCE_ID}` — Retrieve a destination server configuration

You can retrieve detailed information about a specific destination server configuration by making a GET request to the `/destination-servers` endpoint and providing the ID of the destination server configuration you want to retrieve.

**Path parameters:**
- `INSTANCE_ID` **(required)** — The ID of the destination server configuration you want to retrieve.

### `GET /data/core/activation/authoring/audience-templates` — Retrieve all audience templates

You can retrieve a list of all audience templates for your IMS Organization by making a `GET` request to the `/authoring/audience-templates` endpoint.

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/audience-templates/{INSTANCE_ID}` — Retrieve a specific audience template

You can retrieve detailed information about a specific audience template by making a GET request to the `/audience-templates` endpoint and providing the ID of the audience template you want to retrieve.

**Path parameters:**
- `INSTANCE_ID` **(required)** — The ID of the audience template you want to retrieve.

### `GET /data/core/activation/authoring/credentials` — Retrieve all credential configurations

You can retrieve a list of all existing credential configuration for your IMS Organization by making a `GET` request to the `/authoring/credentials` endpoint.

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/credentials/{INSTANCE_ID}` — Retrieve a specific credential configuration

You can retrieve an existing credential configuration by making a `GET` request to the `/authoring/credentials` endpoint and providing the ID of the credentials configuration you want to retrieve.

**Path parameters:**
- `INSTANCE_ID` **(required)** — The ID of the credential configuration you want to retrieve.

### `GET /data/core/activation/authoring/sample-profiles` — Retrieve a list of sample profiles for a given destination configuration or destination instance

Use this API endpoint to generate sample profiles for two separate use cases. You can either: <ul><li>Generate profiles to use when [crafting and testing a message transformation template](https://experienceleague.adobe.com/en/docs/experience-platform/destinations/destination-sdk/testing-api/streami...

**Query parameters:**
- `destinationInstanceId` — Destination instance ID, also called order ID. Use this parameter to generate source-schema XDM profiles for destination testing. Get the ID from the connection URL in the Experience Platform UI. Supp...
- `destinationId` — Destination configuration ID returned by /destinations. Use this parameter to generate target-schema profiles for message template rendering. Supply this parameter or destinationInstanceId, not both. ...
- `count` — Number of sample profiles to generate, from 1 to 1000. If omitted, use aggregation.bestEffortAggregation.maxUsersPerRequest from the destination configuration, or one profile if that setting is absent...

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/testing/template/sample/{DESTINATION_CONFIGURATION_ID}` — Retrieve a sample destination template

Retrieve a sample template corresponding to the destination's `destinationID`. For more information, see the functionality documentation on [generating a sample template](https://experienceleague.adobe.com/en/docs/experience-platform/destinations/destination-sdk/testing-api/streaming-destinations/sa...

**Path parameters:**
- `DESTINATION_CONFIGURATION_ID` **(required)** — The ID of the destination configuration for which you are generating a message transformation template. <br><br> The destination ID that you should use here is the ID that corresponds to a destination...

**`Accept`:** `text/plain`

### `GET /data/core/activation/authoring/testing/destinationInstance/{DESTINATION_INSTANCE_ID}/results` — Retrieve file-based destination activation results

Retrieve detailed activation results after testing a file-based destination. Use the results URL returned by the test call. See the [file-based destination results API](https://experienceleague.adobe.com/en/docs/experience-platform/destinations/destination-sdk/testing-api/batch-destinations/file-bas...

**Path parameters:**
- `DESTINATION_INSTANCE_ID` **(required)** — Destination instance ID from the connection URL in the Experience Platform UI.

**Query parameters:**
- `flowRunIds` **(required)** — Comma-separated flow run IDs from the file-based destination test response.

### `GET /data/core/activation/authoring/destinations/publish` — List destination publish requests

You can retrieve a list of all destinations submitted for publishing for your IMS Organization by making a GET request to the `/authoring/destinations/publish` endpoint.

**`Accept`:** `application/json`

### `GET /data/core/activation/authoring/destinations/publish/{DESTINATION_ID}` — Retrieve a specific publishing request

You can retrieve detailed information about a specific destination publish request by making a GET request to the `/authoring/destinations/publish` endpoint and providing the ID of the destination for which you want to retrieve the publishing status.

**Path parameters:**
- `DESTINATION_ID` **(required)** — The ID of the destination for which you want to retrieve the publishing status.

