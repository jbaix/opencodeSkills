# Reactor API (Tags)

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Reactor API

*Use the Reactor API to programmatically manage resources and develop tag extensions in Adobe Experience Platform. **Related documentation**: * [Tags overview and UI documentation](https://adobe.com/go/launch_help_en) * [Reactor API guides](https://adobe.com/go/reactor-api-overview) **API paths**: * Reactor Gateway URL: https://<span>reactor.adobe.io * Example of a complete path for making a call to `/properties`: htt...*

- **Host:** `https://reactor.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/reactor

### `GET /companies` — List companies

>**NOTE**: For more information on using this operation, see the [companies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/companies.html) on Experience League.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `org_id` — Filter by `org_id`.
- `token` — Filter by `token`.

**`Accept`:** `{{Accept}}`

### `GET /companies/{COMPANY_ID}` — Retrieve a company

>**NOTE**: For more information on using this operation, see the [companies endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/companies.html) on Experience League.

**Path parameters:**
- `COMPANY_ID` **(required)** — The ID of the company you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /companies/{COMPANY_ID}/properties` — List a company's properties

>**NOTE**: For more information on using this operation, see the [properties endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/properties.html) on Experience League.

**Path parameters:**
- `COMPANY_ID` **(required)** — The ID of the company whose properties you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `app_id` — Filter by `app_id`.
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `copying` — Filter by `copying`. This is a legacy attribute that is specific to properties that were migrated from the original Dynamic Tag Management (DTM) system to the current system. A `copying` property is a...
- `enabled` — Filter by `enabled`.
- `platform` — Filter by `platform`.
- `token` — Filter by `token`.

**`Accept`:** `{{Accept}}`

### `GET /companies/{COMPANY_ID}/app_configurations` — List a company's app configurations

>**NOTE**: For more information on using this operation, see the [app configurations endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/app-configurations.html) on Experience League.

**Path parameters:**
- `COMPANY_ID` **(required)** — The ID of the company whose app configurations you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `app_id` — Filter by `app_id`.
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `key_type` — Filter by `key_type`.
- `messaging_service` — Filter by `messaging_service`.
- `name` — Filter by `name`.
- `platform` — Filter by `platform`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}` — Retrieve a property

>**NOTE**: For more information on using this operation, see the [properties endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/properties.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /app_configurations/{CONFIG_ID}` — Retrieve an app configuration

>**NOTE**: For more information on using this operation, see the [app configurations endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/app-configurations.html) on Experience League.

**Path parameters:**
- `CONFIG_ID` **(required)** — The ID of the app configuration you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /app_configurations/{CONFIG_ID}/company` — Retrieve the company that owns an app configuration

Retrieve the company that owns an app configuration

**Path parameters:**
- `CONFIG_ID` **(required)** — The ID of the app configuration whose company you want to look up.

**`Accept`:** `application/vnd.api+json;revision=1`

### `GET /properties/{PROPERTY_ID}/company` — Retrieve the company that owns a property

>**NOTE**: For more information on using this operation, see the [properties endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/properties.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose company you want to look up.

**`Accept`:** `application/vnd.api+json;revision=1`

### `GET /properties/{PROPERTY_ID}/callbacks` — List a property's callbacks

>**NOTE**: For more information on using this operation, see the [callbacks endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/callbacks.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose callbacks you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/data_elements` — List a property's data elements

>**NOTE**: For more information on using this operation, see the [data elements endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/data-elements.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose data elements you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `published_at` — Filter by `published_at` timestamp.
- `published` — Filter by `published` status.
- `enabled` — Filter by `enabled`.
- `name` — Filter by `name`.
- `origin_id` — Filter by `origin_id`.
- `revision_number` — Filter by `revision_number`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/environments` — List a property's environments

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose environments you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `stage` — Filter by `stage`.
- `token` — Filter by `token`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/extensions` — List a property's extensions

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose extensions you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `display_name` — Filter by `display_name`.
- `enabled` — Filter by `enabled`.
- `origin_id` — Filter by `origin_id`.
- `published` — Filter by `published` status.
- `published_at` — Filter by `published_at` timestamp.
- `revision_number` — Filter by `revision_number`.
- `version` — Filter by `version`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/hosts` — List a property's hosts

>**NOTE**: For more information on using this operation, see the [hosts endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/hosts.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose hosts you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `display_name` — Filter by `display_name`.
- `enabled` — Filter by `enabled`.
- `origin_id` — Filter by `origin_id`.
- `published` — Filter by `published` status.
- `published_at` — Filter by `published_at` timestamp.
- `revision_number` — Filter by `revision_number`.
- `version` — Filter by `version`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/libraries` — List a property's libraries

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose libraries you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `stale` — Filter by `stale` status. A library becomes stale when another library on the [upstream](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/publishing-flow.html#upstream) has bee...
- `state` — Filter by `state`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/rules` — List a property's rules

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose rules you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `dirty` — Filter by `dirty` (whether the resource contains changes that haven't been pushed to a library).
- `enabled` — Filter by `enabled`.
- `name` — Filter by `name`.
- `origin_id` — Filter by `origin_id`.
- `published` — Filter by `published` status.
- `published_at` — Filter by `published_at` timestamp.
- `revision_number` — Filter by `revision_number`.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/secrets` — List a property's secrets

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose secrets you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `environment_id` — Filter by `environment_id`.
- `name` — Filter by `name`.
- `status` — Filter by `status`.
- `type_of` — Filter by `type`.
- `updated_at` — Filter by `updated_at` timestamp.

### `GET /callbacks/{CALLBACK_ID}` — Retrieve a callback

>**NOTE**: For more information on using this operation, see the [callbacks endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/callbacks.html) on Experience League.

**Path parameters:**
- `CALLBACK_ID` **(required)** — The ID of the callback you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /data_elements/{DATA_ELEMENT_ID}` — Retrieve a data element

>**NOTE**: For more information on using this operation, see the [data elements endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/data-elements.html) on Experience League.

**Path parameters:**
- `DATA_ELEMENT_ID` **(required)** — The ID of the data element you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /environments/{ENVIRONMENT_ID}` — Retrieve an environment

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /secrets/{SECRET_ID}` — Retrieve a secret

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `SECRET_ID` **(required)** — The ID of the secret you want to look up.

### `GET /environments/{ENVIRONMENT_ID}/builds` — List an environment's builds

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose related builds you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /environments/{ENVIRONMENT_ID}/secrets` — List an environment's secrets

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose related secrets you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

### `GET /environments/{ENVIRONMENT_ID}/host` — Retrieve a host

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose host you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /environments/{ENVIRONMENT_ID}/relationships/host` — Retrieve the host relationship for an environment

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose host relationship you want to retrieve.

**`Accept`:** `{{Accept}}`

### `GET /environments/{ENVIRONMENT_ID}/library` — Retrieve an environment's related library

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose related library you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /environments/{ENVIRONMENT_ID}/property` — Retrieve the property that owns an environment

>**NOTE**: For more information on using this operation, see the [environments endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/environments.html) on Experience League.

**Path parameters:**
- `ENVIRONMENT_ID` **(required)** — The ID of the environment whose related property you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extension_packages` — List extension packages

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `name` — Filter by `name`.
- `display_name` — Filter by `display_name`.
- `status` — Filter by `status`.
- `platform` — Filter by `platform`.
- `version` — Filter by `version`.

**`Accept`:** `{{Accept}}`

### `GET /extension_packages/{EXTENSION_PACKAGE_ID}` — Retrieve an extension package

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

**Path parameters:**
- `EXTENSION_PACKAGE_ID` **(required)** — The ID of the extension package you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extension_packages/{EXTENSION_PACKAGE_ID}/versions` — Retrieve an extension package's versions

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

**Path parameters:**
- `EXTENSION_PACKAGE_ID` **(required)** — The ID of the extension package whose versions you want to retrieve.

**`Accept`:** `{{Accept}}`

### `GET /extension_packages/{EXTENSION_PACKAGE_ID}/extension_package_usage_authorizations` — Retrieve extension package usage authorizations for an extension package

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

**Path parameters:**
- `EXTENSION_PACKAGE_ID` **(required)** — The ID of the extension package you want to retrieve.

### `GET /extension_package_usage_authorizations` — Retrieve a list of extension package usage authorizations

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

### `GET /extension_package_usage_authorizations/{EXTENSION_PACKAGE_USAGE_AUTHORIZATION_ID}/extension_package` — Retrieve data for the extension package for an extension package usage authorization

>**NOTE**: For more information on using this operation, see the [extension packages endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extension-packages.html) on Experience League.

**Path parameters:**
- `EXTENSION_PACKAGE_USAGE_AUTHORIZATION_ID` **(required)** — The ID of the extension package usage authorization you want to retrieve.

### `GET /extensions/{EXTENSION_ID}` — Retrieve an extension

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extensions/{EXTENSION_ID}/extension_package` — Retrieve the extension package for an extension

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose extension package you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extensions/{EXTENSION_ID}/libraries` — List the libraries that use an extension

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose libraries you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /extensions/{EXTENSION_ID}/property` — Retrieve an extension's property

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose property you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extensions/{EXTENSION_ID}/origin` — Retrieve an extension's origin

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose origin you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /extensions/{EXTENSION_ID}/revisions` — List an extension's revisions

>**NOTE**: For more information on using this operation, see the [extensions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/extensions.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose revisions you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /hosts/{HOST_ID}` — Retrieve a host

>**NOTE**: For more information on using this operation, see the [hosts endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/hosts.html) on Experience League.

**Path parameters:**
- `HOST_ID` **(required)** — The ID of the host you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /hosts/{HOST_ID}/property` — Retrieve a host's property

>**NOTE**: For more information on using this operation, see the [hosts endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/hosts.html) on Experience League.

**Path parameters:**
- `HOST_ID` **(required)** — The ID of the host whose property you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}` — Retrieve a library

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/property` — Retrieve a library's property

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose related property you want to retrieve.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/builds` — List a library's builds

>**NOTE**: For more information on using this operation, see the [builds endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/builds.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose builds you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `status` — Filter by `status`.
- `token` — Filter by `token`.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/environment` — Retrieve a library's related environment

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose related environment you want to retrieve.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/upstream_library` — Retrieve a library's upstream library

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose upstream library you want to retrieve.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/data_elements` — List a library's related data elements

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose related data elements you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/relationships/data_elements` — List a library's data element relationships

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose data element relationships you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/relationships/environment` — Retrieve a library's environment relationship

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose environment relationship you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/extensions` — List a library's related extensions

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose related extensions you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/relationships/extensions` — List a library's extension relationships

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose extension relationships you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/rules` — List a library's related rules

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose related rules you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/relationships/rules` — List a library's rule relationships

>**NOTE**: For more information on using this operation, see the [libraries endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/libraries.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose rule relationships you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /builds/{BUILD_ID}` — Look up a build by ID.

>**NOTE**: For more information on using this operation, see the [builds endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/builds.html) on Experience League.

**Path parameters:**
- `BUILD_ID` **(required)** — The ID of the build you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}` — Retrieve a rule

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/rule_components` — List a rule's components

>**NOTE**: For more information on using this operation, see the [rule components endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rule-components.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose rule components you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `dirty` — Filter by `dirty` (whether the resource contains changes that haven't been pushed to a library).
- `enabled` — Filter by `enabled`.
- `name` — Filter by `name`.
- `negate` — Filter by `negate` (whether the rule component represents a negation).
- `origin_id` — Filter by `origin_id`.
- `published` — Filter by `published` status.
- `published_at` — Filter by `published_at` timestamp.
- `revision_number` — Filter by `revision_number`.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/libraries` — List all libraries that use a specific rule

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose related libraries you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/property` — Retrieve the property that owns a specific rule

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose property you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/origin` — Retrieve a rule's related origin

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose origin you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/revisions` — List a rule's revisions

>**NOTE**: For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose revisions you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/rule_component_notes` — List the notes for a rule's components

>**NOTE**: Notes attached directly to the rule itself are not included in results for this endpoint. > >For more information on using this operation, see the [rules endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rules.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose rule component notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /rule_components/{RULE_COMPONENT_ID}` — Retrieve a rule component

>**NOTE**: For more information on using this operation, see the [rule components endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rule-components.html) on Experience League.

**Path parameters:**
- `RULE_COMPONENT_ID` **(required)** — The ID of the rule component you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /rule_components/{RULE_COMPONENT_ID}/extension` — Look up the extension that provides a specific rule component.

>**NOTE**: For more information on using this operation, see the [rule components endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rule-components.html) on Experience League.

**Path parameters:**
- `RULE_COMPONENT_ID` **(required)** — The ID of the rule component whose extension you want to look up.

**Query parameters:**
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /rule_components/{RULE_COMPONENT_ID}/origin` — Retrieve a rule component's origin

>**NOTE**: For more information on using this operation, see the [rule components endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rule-components.html) on Experience League.

**Path parameters:**
- `RULE_COMPONENT_ID` **(required)** — The ID of the rule component whose origin you want to look up.

**Query parameters:**
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /rule_components/{RULE_COMPONENT_ID}/rules` — List the rules that utilize a rule component

>**NOTE**: For more information on using this operation, see the [rule components endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/rule-components.html) on Experience League.

**Path parameters:**
- `RULE_COMPONENT_ID` **(required)** — The ID of the rule component whose related rules you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /notes/{NOTE_ID}` — Retrieve a note

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `NOTE_ID` **(required)** — The ID of the note you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /properties/{PROPERTY_ID}/notes` — List a property's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `PROPERTY_ID` **(required)** — The ID of the property whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /data_elements/{DATA_ELEMENT_ID}/notes` — List a data element's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `DATA_ELEMENT_ID` **(required)** — The ID of the data element whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `application/vnd.api+json;revision=1`

### `GET /secrets/{SECRET_ID}/notes` — List a secret's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `SECRET_ID` **(required)** — The ID of the secret whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

### `GET /secrets/{SECRET_ID}/data_elements` — List the data elements that reference a secret

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `SECRET_ID` **(required)** — The ID of the secret whose data elements you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `dirty` — Filter by `dirty` (whether the resource contains changes that haven't been pushed to a library).
- `enabled` — Filter by `enabled`.
- `name` — Filter by `name`.
- `origin_id` — Filter by `origin_id`.
- `published` — Filter by `published` status.
- `published_at` — Filter by `published_at` timestamp.
- `revision_number` — Filter by `revision_number`.
- `updated_at` — Filter by `updated_at` timestamp.

### `GET /secrets/{SECRET_ID}/environment` — Retrieve a secret's environment

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `SECRET_ID` **(required)** — The ID of the secret whose environment you want to retrieve.

### `GET /secrets/{SECRET_ID}/property` — Retrieve a secret's property

>**NOTE**: For more information on using this operation, see the [secrets endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/secrets.html) on Experience League.

**Path parameters:**
- `SECRET_ID` **(required)** — The ID of the secret whose property you want to retrieve.

### `GET /extensions/{EXTENSION_ID}/notes` — List an extension's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `EXTENSION_ID` **(required)** — The ID of the extension whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...

**`Accept`:** `{{Accept}}`

### `GET /libraries/{LIBRARY_ID}/notes` — List a library's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `LIBRARY_ID` **(required)** — The ID of the library whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /rules/{RULE_ID}/notes` — List a rule's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `RULE_ID` **(required)** — The ID of the rule whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /rule_components/{RULE_COMPONENT_ID}/notes` — List a rule component's notes

>**NOTE**: For more information on using this operation, see the [notes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/notes.html) on Experience League.

**Path parameters:**
- `RULE_COMPONENT_ID` **(required)** — The ID of the rule component whose notes you want to list.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `text` — Filter by `text`.

**`Accept`:** `{{Accept}}`

### `GET /audit_events` — List audit events

>**NOTE**: For more information on using this operation, see the [audit events endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/audit-events.html) on Experience League.

**Query parameters:**
- `page[size]` (default `25`) — Limits the number of results per page (for example, `page[size]=50`). Can be used in conjunction with `page[number]` to manage response pagination.
- `page[number]` (default `1`) — The page index to return for the listing response (for example, `page[number]=2`). Can be used in conjunction with `page[size]` to manage response pagination. >**NOTE**: Responses for listing calls co...
- `created_at` — Filter by `created_at` timestamp.
- `updated_at` — Filter by `updated_at` timestamp.
- `type_of` — Filter by `type`.

**`Accept`:** `{{Accept}}`

### `GET /audit_events/{EVENT_ID}` — Retrieve an audit event

>**NOTE**: For more information on using this operation, see the [audit events endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/audit-events.html) on Experience League.

**Path parameters:**
- `EVENT_ID` **(required)** — The ID of the audit event you want to look up.

**`Accept`:** `{{Accept}}`

### `GET /profile` — Retrieve the details of the currently logged-in user

>**NOTE**: For more information on using this operation, see the [profile endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/tags/api/endpoints/profile.html) on Experience League.

**`Accept`:** `{{Accept}}`

