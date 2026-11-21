# Schema Registry (XDM)

All endpoints below are **GET**. Send on every request:
`Authorization: Bearer <ACCESS_TOKEN>`, `x-api-key: <API_KEY>`, `x-gw-ims-org-id: <ORG_ID>`,
`x-sandbox-name: <SANDBOX>` (Platform services only), plus the endpoint `Accept` header.

## Schema Registry API

*Use the Schema Registry API to access the Schema Library within Adobe Experience Platform. The registry provides a user interface and RESTful API from which all available library resources are accessible. Programmatically manage all schemas and related Experience Data Model (XDM) resources available to you within Platform. This includes those defined by Adobe, Experience Platform partners, and vendors whose applicati...*

- **Host:** `https://platform.adobe.io`
- **Docs:** https://developer.adobe.com/experience-platform-apis/references/schema-registry

### `GET /data/foundation/schemaregistry/stats` — Retrieve your tenant ID and other usage information related to the Schema Registry.

**`Accept`:** `application/json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/fieldgroups` — List field groups

Retrieve a list of field groups within the specified container. >**NOTE**: For more information on using this operation, see the [field groups endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/field-groups.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/fieldgroups/{FIELD_GROUP_ID}` — Retrieve a field group

>**NOTE**: For more information on using this operation, see the [field groups endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/field-groups.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `FIELD_GROUP_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the field group you want to look up.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/schemas` — List schemas

You can list schemas within the global or tenant container by performing a GET request. To help filter results, the Schema Registry supports the use of query parameters when listing resources. >**NOTE**: For more information on using this operation, see the [schemas endpoint guide](https://experienc...

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/schemas/{SCHEMA_ID}` — Retrieve a schema

>**NOTE**: For more information on using this operation, see the [schemas endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/schemas.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `SCHEMA_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the schema in question.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/global/behaviors` — List behaviors

>**NOTE**: For more information on using this operation, see the [behaviors endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/behaviors.html) on Experience League.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/global/behaviors/{BEHAVIOR_ID}` — Retrieve a behavior

>**NOTE**: For more information on using this operation, see the [behaviors endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/behaviors.html) on Experience League.

**Path parameters:**
- `BEHAVIOR_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the behavior in question.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/mixins` — List all mixins

**NOTE**: This endpoint is deprecated. For future implementations, please use the [equivalent operation](#operation/listFieldGroups) for the field groups endpoint instead.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/mixins/{MIXIN_ID}` — Retrieve a mixin

**NOTE**: This endpoint is deprecated. For future implementations, please use the [equivalent operation](#operation/retrieveFieldGroup) for the field groups endpoint instead.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `MIXIN_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the mixin in question.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/classes` — List classes

>**NOTE**: For more information on using this operation, see the [classes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/classes.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/classes/{CLASS_ID}` — Retrieve a class

>**NOTE**: For more information on using this operation, see the [classes endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/classes.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `CLASS_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the class you want to look up.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/datatypes` — List data types

>**NOTE**: For more information on using this operation, see the [data types endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/data-types.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/datatypes/{DATA_TYPE_ID}` — Retrieve a data type

>**NOTE**: For more information on using this operation, see the [data types endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/data-types.html) on Experience League.

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `DATA_TYPE_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the data type in question.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/descriptors` — List descriptors

Schemas define a static view of data entities, but do not provide specific details on how data based on these schemas (datasets) may relate to one another. Platform allows you to describe these relationships and other interpretive metadata about a schema through the use of descriptors. Descriptors a...

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to list resources from. To list core resources provided by Adobe, use `global`. To list custom resources defined by your organization, use `tenant`.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort response by specified fields separated by "," and/or prefix field with "-" for descending order. Used by the v2 option of the API, as indicated by the `Accept` header.
- `limit` — Specify a limit for the number of response results to be displayed (must be between 0 and 500). Used by the v2 option of the API, as indicated by the `Accept` header.
- `start` — The start value of the first `orderBy` field. The value of this parameter be the same data type as that of the `orderBy` field (e.g. strings or integers). Used by the v2 option of the API, as indicate...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/{CONTAINER_ID}/descriptors/{DESCRIPTOR_ID}` — Retrieve a descriptor

View the details of a specific descriptor by performing a lookup (GET) request using the `@id` of the descriptor. Descriptors are not versioned, therefore no `Accept` header is required in the lookup request. >**NOTE**: For more information on using this operation, see the [descriptors endpoint guid...

**Path parameters:**
- `CONTAINER_ID` **(required)** — The name of the container that you want to retrieve a resource from. To retrieve a core resource provided by Adobe, use `global`. To retrieve a custom resource defined by your organization, use `tenan...
- `DESCRIPTOR_ID` **(required)** — The unique ID (`@id`) of the descriptor in question.

**`Accept`:** `application/json`

### `GET /data/foundation/schemaregistry/tenant/unions` — List union schemas

>**NOTE**: For more information on using this operation, see the [unions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/unions.html) on Experience League.

**Query parameters:**
- `property` — A comma-separated list of top-level object properties to be returned in the response. For example, `property=meta:intendedToExtend==https://ns.adobe.com/xdm/context/profile` returns only field groups ...
- `orderby` — Sort the listed resources by specified fields. For example `orderby=title` sorts results by title in ascending order (A-Z). Adding a `-` before the field name (`orderby=-title`) sorts items in descend...
- `start` — When used in conjunction with an `orderby` parameter, `start` specifies where the paginated list of items should begin. This parameter cannot be used without an `orderby` parameter present. Typically,...
- `limit` — When used in conjunction with an `orderby` parameter, `limit` restricts the maximum number of items that should be returned for a given request. This parameter cannot be used without an `orderby` para...

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/tenant/unions/{UNION_ID}` — Retrieve a union schema

>**NOTE**: For more information on using this operation, see the [unions endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/unions.html) on Experience League.

**Path parameters:**
- `UNION_ID` **(required)** — The `meta:altId` or URL-encoded `$id` of the union schema in question.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/rpc/export/{RESOURCE_ID}` — Retrieve an export payload

You can use this endpoint to retrieve an export payload for a specific resource in order to transfer it into a different sandbox or IMS Organization. >**NOTE**: For more information on using this operation, see the [export](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/export.h...

**Path parameters:**
- `RESOURCE_ID` **(required)** — The `meta:altId` or URL-encoded `$id` value of the schema, field group, or data type you want to export.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/rpc/sampledata/{SCHEMA_ID}` — Retrieve sample data

Retrieve sample data for a schema. >**NOTE**: For more information on using this operation, see the [sample data endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/sample-data.html) on Experience League.

**Path parameters:**
- `SCHEMA_ID` **(required)** — The `meta:altId` or URL-encoded `$id` value of the schema you want to generate sample data for.

**`Accept`:** `application/vnd.adobe.xed-id+json`

### `GET /data/foundation/schemaregistry/rpc/auditlog/{RESOURCE_ID}` — Retrieve a resource's audit log

This endpoint retrieves a resource's audit log, which shows a list of all the changes made to the resource. >**NOTE**: For more information on using this operation, see the [audit log endpoint guide](https://experienceleague.adobe.com/docs/experience-platform/xdm/api/audit-log.html) on Experience Le...

**Path parameters:**
- `RESOURCE_ID` **(required)** — The `meta:altId` or URL-encoded `$id` value of the resource whose changes you wish to view.

**`Accept`:** `application/json`

