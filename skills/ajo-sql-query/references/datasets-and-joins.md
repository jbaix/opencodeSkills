# Datasets, joins y semántica

Catálogo de los datasets de sistema de AJO documentados en [EXPLORE 300](https://data-distilller.gitbook.io/adobe-data-distiller-guide/unit-2-data-distiller-data-exploration/explore-300-exploring-adobe-journey-optimizer-system-datasets-with-data-distiller), cómo se relacionan y cuándo usar cada uno.

## Cómo encajan (orden de proceso)

```
ajo_entity_dataset  (metadatos: campaña, journey, mensaje, canal, versión)
        │
        ├── journey_step_events        (progreso y errores de cada paso)
        │
        ├── ajo_message_feedback_event_dataset   (intento de entrega: sent/delivered/bounce/error/exclude)
        │        └── ajo_bcc_feedback_event_dataset  (solo copias BCC/CC)
        │
        ├── ajo_email_tracking_experience_event_dataset  (opens, clicks, unsubscribes)
        ├── ajo_push_tracking_experience_event_dataset   (push y SMS: opens, clicks, launches)
        │
        └── ode_decisionevents_{key}   (ofertas/proposiciones y outcome)
```

`ajo_entity_dataset` es el **lookup central**: aporta los nombres y la estructura que los demás datasets solo referencian por ID. Úsalo **solo** cuando necesites esos nombres/estructura (o filtrar por ellos); para agrupar o filtrar por `campaignID`, `messageID` o `journeyActionID` no hace falta cruzar nada.

## Catálogo de datasets

| Dataset | Qué contiene | Grano | Clave principal | Úsalo para | No lo uses para |
| --- | --- | --- | --- | --- | --- |
| `ajo_entity_dataset` | Metadatos de campaña, journey, mensaje, canal, versión, experimento, tags | Una fila por versión/publicación de mensaje, **con histórico** (varias filas por `messageID`) | `...entities.channelDetails.messageID` | Nombres de campaña/journey, nodo, canal, asunto, versión, A/B test, tags | Métricas de entrega o engagement (solo estructura/metadatos) |
| `journey_step_events` | Eventos de paso del journey: transiciones, errores, timeouts, tiempos | Una fila por evento de paso y perfil | `...stepEvents.actionID` | Embudo por paso, errores, tiempos de ejecución, segmentos de entrada | Entregas de mensajes o engagement |
| `ajo_message_feedback_event_dataset` | Feedback de entrega de email, push y SMS | Una fila por intento/evento de entrega | `...messageExecution.messageID` | Enviados, entregados, bounces, motivos de fallo, reintentos, exclusiones | Aperturas/clics/unsubscribes (usa tracking) |
| `ajo_bcc_feedback_event_dataset` | Entrega de copias BCC/CC y exclusiones | Una fila por evento de feedback de copia secundaria | `...messageExecution.messageID` | Compliance, archivado, exclusiones de copias BCC/CC | Métricas generales de campaña |
| `ajo_email_tracking_experience_event_dataset` | Interacciones con emails | Una fila por evento de interacción | `...messageExecution.messageID` | Opens, clicks, unsubscribes, landing pages, ofertas, URLs | Estado de entrega (usa feedback) |
| `ajo_push_tracking_experience_event_dataset` | Interacciones con push y SMS | Una fila por evento de interacción | `...messageExecution.messageID` | Opens, clicks, dismiss, launches, custom actions, rich media | Estado de entrega (usa feedback) |
| `ode_decisionevents_{key}` | Decisiones y proposiciones de ofertas | Una fila por evento de decisión, con arrays de proposiciones/selecciones | `_experience.decisioning...` + `identityMap` | Ofertas servidas, placements, estrategias, outcome | Entrega del mensaje que contiene la oferta |

> **Nombre del dataset de entidad:** la página usa `ajo_entity_dataset` en su SQL, pero el texto de introducción lo llama `ajo_event_dataset`. El nombre operativo es `ajo_entity_dataset`. Si la query falla por tabla inexistente, valida con el patrón 1.

## ¿Hace falta un join?

Primero elige el dataset que ya contiene la respuesta. Añade otro solo si falta un campo o un filtro.

| Petición | Dataset(s) | ¿Join? |
| --- | --- | --- |
| Entregas, bounces, errores o exclusiones por campaña/mensaje | `ajo_message_feedback_event_dataset` | No |
| Aperturas, clics o unsubscribes de email | `ajo_email_tracking_experience_event_dataset` | No |
| Aperturas, clics o launches de push y SMS | `ajo_push_tracking_experience_event_dataset` | No |
| Progreso, errores o tiempos por paso de journey | `journey_step_events` | No |
| Ofertas, placements o proposiciones | `ode_decisionevents_{key}` | No |
| Entrega **y** interacción en la misma tabla | feedback + tracking | Sí, por `messageID` |
| Métricas junto al **nombre** de campaña/journey, asunto o canal | métricas + `ajo_entity_dataset` | Sí, entidad deduplicada |
| Filtrar por nombre de campaña/journey/tag (sin conocer el ID) | métricas + `ajo_entity_dataset` | Sí, entidad deduplicada |

Regla: si el join no aporta una columna al `SELECT` ni un filtro, no lo hagas. Agrupar o filtrar por `campaignID`, `messageID`, `journeyActionID` o `sourceType` **no requiere** `ajo_entity_dataset`.

## Claves de join

Documentadas en la página:

| Desde | Campo | Hacia | Campo |
| --- | --- | --- | --- |
| `ajo_entity_dataset` | `_experience.customerJourneyManagement.entities.channelDetails.messageID` | Feedback y tracking | `_experience.customerJourneyManagement.messageExecution.messageID` |
| `ajo_entity_dataset` | `_experience.customerJourneyManagement.entities.journey.journeyActionID` | `journey_step_events` | `_experience.journeyOrchestration.stepEvents.actionID` |
| `ajo_entity_dataset` | (según la página) `_experience.decisioning.propositions.items.scopeDetails.placement.id` | ODE | placement de la proposición |

Reglas prácticas:

- **Feedback ↔ tracking**: únelos por `messageID` (ambos exponen `messageExecution.messageID`). Es la unión más segura y la que permite el funnel completo.
- **Entidad → cualquier dataset**: únela **deduplicada** por `messageID`; si no, multiplicarás filas. Úsala solo si necesitas sus columnas (nombres, canal, asunto, tags) o filtrar por ellas.
- **Journey steps**: `actionID` puede repetirse entre perfiles y ejecuciones; el join es a nivel de acción de journey, no de mensaje. Agrega por `journeyActionID`/`actionID` y no esperes 1:1.
- **ODE**: la página indica `placement.id`, que **no identifica un mensaje** (un placement se reutiliza). Si necesitas atribuir una oferta a un mensaje concreto, busca `propositionID`/`messageID` en los datos y valida con una muestra. Para análisis de ofertas, trabaja dentro de ODE.
- **Nunca** unas eventos por `_id` ni por `timestamp`: son del evento, no del mensaje.
- Cuida la cardinalidad antes de agregar: un mensaje puede tener varios eventos de feedback (reintentos, cambios de estado) y varios eventos de tracking (varias aperturas).

## Deduplicar `ajo_entity_dataset`

Es un lookup **timestamped**: los metadatos cambian cuando alguien edita y republica la campaña/journey. La versión vigente es la de mayor `timestamp` por `messageID`.

> La ventana temporal de la entidad debe cubrir la **fecha de publicación** del mensaje, que puede ser anterior a la ventana de feedback/tracking. Si analizas los últimos 30 días de engagement (`timestamp >= CURRENT_TIMESTAMP - INTERVAL '30' DAY`), filtra `ajo_entity_dataset` con al menos `CURRENT_TIMESTAMP - INTERVAL '180' DAY` (o sin filtro si el volumen lo permite).

```sql
WITH entity_latest AS (
    SELECT
        e.*,
        ROW_NUMBER() OVER (
            PARTITION BY e._experience.customerJourneyManagement.entities.channelDetails.messageID
            ORDER BY e.timestamp DESC
        ) AS rn
    FROM ajo_entity_dataset e
    WHERE e.timestamp >= CURRENT_TIMESTAMP - INTERVAL '180' DAY
)
SELECT *
FROM entity_latest
WHERE rn = 1
LIMIT 50
```

El patrón completo (con join a feedback) está en `query-patterns.md` (patrón 2 y 4).

> El snippet anterior es de inspección: en la entrega final sustituye `e.*` y `SELECT *` por las columnas necesarias (patrón 2).

## Identidad

`identityMap` es un mapa de identidades, no un struct plano:

- acceso típico: `identityMap.<namespace>[0].id` (por ejemplo `identityMap.customerid[0].id`);
- `identityMap.<namespace>[0].primary` indica la identidad preferida;
- el namespace (`customerid`, `email`, `ecid`, `phone`...) depende de tu sandbox;
- en el diccionario y en algunas tablas aparece como `identityMap.additionalProperties.items.id` / `.primary` (representación serializada del mapa). Para SQL, usa la forma `identityMap.<namespace>[0].id` que aparece en los ejemplos de la página.

## Nombres de datasets y entorno

- Los nombres van en minúsculas y son específicos del **sandbox**.
- ODE incluye un sufijo del entorno: `ode_decisionevents_{key}`. No inventes la key: deja el placeholder y pide al usuario que lo reemplace.
- Si un dataset no existe, AJO puede no estar aprovisionado en ese sandbox.
- Validación rápida (patrón 1):

```sql
SELECT DISTINCT table_name
FROM information_schema.columns
WHERE table_name LIKE 'ajo%' OR table_name LIKE 'ode%'
ORDER BY table_name
LIMIT 50
```

## Mapa pregunta → dataset y campo

| Pregunta típica | Dataset | Campo(s) |
| --- | --- | --- |
| ¿Cuántos mensajes se enviaron? | feedback | `messageDeliveryfeedback.feedbackStatus = 'sent'` |
| ¿Se entregaron? / tasa de entrega | feedback | `feedbackStatus = 'delivered'` vs `'sent'` |
| ¿Bounces y por qué? | feedback | `feedbackStatus = 'bounce'`, `messageFailure.type` (soft/hard), `.category` (sync/async), `.reason`, `.code` |
| ¿Fallos de procesamiento? | feedback | `feedbackStatus = 'error'` |
| ¿Exclusiones por typology/compliance? | feedback / BCC | `messageDeliveryfeedback.messageExclusion.code` / `.reason` |
| ¿Reintentos? | feedback | `messageDeliveryfeedback.retryCount` |
| ¿Aperturas de email? | email tracking | `messageInteraction.openCount`, `eventType` |
| ¿Clics y qué enlace? | email tracking | `messageInteraction.clickCount`, `.urlID`, `.label` |
| ¿Unsubscribes? | email tracking | `messageInteraction.unsubscribe` |
| ¿Landing pages? | email/push tracking | `messageInteraction.landingPage.landingPageID` / `.landingPageName` |
| ¿Push abierto / app lanzada? | push tracking | `messageInteraction.openCount`, `pushNotificationTracking.isLaunch` |
| ¿Acciones custom de push? | push tracking | `pushNotificationTracking.customAction.actionID` |
| ¿Proveedor push? | push tracking | `pushChannelContext.pushProvider`, `.deviceToken` |
| ¿SMS enviado/entregado? | feedback / push tracking | `messageExecution.messageID` + campos `smsChannelContext.*` |
| ¿Nombre de campaña/journey de un mensaje? | entity | `entities.campaign.name`, `entities.journey.journeyName`, `.journeyNodeName` |
| ¿Canal del mensaje? | entity | `entities.channelDetails.channel` |
| ¿A/B test y variante? | entity | `entities.experiment.experimentId`, `.treatmentName` |
| ¿Send-time optimization? | entity / feedback | `messageProfile.isSendTimeOptimized` |
| ¿Ejecuciones de prueba? | entity / feedback / tracking | `messageProfile.isTestExecution` |
| ¿Pasos, errores, timeouts? | journey steps | `stepEvents.stepName`, `.stepStatus`, `.processingTime`, `.actionExecutionTime` |
| ¿Segmento de entrada del journey? | journey steps | `stepEvents.segmentExportJob.exportSegmentID` |
| ¿Ofertas servidas por placement? | ODE | `decisioning.propositionDetails.items.placement.id` (ver notas de ODE) |
| ¿Estrategia/algoritmo de decisión? | ODE | `propositions.items.scopeDetails.strategies.items.algorithmID` |
| ¿Outcome de la oferta? | ODE | `propositions.items.scopeDetails.interactionMeasurements.items.outcome` |

## Semántica de estados (enums)

`feedbackStatus` (`...messageDeliveryfeedback.feedbackStatus`):

| Valor | Significado |
| --- | --- |
| `sent` | Mensaje enviado |
| `delivered` | Mensaje entregado |
| `bounce` | Mensaje rebotado |
| `error` | Fallo al procesar el mensaje |
| `exclude` | Perfil filtrado/excluido (typology, compliance) |
| `delay` | Mensaje retrasado |
| `duplicate` | Mensaje duplicado omitido |
| `denylist` | Destino inválido omitido |
| `read` | Mensaje leído |
| `unknown` | Estado desconocido |

`messageFailure.type`: `soft` (temporal) / `hard` (permanente).
`messageFailure.category`: `sync` (fallo síncrono) / `async` (fallo asíncrono).
`messageType`: `marketing` / `transactional`.
`channelType` (`_experience.decisioning.channelType`): `code`, `email`, `sms`, `directMail`, `push`, `web`, `whatsApp`, `contentCard`, `inapp`.
`sourceType` (`messageExecution.parentSourceMeta.sourceType`): `orchestratedCampaign`, `singleStepCampaign`, `journey`.

`eventType` y `stepStatus` tienen muchos valores y pueden variar: **no los hardcodees sin comprobarlos**. Usa el patrón 1b para listar los valores reales del sandbox.

## Rendimiento y coste

- Filtra siempre por `timestamp` al principio: reduce el volumen antes de joins y `EXPLODE`. Para ventanas relativas usa `CURRENT_TIMESTAMP - INTERVAL 'N' DAY|HOUR|WEEK|MONTH`; no calcules fechas a mano.
- Selecciona solo las columnas necesarias (nada de `SELECT *` en la entrega final).
- Deduplica la entidad **después** de filtrar por fecha y, si es posible, por los `messageID` que interesan.
- Explota arrays (`propositionDetails`, `selections`) solo cuando los necesites: multiplican filas.
- Evita `COUNT(DISTINCT ...)` sobre columnas anidadas de alta cardinalidad si puedes agregar antes en una CTE.
- Los datasets de tracking pueden ser mucho más grandes que feedback: aplícales primero el rango temporal y el filtro de campaña/mensaje.

## Limitaciones de la fuente

- La página documenta **campos clave**, no el esquema completo de cada dataset. El diccionario exhaustivo incluido cubre solo el esquema de *message feedback*.
- Algunas rutas de la página son aproximadas o cambian entre versiones del esquema (especialmente ODE y `journey.ID`).
- Cuando un campo no esté en `fields.md` ni en el diccionario, **no lo inventes**: entrega una query de descubrimiento con `information_schema.columns` o `SELECT to_json(...)`.

## Discrepancias conocidas de la fuente

| Tema | Lo que dice la página | Lo que conviene hacer |
| --- | --- | --- |
| Nombre del dataset de entidad | `ajo_event_dataset` en la introducción; `ajo_entity_dataset` en el SQL | Usa `ajo_entity_dataset`; si falla, descubre el nombre real (patrón 1a). |
| Push provider | `pushChannelContext.pushProvider` | El diccionario oficial expone `pushChannelContext.platform`; prueba ambas y valida con `information_schema.columns`. |
| Teléfono SMS | `smsChannelContext.address` | El diccionario usa `smsChannelContext.profileNumber`; confirma cuál existe en tu sandbox. |
| ODE | `propositionDetails` en la tabla y en los `EXPLODE`; `propositions.items.scopeDetails.*` en el diccionario | Son esquemas/versiones distintas: no mezcles rutas. Inspecciona con `to_json(_experience.decisioning)`. |
| Ejemplos ODE sin `EXPLODE` | Algunos ejemplos usan `proposition.activity.name` sobre la tabla base | `propositionDetails` es un array: en SQL fiable, explota primero y luego accede a `proposition.activity.*`. |
| `journey.ID` | Aparece como `_experience.journeyOrchestration.journey.ID` | Algunos tenants exponen `journey.journeyID`; valida antes de usar. |
| `_id` en journey steps | La tabla lo asocia a `stepEvents.stepID` | Es el ID del evento de paso, no el `messageID`; no lo uses para unir con feedback/tracking. |

