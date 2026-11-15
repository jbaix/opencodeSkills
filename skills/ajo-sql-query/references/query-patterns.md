# Patrones SQL (Spark SQL / AEP Query Service)

Plantillas listas para adaptar. Sustituye los valores entre `{...}` y ajusta fechas, filtros y nombres de campo a tu sandbox. Basadas en [EXPLORE 300](https://data-distilller.gitbook.io/adobe-data-distiller-guide/unit-2-data-distiller-data-exploration/explore-300-exploring-adobe-journey-optimizer-system-datasets-with-data-distiller) y en las rutas de `fields.md`.

Reglas comunes:

- **Usa el mínimo número de datasets.** Si una sola tabla contiene todo lo pedido, no hagas join. `ajo_entity_dataset` solo hace falta si se muestran o filtran nombres de campaña/journey, asunto, canal o tags.
- El `LIMIT 50` va **solo en el `SELECT` final** (también en agregaciones). No lo pongas en CTEs ni subconsultas.
- Filtra siempre por `timestamp` al principio para reducir el volumen antes de joins y `EXPLODE`.
- No unas datasets de eventos entre sí por `_id` ni por `timestamp`: usa `messageID`, `journeyActionID`/`actionID` o IDs de proposición.
- Deduplica `ajo_entity_dataset` por `messageID` antes de unirlo (patrón 2).
- Si la ventana de análisis es corta (p. ej. 30 días de aperturas), amplía la ventana de `ajo_entity_dataset` hacia atrás (`INTERVAL '180' DAY` o más): el mensaje pudo publicarse antes de que ocurrieran los eventos de tracking.
- Usa `COALESCE` para booleanos y contadores que puedan ser nulos.
- Los nombres de campo son *case-sensitive*.

## Filtros temporales

Para ventanas relativas usa `INTERVAL`; **no calcules una fecha concreta**:

| Petición | Filtro |
| --- | --- |
| últimas 24 horas | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '24' HOUR` |
| últimos 7 días | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '7' DAY` |
| últimas 4 semanas | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '4' WEEK` |
| últimos 6 meses | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '6' MONTH` |

- Unidad en singular (`DAY`, `HOUR`, `WEEK`, `MONTH`).
- **Número entre comillas** (sintaxis ANSI): `INTERVAL '30' DAY`. La forma `INTERVAL 30 DAY` falla en AEP Query Service.
- Para fechas explícitas del usuario, usa literales ISO con `>=` / `<` (por ejemplo `timestamp >= '2025-01-01T00:00:00.000Z' AND timestamp < '2025-02-01T00:00:00.000Z'`).
- Si `timestamp` es string, usa `CAST(timestamp AS TIMESTAMP)` o `TO_TIMESTAMP(timestamp)`.

---

## Patrón 0 — Consulta mínima (sin joins)

Antes de elegir cualquier otro patrón, comprueba si basta **una sola tabla**. No hagas join si el resultado no lo necesita.

Checklist:

- ¿El campo pedido existe en el dataset de eventos? → no join.
- ¿Solo piden IDs (`campaignID`, `messageID`, `journeyActionID`)? → no join.
- ¿Piden nombres de campaña/journey, asunto o canal? → join con `ajo_entity_dataset` deduplicada (patrón 2 o 4).
- ¿Piden entrega **y** apertura/clic a la vez? → feedback + tracking por `messageID` (patrón 5 o 12).
- Si el join no aporta columnas al `SELECT` ni filtros, bórralo.

### 0a. Entregas por campaña (solo feedback, sin nombres)

```sql
SELECT
    _experience.customerJourneyManagement.messageExecution.campaignID AS campaign_id,
    COUNT(*) AS feedback_events,
    SUM(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'delivered' THEN 1 ELSE 0 END) AS delivered_events,
    SUM(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'bounce' THEN 1 ELSE 0 END) AS bounced_events
FROM ajo_message_feedback_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '30' DAY
  AND COALESCE(_experience.customerJourneyManagement.messageProfile.isTestExecution, false) = false
GROUP BY _experience.customerJourneyManagement.messageExecution.campaignID
ORDER BY feedback_events DESC
LIMIT 50
```

### 0b. Aperturas y clics por campaña (solo tracking de email)

```sql
SELECT
    _experience.customerJourneyManagement.messageExecution.campaignID AS campaign_id,
    COUNT(*) AS interaction_events,
    COUNT(DISTINCT _experience.customerJourneyManagement.messageExecution.messageID) AS messages,
    SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.openCount, 0)) AS total_opens,
    SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.clickCount, 0)) AS total_clicks
FROM ajo_email_tracking_experience_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '30' DAY
  AND COALESCE(_experience.customerJourneyManagement.messageProfile.isTestExecution, false) = false
GROUP BY _experience.customerJourneyManagement.messageExecution.campaignID
ORDER BY interaction_events DESC
LIMIT 50
```

---

## Patrón 1 — Descubrir datasets y columnas

### 1a. Qué datasets de AJO/ODE existen en el sandbox

```sql
SELECT DISTINCT table_name
FROM information_schema.columns
WHERE table_name LIKE 'ajo%' OR table_name LIKE 'ode%'
ORDER BY table_name
LIMIT 50
```

### 1b. Columnas reales de un dataset

```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'ajo_message_feedback_event_dataset'
ORDER BY ordinal_position
LIMIT 50
```

> Usa 1b antes de escribir la query final si el campo no está en `fields.md` o si sospechas que cambió el esquema. No inventes rutas.

### 1c. Valores reales de un enum

```sql
SELECT
    _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus AS feedback_status,
    COUNT(*) AS events
FROM ajo_message_feedback_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
GROUP BY _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus
ORDER BY events DESC
LIMIT 50
```

Cambia el campo por `...stepEvents.stepStatus`, `eventType`, `...messageInteraction.deliveryStatus`, etc.

---

## Patrón 2 — Deduplicar `ajo_entity_dataset`

`ajo_entity_dataset` es un lookup con histórico: puede haber varias filas por `messageID`. La vigente es la de mayor `timestamp`. Solo lo necesitas si vas a mostrar o filtrar por columnas que existen únicamente ahí (nombres de campaña/journey, asunto, canal, tags); si no, no la cruces.

```sql
WITH ranked AS (
    SELECT
        e._experience.customerJourneyManagement.entities.channelDetails.messageID AS message_id,
        e._experience.customerJourneyManagement.entities.campaign.campaignID AS campaign_id,
        e._experience.customerJourneyManagement.entities.campaign.name AS campaign_name,
        e._experience.customerJourneyManagement.entities.journey.journeyName AS journey_name,
        e._experience.customerJourneyManagement.entities.journey.journeyActionID AS journey_action_id,
        e._experience.customerJourneyManagement.entities.journey.journeyNodeName AS journey_node_name,
        e._experience.customerJourneyManagement.entities.channelDetails.channel AS channel,
        e._experience.customerJourneyManagement.entities.channelDetails.email.subject AS email_subject,
        e._experience.customerJourneyManagement.entities.channelDetails.push.title AS push_title,
        e._experience.customerJourneyManagement.entities.experiment.experimentId AS experiment_id,
        e._experience.customerJourneyManagement.entities.experiment.treatmentName AS treatment_name,
        e._experience.customerJourneyManagement.messageProfile.isTestExecution AS is_test,
        e.timestamp AS entity_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY e._experience.customerJourneyManagement.entities.channelDetails.messageID
            ORDER BY CAST(e.timestamp AS TIMESTAMP) DESC
        ) AS rn
    FROM ajo_entity_dataset e
    WHERE e.timestamp >= CURRENT_TIMESTAMP - INTERVAL '180' DAY
)
SELECT
    message_id,
    campaign_id,
    campaign_name,
    journey_name,
    journey_action_id,
    journey_node_name,
    channel,
    email_subject,
    push_title,
    experiment_id,
    treatment_name,
    is_test,
    entity_timestamp
FROM ranked
WHERE rn = 1
ORDER BY entity_timestamp DESC
LIMIT 50
```

Variante reutilizable: guarda `ranked`/`entity_latest` como CTE y únela con `rn = 1`.

---

## Patrón 3 — KPIs de entrega por campaña

Una fila de feedback es un evento/intento de entrega, no necesariamente un mensaje único.

```sql
WITH feedback AS (
    SELECT
        _experience.customerJourneyManagement.messageExecution.campaignID AS campaign_id,
        _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus AS feedback_status,
        _experience.customerJourneyManagement.messageProfile.isTestExecution AS is_test
    FROM ajo_message_feedback_event_dataset
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
)
SELECT
    campaign_id,
    COUNT(*) AS feedback_events,
    SUM(CASE WHEN feedback_status = 'sent' THEN 1 ELSE 0 END) AS sent_events,
    SUM(CASE WHEN feedback_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_events,
    SUM(CASE WHEN feedback_status = 'bounce' THEN 1 ELSE 0 END) AS bounced_events,
    SUM(CASE WHEN feedback_status = 'error' THEN 1 ELSE 0 END) AS error_events,
    SUM(CASE WHEN feedback_status = 'exclude' THEN 1 ELSE 0 END) AS excluded_events,
    ROUND(
        100.0 * SUM(CASE WHEN feedback_status = 'delivered' THEN 1 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN feedback_status = 'sent' THEN 1 ELSE 0 END), 0),
        2
    ) AS delivery_rate_pct
FROM feedback
WHERE COALESCE(is_test, false) = false
GROUP BY campaign_id
ORDER BY feedback_events DESC
LIMIT 50
```

---

## Patrón 4 — Entregas con nombre de campaña y journey

Úsalo **solo** si el usuario pide nombres. Si le bastan los IDs, patrón 0a o 3 (una sola tabla).

```sql
WITH entity_latest AS (
    SELECT
        e._experience.customerJourneyManagement.entities.channelDetails.messageID AS message_id,
        e._experience.customerJourneyManagement.entities.campaign.name AS campaign_name,
        e._experience.customerJourneyManagement.entities.journey.journeyName AS journey_name,
        e._experience.customerJourneyManagement.entities.channelDetails.channel AS channel,
        ROW_NUMBER() OVER (
            PARTITION BY e._experience.customerJourneyManagement.entities.channelDetails.messageID
            ORDER BY CAST(e.timestamp AS TIMESTAMP) DESC
        ) AS rn
    FROM ajo_entity_dataset e
    -- Amplía esta ventana si los eventos de feedback/tracking son posteriores a la publicación.
    WHERE e.timestamp >= CURRENT_TIMESTAMP - INTERVAL '180' DAY
),
feedback AS (
    SELECT
        f._experience.customerJourneyManagement.messageExecution.messageID AS message_id,
        f._experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus AS feedback_status,
        f._experience.customerJourneyManagement.messageProfile.isTestExecution AS is_test
    FROM ajo_message_feedback_event_dataset f
    WHERE f.timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
)
SELECT
    e.campaign_name,
    e.journey_name,
    e.channel,
    COUNT(*) AS feedback_events,
    COUNT(DISTINCT f.message_id) AS messages,
    SUM(CASE WHEN f.feedback_status = 'delivered' THEN 1 ELSE 0 END) AS delivered_events,
    SUM(CASE WHEN f.feedback_status = 'bounce' THEN 1 ELSE 0 END) AS bounced_events,
    SUM(CASE WHEN f.feedback_status = 'error' THEN 1 ELSE 0 END) AS error_events
FROM feedback f
LEFT JOIN entity_latest e
    ON f.message_id = e.message_id
   AND e.rn = 1
WHERE COALESCE(f.is_test, false) = false
GROUP BY e.campaign_name, e.journey_name, e.channel
ORDER BY feedback_events DESC
LIMIT 50
```

> Si un mensaje viene de campaña, `journey_name` será nulo (y al revés). No es un error del join.

---

## Patrón 5 — Embudo de engagement de email

Agrega primero por `messageID` para no multiplicar filas entre feedback y tracking.

```sql
WITH feedback AS (
    SELECT
        _experience.customerJourneyManagement.messageExecution.messageID AS message_id,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'delivered' THEN 1 ELSE 0 END) AS delivered,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'bounce' THEN 1 ELSE 0 END) AS bounced,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageProfile.isTestExecution = true THEN 1 ELSE 0 END) AS is_test
    FROM ajo_message_feedback_event_dataset
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
    GROUP BY _experience.customerJourneyManagement.messageExecution.messageID
),
email_events AS (
    SELECT
        _experience.customerJourneyManagement.messageExecution.messageID AS message_id,
        MAX(CASE WHEN COALESCE(_experience.customerJourneyManagement.messageInteraction.openCount, 0) > 0 THEN 1 ELSE 0 END) AS opened,
        MAX(CASE WHEN COALESCE(_experience.customerJourneyManagement.messageInteraction.clickCount, 0) > 0 THEN 1 ELSE 0 END) AS clicked,
        SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.openCount, 0)) AS open_events,
        SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.clickCount, 0)) AS click_events,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageInteraction.unsubscribe = true THEN 1 ELSE 0 END) AS unsubscribed
    FROM ajo_email_tracking_experience_event_dataset
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
    GROUP BY _experience.customerJourneyManagement.messageExecution.messageID
)
SELECT
    COUNT(DISTINCT f.message_id) AS delivered_messages,
    SUM(COALESCE(e.opened, 0)) AS messages_opened,
    SUM(COALESCE(e.clicked, 0)) AS messages_clicked,
    SUM(COALESCE(e.open_events, 0)) AS total_opens,
    SUM(COALESCE(e.click_events, 0)) AS total_clicks,
    SUM(COALESCE(e.unsubscribed, 0)) AS unsubscribed_messages,
    ROUND(100.0 * SUM(COALESCE(e.opened, 0)) / NULLIF(COUNT(DISTINCT f.message_id), 0), 2) AS open_rate_pct,
    ROUND(100.0 * SUM(COALESCE(e.clicked, 0)) / NULLIF(COUNT(DISTINCT f.message_id), 0), 2) AS click_rate_pct
FROM feedback f
LEFT JOIN email_events e
    ON f.message_id = e.message_id
WHERE f.delivered = 1
  AND COALESCE(f.is_test, 0) = 0
LIMIT 50
```

> `openCount`/`clickCount` son contadores del evento. Para "abrió sí/no" usa `MAX(...) > 0` por mensaje. Si tu implementación los guarda como acumulados, sustituye `SUM` por `MAX` y dilo en las notas.

---

## Patrón 6 — Rendimiento y errores por paso de journey

```sql
SELECT
    _experience.journeyOrchestration.journey.name AS journey_name,
    _experience.journeyOrchestration.journey.versionID AS journey_version_id,
    _experience.journeyOrchestration.stepEvents.stepName AS step_name,
    _experience.journeyOrchestration.stepEvents.stepStatus AS step_status,
    _experience.journeyOrchestration.stepEvents.actionType AS action_type,
    COUNT(*) AS step_events,
    COUNT(DISTINCT _experience.journeyOrchestration.stepEvents.profileID) AS profiles,
    ROUND(AVG(_experience.journeyOrchestration.stepEvents.processingTime), 2) AS avg_processing_ms,
    MAX(_experience.journeyOrchestration.stepEvents.processingTime) AS max_processing_ms
FROM journey_step_events
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
GROUP BY
    _experience.journeyOrchestration.journey.name,
    _experience.journeyOrchestration.journey.versionID,
    _experience.journeyOrchestration.stepEvents.stepName,
    _experience.journeyOrchestration.stepEvents.stepStatus,
    _experience.journeyOrchestration.stepEvents.actionType
ORDER BY step_events DESC
LIMIT 50
```

Para errores, añade `AND _experience.journeyOrchestration.stepEvents.stepStatus = '{valor_real}'` tras comprobar los valores con el patrón 1c.

---

## Patrón 7 — Serie temporal de envíos y entregas

```sql
SELECT
    TO_DATE(timestamp) AS day,
    COALESCE(_experience.customerJourneyManagement.messageExecution.parentSourceMeta.sourceType, 'unknown') AS source_type,
    COUNT(*) AS feedback_events,
    COUNT(DISTINCT _experience.customerJourneyManagement.messageExecution.messageID) AS messages,
    SUM(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'delivered' THEN 1 ELSE 0 END) AS delivered_events,
    SUM(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'bounce' THEN 1 ELSE 0 END) AS bounced_events,
    SUM(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'error' THEN 1 ELSE 0 END) AS error_events
FROM ajo_message_feedback_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
  AND COALESCE(_experience.customerJourneyManagement.messageProfile.isTestExecution, false) = false
GROUP BY
    TO_DATE(timestamp),
    COALESCE(_experience.customerJourneyManagement.messageExecution.parentSourceMeta.sourceType, 'unknown')
ORDER BY day
LIMIT 50
```

Para mes: `DATE_TRUNC('month', CAST(timestamp AS TIMESTAMP)) AS month`.

---

## Patrón 8 — Engagement de push y SMS

```sql
SELECT
    TO_DATE(timestamp) AS day,
    _experience.customerJourneyManagement.messageExecution.campaignID AS campaign_id,
    _experience.customerJourneyManagement.messageExecution.messageID AS message_id,
    _experience.customerJourneyManagement.pushChannelContext.pushProvider AS push_provider,
    _experience.customerJourneyManagement.pushChannelContext.deviceToken AS device_token,
    _experience.customerJourneyManagement.pushNotificationTracking.isLaunch AS is_launch,
    _experience.customerJourneyManagement.pushNotificationTracking.customAction.actionID AS custom_action_id,
    _experience.customerJourneyManagement.messageInteraction.openCount AS open_count,
    _experience.customerJourneyManagement.messageInteraction.clickCount AS click_count,
    _experience.customerJourneyManagement.messageInteraction.unsubscribe AS unsubscribed,
    _experience.customerJourneyManagement.messageInteraction.landingPage.landingPageName AS landing_page_name,
    _experience.customerJourneyManagement.smsChannelContext.address AS sms_address,
    _experience.customerJourneyManagement.smsChannelContext.carrier AS sms_carrier,
    _experience.customerJourneyManagement.smsChannelContext.shortCode AS sms_short_code
FROM ajo_push_tracking_experience_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
  AND COALESCE(_experience.customerJourneyManagement.messageProfile.isTestExecution, false) = false
ORDER BY timestamp DESC
LIMIT 50
```

> `deviceToken` y `smsChannelContext.address` son datos personales/técnicos: no los selecciones si no son imprescindibles.

---

## Patrón 9 — ODE: proposiciones por actividad y placement

`ode_decisionevents_{key}` es un placeholder: sustitúyelo por el nombre real del sandbox (patrón 1a).

```sql
WITH base AS (
    SELECT
        timestamp,
        _id AS proposition_event_id,
        eventType AS event_type,
        EXPLODE(_experience.decisioning.propositionDetails) AS proposition
    FROM ode_decisionevents_{key}
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
)
SELECT
    TO_DATE(timestamp) AS day,
    proposition.activity.name AS activity_name,
    proposition.activity.id AS activity_id,
    proposition.placement.name AS placement_name,
    proposition.placement.id AS placement_id,
    COUNT(*) AS propositions
FROM base
GROUP BY
    TO_DATE(timestamp),
    proposition.activity.name,
    proposition.activity.id,
    proposition.placement.name,
    proposition.placement.id
ORDER BY propositions DESC
LIMIT 50
```

---

## Patrón 10 — ODE: una fila por oferta servida

```sql
WITH base AS (
    SELECT
        timestamp,
        _id AS proposition_event_id,
        eventType AS event_type,
        identityMap.customerid[0].id AS customer_id,
        EXPLODE(_experience.decisioning.propositionDetails) AS proposition
    FROM ode_decisionevents_{key}
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
),
offers AS (
    SELECT
        timestamp,
        proposition_event_id,
        event_type,
        customer_id,
        proposition.activity.name AS activity_name,
        proposition.placement.name AS placement_name,
        EXPLODE(proposition.selections) AS selection
    FROM base
)
SELECT
    activity_name,
    placement_name,
    selection.name AS offer_name,
    selection.id AS offer_id,
    COUNT(*) AS times_served,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM offers
GROUP BY
    activity_name,
    placement_name,
    selection.name,
    selection.id
ORDER BY times_served DESC
LIMIT 50
```

> `identityMap.customerid[0].id` usa un namespace de ejemplo. Ajusta `customerid` al namespace de tu sandbox (`email`, `ecid`, etc.) y valida con una muestra.
>
> Si `proposition.selections` no existe en tu tenant, inspecciona primero:
>
> ```sql
> SELECT to_json(_experience.decisioning)
> FROM ode_decisionevents_{key}
> LIMIT 1
> ```

---

## Patrón 11 — BCC/CC y exclusiones de compliance

```sql
SELECT
    _experience.customerJourneyManagement.secondaryRecipientDetail.type AS secondary_recipient_type,
    _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus AS feedback_status,
    _experience.customerJourneyManagement.messageDeliveryfeedback.messageExclusion.code AS exclusion_code,
    _experience.customerJourneyManagement.messageDeliveryfeedback.messageExclusion.reason AS exclusion_reason,
    COUNT(*) AS events,
    COUNT(DISTINCT _experience.customerJourneyManagement.messageExecution.messageID) AS messages
FROM ajo_bcc_feedback_event_dataset
WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
GROUP BY
    _experience.customerJourneyManagement.secondaryRecipientDetail.type,
    _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus,
    _experience.customerJourneyManagement.messageDeliveryfeedback.messageExclusion.code,
    _experience.customerJourneyManagement.messageDeliveryfeedback.messageExclusion.reason
ORDER BY events DESC
LIMIT 50
```

---

## Patrón 12 — Detalle por mensaje: entrega + engagement

Útil para una tabla final legible (una fila por `messageID`) **solo si se piden nombres junto a las métricas**. Si no, agrega por `messageID` en el dataset de tracking o de feedback (patrón 0).

```sql
WITH entity_latest AS (
    SELECT
        e._experience.customerJourneyManagement.entities.channelDetails.messageID AS message_id,
        e._experience.customerJourneyManagement.entities.campaign.name AS campaign_name,
        e._experience.customerJourneyManagement.entities.journey.journeyName AS journey_name,
        e._experience.customerJourneyManagement.entities.channelDetails.channel AS channel,
        ROW_NUMBER() OVER (
            PARTITION BY e._experience.customerJourneyManagement.entities.channelDetails.messageID
            ORDER BY CAST(e.timestamp AS TIMESTAMP) DESC
        ) AS rn
    FROM ajo_entity_dataset e
    -- Amplía esta ventana si los eventos de feedback/tracking son posteriores a la publicación.
    WHERE e.timestamp >= CURRENT_TIMESTAMP - INTERVAL '180' DAY
),
feedback AS (
    SELECT
        _experience.customerJourneyManagement.messageExecution.messageID AS message_id,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'delivered' THEN 1 ELSE 0 END) AS delivered,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageDeliveryfeedback.feedbackStatus = 'bounce' THEN 1 ELSE 0 END) AS bounced,
        MAX(CASE WHEN _experience.customerJourneyManagement.messageProfile.isTestExecution = true THEN 1 ELSE 0 END) AS is_test
    FROM ajo_message_feedback_event_dataset
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
    GROUP BY _experience.customerJourneyManagement.messageExecution.messageID
),
email_events AS (
    SELECT
        _experience.customerJourneyManagement.messageExecution.messageID AS message_id,
        SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.openCount, 0)) AS opens,
        SUM(COALESCE(_experience.customerJourneyManagement.messageInteraction.clickCount, 0)) AS clicks
    FROM ajo_email_tracking_experience_event_dataset
    WHERE timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY
    GROUP BY _experience.customerJourneyManagement.messageExecution.messageID
)
SELECT
    e.message_id,
    e.campaign_name,
    e.journey_name,
    e.channel,
    f.delivered,
    f.bounced,
    COALESCE(em.opens, 0) AS email_opens,
    COALESCE(em.clicks, 0) AS email_clicks
FROM entity_latest e
LEFT JOIN feedback f
    ON e.message_id = f.message_id
LEFT JOIN email_events em
    ON e.message_id = em.message_id
WHERE e.rn = 1
  AND COALESCE(f.is_test, 0) = 0
ORDER BY e.message_id
LIMIT 50
```

---

## Errores frecuentes y cómo evitarlos

| Síntoma | Causa probable | Solución |
| --- | --- | --- |
| Filas duplicadas al unir con `ajo_entity_dataset` | Histórico de versiones por `messageID` | Deduplica con `ROW_NUMBER() ... rn = 1` (patrón 2). |
| `delivered` no aparece | `feedbackStatus` no incluye ese estado en ese canal, o el mensaje nunca llegó a entregarse | Lista valores reales (patrón 1c). |
| Métricas infladas al unir feedback y tracking | Varios eventos por mensaje | Agrega por `messageID` en CTEs separadas (patrones 5 y 12). |
| `TABLE_OR_VIEW_NOT_FOUND` | Dataset no aprovisionado o nombre de ODE incorrecto | Descubre datasets (patrón 1a); usa el placeholder de ODE. |
| `cannot resolve column` en arrays | Ruta de struct/array incorrecta | Inspecciona con `to_json(...)` y `information_schema.columns` (patrones 1b y 10). |
| `FIELD_NOT_FOUND ... journeyversionnodeid` | `messageExecution.journeyVersionNodeID` existe en el diccionario pero no en todos los sandboxes | No lo uses: nodo vía `entities.journey.journeyNodeName` (entidad) o `stepEvents.stepName` (journey steps); valida con el patrón 1b. |
| La query tarda demasiado | Falta filtro temporal o `EXPLODE` antes de filtrar | Filtra por `timestamp` en cada CTE y explota solo lo necesario. |
| Sobra un join (y multiplica filas) | Se añadió `ajo_entity_dataset` sin pedir nombres | Agrupa por `campaignID`/`messageID` en una sola tabla (patrón 0). |
