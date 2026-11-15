# Campos por dataset (dot notation)

Rutas documentadas en [EXPLORE 300: Exploring Adobe Journey Optimizer System Datasets with Data Distiller](https://data-distilller.gitbook.io/adobe-data-distiller-guide/unit-2-data-distiller-data-exploration/explore-300-exploring-adobe-journey-optimizer-system-datasets-with-data-distiller), listas para SQL. Los nombres son **case-sensitive**. `array`/`object` requieren `EXPLODE(...)` o acceso con `.` / `[0]`.

> Antes de entregar una query con un campo poco común, valida el nombre real:
>
> ```sql
> SELECT column_name, data_type
> FROM information_schema.columns
> WHERE table_name = 'ajo_entity_dataset'
> LIMIT 50
> ```

## 1. `ajo_entity_dataset` — metadatos

Prefijo: `_experience.customerJourneyManagement.entities.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| AJO Campaign ID | `entities.campaign.campaignID` | ID de la campaña que originó el mensaje | Rendimiento por campaña |
| Campaign Action ID | `entities.campaign.campaignActionID` | ID de la acción de campaña | Trazabilidad de acciones |
| Campaign Version ID | `entities.campaign.campaignVersionID` | Versión inmutable de la campaña | Comparar versiones |
| Campaign Name | `entities.campaign.name` | Nombre de la campaña | Reporting legible |
| Channel | `entities.channelDetails.channel` | Canal del mensaje (email, push, sms...) | Segmentar por canal |
| Email Subject | `entities.channelDetails.email.subject` | Asunto del email (no personalizado) | Test de asuntos |
| Message ID | `entities.channelDetails.messageID` | **ID del mensaje** (clave de unión) | Unir con feedback/tracking |
| Message Publication ID | `entities.channelDetails.messagePublicationID` | Versión publicada del mensaje | Versionado de mensajes |
| Push Title | `entities.channelDetails.push.title` | Título de la push | Test de títulos |
| Experiment ID | `entities.experiment.experimentId` | ID del experimento/A-B test | Análisis A/B |
| Treatment Name | `entities.experiment.treatmentName` | Variante del experimento | Rendimiento por variante |
| Journey Action ID | `entities.journey.journeyActionID` | Acción del journey que originó el mensaje | Métricas por acción |
| Journey Name | `entities.journey.journeyName` | Nombre del journey | Reporting por journey |
| Journey Node Name | `entities.journey.journeyNodeName` | Nodo del canvas donde se disparó | Granularidad por nodo |
| Journey Version ID | `entities.journey.journeyVersionID` | Versión congelada del journey | Comparar versiones |
| Message Publication Time | `entities.channelDetails.messagePublishedAt` | Fecha de publicación del mensaje | Análisis temporal |
| Base Message ID | `entities.channelDetails.baseMessageID` | Mensaje base del que deriva | Clonados/republicaciones |
| Tags | `entities.tags.values` (array) | Tags de mensaje/journey/campaña | Filtros por categoría |
| Namespace | `emailChannelContext.namespace` | Namespace del email en consentimiento | Compliance/preferencias |
| Outbound IP | `emailChannelContext.outboundIP` | IP de salida del envío | Diagnóstico de entregabilidad |
| Landing Page URL | `messageInteraction.landingpage.landingPageURL` | URL de la landing page | Efectividad de landing |
| Open Count | `messageInteraction.openCount` | Nº de aperturas | Engagement (preferir tracking) |
| Click Count | `messageInteraction.clickCount` | Nº de clics | Engagement (preferir tracking) |
| Offer Name | `messageInteraction.offers.offerName` | Oferta presentada | Engagement de ofertas |
| Delivery Status | `messageInteraction.deliveryStatus` | Estado de entrega | Entrega (preferir feedback) |
| Bounce Type | `messageInteraction.bounceType` | Tipo de bounce (soft/hard) | Diagnóstico (preferir feedback) |
| Interaction Type | `messageInteraction.interactionType` | Tipo de interacción (open, click...) | Categorizar interacciones |
| Tracker URL Label | `messageInteraction.label` | Etiqueta legible del enlace | Qué enlace generó engagement |
| Proposition ID | `messageInteraction.offers.propositionID` | ID de la proposición/oferta | Enlace con ODE |
| Interaction Outcome | `decisioning.propositions.items.interactionOutcome` | Resultado de la interacción | Conversiones |
| Is Test Execution | `messageProfile.isTestExecution` | `true` si es ejecución de prueba | Excluir tests |
| Is Send Time Optimized | `messageProfile.isSendTimeOptimized` | `true` si se aplicó send-time optimization | Efectividad de STO |
| Profile ID | `messageInteraction.profileID` | Perfil asociado a la interacción | Análisis por perfil |
| Identity ID | `identityMap.additionalProperties.items.id` | Identificador del usuario | Enlace de identidad |
| Identity Type | `identityMap.additionalProperties.items.type` | Tipo de identidad | Enlace de identidad |
| Primary | `identityMap.additionalProperties.items.primary` | Identidad preferida | Enlace de identidad |
| Timestamp | `timestamp` | Momento del registro | Filtros y dedup |

Notas:

- Prefijo completo: `_experience.customerJourneyManagement.` + la ruta de la tabla.
- Es un **lookup con histórico**: deduplica por `messageID` antes de unir.
- La página mezcla `landingpage` (minúsculas, aquí) con `landingPage` (en tracking). Si falla, valida el nombre.
- `identityMap` se comporta como mapa: en SQL suele funcionar `identityMap.<namespace>[0].id` (ver `datasets-and-joins.md`).
- Los campos `messageInteraction.*` de la entidad son una copia de metadatos; para métricas de engagement usa los datasets de tracking.

## 2. `journey_step_events` — pasos del journey

Prefijo: `_experience.journeyOrchestration.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Step Event ID | `stepEvents.stepID` | ID del evento de paso | Trazabilidad |
| Journey ID | `journey.ID` | ID del journey | Métricas por journey |
| Journey Name | `journey.name` | Nombre del journey | Reporting |
| Version ID | `journey.versionID` | Versión del journey | Comparar versiones |
| Step ID | `stepEvents.stepID` | ID del paso | Embudo por paso |
| Step Name | `stepEvents.stepName` | Nombre del paso en el canvas | Reporting y depuración |
| Step Status | `stepEvents.stepStatus` | Estado (error, completed, timed out...) | Detectar cuellos de botella |
| Processing Time | `stepEvents.processingTime` | Tiempo de proceso (ms) | Optimización |
| Profile ID | `stepEvents.profileID` | Perfil del journey | Análisis por perfil |
| Segment Qualification Status | `stepEvents.segmentQualificationStatus` | Dentro/fuera del segmento | Análisis por segmento |
| Interaction Type | `stepEvents.interactionType` | marketing / transactional | Segmentar interacciones |
| Action Type | `stepEvents.actionType` | Tipo de acción (email, SMS, custom HTTP...) | Qué canal/acción se invocó |
| Reaction Action ID | `stepEvents.reactionActionID` | Acción a la que reaccionó el usuario | Analizar reacciones |
| Action Execution Time | `stepEvents.actionExecutionTime` | Tiempo de ejecución de la acción | Optimización |
| Action ID | `stepEvents.actionID` | **Clave de unión** con `journeyActionID` de la entidad | Unir con entity |
| Segment ID | `stepEvents.segmentExportJob.exportSegmentID` | Segmento del export job | Journeys disparados por audiencia |
| Event Type | `eventType` | Tipo de evento | Categorizar eventos |
| Timestamp | `timestamp` | Momento del evento | Filtros y series temporales |

Notas:

- `journey.ID` aparece así en la página; algunos tenants exponen `journey.journeyID`. Valida con `information_schema.columns`.
- `stepStatus` no tiene una lista cerrada en la documentación: descubre los valores reales con el patrón 1b.
- No esperes una fila por mensaje: es un log de pasos por perfil.

## 3. `ajo_message_feedback_event_dataset` — entrega

Prefijo: `_experience.customerJourneyManagement.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Message ID | `messageExecution.messageID` | **ID del mensaje** (clave de unión) | Unir con entity/tracking |
| Address | `emailChannelContext.address` | Email o teléfono destino (**PII**) | Identificar destinatario |
| Outbound IP | `emailChannelContext.outboundIP` | IP de salida | Deliverability/compliance |
| Delivery Status | `messageDeliveryfeedback.feedbackStatus` | Estado del intento (`sent`, `delivered`, `bounce`, `error`, `exclude`...) | KPI de entrega |
| Failure Category | `messageDeliveryfeedback.messageFailure.category` | `sync` / `async` | Diagnóstico |
| Failure Type | `messageDeliveryfeedback.messageFailure.type` | `soft` / `hard` | Diagnóstico de bounce |
| Failure Reason | `messageDeliveryfeedback.messageFailure.reason` | Motivo detallado | Diagnóstico |
| Failure Code | `messageDeliveryfeedback.messageFailure.code` | Código del fallo | Diagnóstico |
| Retry Count | `messageDeliveryfeedback.retryCount` | Reintentos antes del evento | Eficiencia de reintentos |
| Exclude Code | `messageDeliveryfeedback.messageExclusion.code` | Motivo de exclusión (typology, parámetros...) | Compliance |
| Exclude Reason | `messageDeliveryfeedback.messageExclusion.reason` | Detalle de la exclusión | Compliance |
| Campaign ID | `messageExecution.campaignID` | Campaña que originó el mensaje | Métricas por campaña |
| Journey Action ID | `messageExecution.journeyActionID` | Acción del journey | Métricas por acción |
| Message Type | `messageExecution.messageType` | `marketing` / `transactional` | Segmentar |
| Is Send Time Optimized | `messageProfile.isSendTimeOptimized` | STO aplicado | Efectividad de STO |
| Is Test Execution | `messageProfile.isTestExecution` | Ejecución de prueba | Excluir tests |
| Offer ID | `messageDeliveryfeedback.offers.offerID` | Oferta incluida | Seguimiento de ofertas |
| Proposition ID | `messageDeliveryfeedback.offers.propositionID` | Proposición de oferta | Enlace con ODE |
| Offer Activity ID | `messageDeliveryfeedback.offers.activityID` | Actividad de decisión | Enlace con ODE |
| Placement ID | `messageDeliveryfeedback.offers.placementID` | Placement de la oferta | Enlace con ODE |
| Proposition Time | `messageDeliveryfeedback.offers.propositionTime` | Momento de generación de la oferta | Timing de ofertas |
| Interaction Outcome | `decisioning.propositions.items.interactionOutcome` | Resultado de la interacción | Conversiones |

Otros campos útiles (ver diccionario exhaustivo para descripción y enums):

- `messageDeliveryfeedback.firstAttemptTimestamp`, `.requestTimestamp`, `.offers.offerCount`, `.offers.scopeID`, `.messageExclusion.details`, `.retryCount`
- `messageExecution.messageExecutionID`, `.messagePublicationID`, `.campaignActionID`, `.campaignVersionID`, `.journeyVersionID`, `.journeyVersionInstanceID`, `.batchInstanceID`, `.waveID`, `.audience.id`, `.audience.type`, `.parentSourceMeta.sourceType`, `.parentSourceMeta.sourceID`, `.parentSourceMeta.sourceActionID`, `.metadata`
- `messageProfile.messageProfileID`, `.messageProfileTrackingID`, `.requestID`, `.secondaryDimensionID`, `.variant`, `.channel.referringSource`
- `smsChannelContext.*`, `pushChannelContext.*`, `whatsAppChannelContext.*`, `emailChannelContext.attachment.items.*`
- `decisioning.channelType`, `decisioning.propositionAction.*`, `decisioning.propositionEventType.*`

> **`messageExecution.journeyVersionNodeID` no existe en todos los sandboxes.** El diccionario oficial lo lista, pero el struct desplegado puede contener solo `messageID`, `messageExecutionID`, `messageType`, `batchInstanceID`, `journeyActionID`, `journeyVersionID`, `messagePublicationID`, `journeyVersionInstanceID`, `campaignActionID`, `campaignVersionID`, `campaignID`, `audience`, `fragmentPublicationIDs`, `parentSourceMeta` y `waveID`. Si la query falla con `FIELD_NOT_FOUND` por ese campo, no lo uses: para granularidad por nodo emplea `ajo_entity_dataset` (`entities.journey.journeyNodeName`) o `journey_step_events` (`...stepEvents.stepName`), uniendo por `journeyActionID`/`actionID`.

## 4. `ajo_bcc_feedback_event_dataset` — BCC/CC

Mismos campos de entrega que el dataset de feedback, más los específicos de copia secundaria:

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Message ID | `messageExecution.messageID` | ID del mensaje | Unir |
| Address | `emailChannelContext.address` | Destinatario original (**PII**) | Reporting |
| Outbound IP | `emailChannelContext.outboundIP` | IP de salida | Deliverability |
| Delivery Status | `messageDeliveryfeedback.feedbackStatus` | Estado de entrega | Entrega |
| Exclude Code | `messageDeliveryfeedback.messageExclusion.code` | Motivo de exclusión | Compliance |
| Exclude Reason | `messageDeliveryfeedback.messageExclusion.reason` | Detalle de exclusión | Compliance |
| Failure Category | `messageDeliveryfeedback.messageFailure.category` | sync / async | Diagnóstico |
| Failure Reason | `messageDeliveryfeedback.messageFailure.reason` | Motivo del fallo | Diagnóstico |
| Offer ID | `messageDeliveryfeedback.offers.offerID` | Oferta incluida | Seguimiento |
| Retry Count | `messageDeliveryfeedback.retryCount` | Reintentos | Reintentos |
| Original Recipient Address | `secondaryRecipientDetail.originalRecipientAddress` | Destinatario original (**PII**) | Trazabilidad BCC/CC |
| Secondary Recipient Type | `secondaryRecipientDetail.type` | `BCC`, `CC`, `Archival`... | Distinguir tipo de copia |

## 5. `ajo_email_tracking_experience_event_dataset` — engagement email

Prefijo: `_experience.customerJourneyManagement.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Email Address | `emailChannelContext.address` (**PII**) | Destinatario | Segmentación |
| Namespace | `emailChannelContext.namespace` | Namespace del email | Compliance |
| Delivery Status | `messageInteraction.deliveryStatus` | Estado de entrega | Deliverability |
| Bounce Type | `messageInteraction.bounceType` | soft / hard | Diagnóstico |
| Open Count | `messageInteraction.openCount` | Aperturas | Engagement |
| Click Count | `messageInteraction.clickCount` | Clics | Engagement |
| Unsubscribe | `messageInteraction.unsubscribe` | Baja | List hygiene |
| Tracker URL | `messageInteraction.urlID` | URL/enlace clicado | Qué enlace funciona |
| Tracker URL Label | `messageInteraction.label` | Etiqueta del enlace | Reporting legible |
| Offer ID | `messageInteraction.offers.offerID` | Oferta | Engagement de ofertas |
| Landing Page ID | `messageInteraction.landingPage.landingPageID` | Landing visitada | Conversión |
| Landing Page Name | `messageInteraction.landingPage.landingPageName` | Nombre de la landing | Conversión |
| Proposition Time | `messageInteraction.propositionTime` | Momento de la oferta | Timing |
| Campaign ID | `messageExecution.campaignID` | Campaña | Métricas por campaña |
| Message ID | `messageExecution.messageID` | Mensaje | Unir |
| Journey Action ID | `messageExecution.journeyActionID` | Acción del journey | Métricas por acción |
| Message Type | `messageExecution.messageType` | marketing / transactional | Segmentar |
| Is Test Execution | `messageProfile.isTestExecution` | Prueba | Excluir tests |
| Is Send Time Optimized | `messageProfile.isSendTimeOptimized` | STO | Efectividad |
| Interaction Outcome | `decisioning.propositions.items.interactionOutcome` | Resultado | Conversiones |
| Event Type | `eventType` | Tipo de evento | Categorizar |
| Timestamp | `timestamp` | Momento del evento | Series temporales |

## 6. `ajo_push_tracking_experience_event_dataset` — push y SMS

### Push

Prefijo: `_experience.customerJourneyManagement.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Device Token | `pushChannelContext.deviceToken` | Token del dispositivo | Targeting/diagnóstico |
| Push Provider | `pushChannelContext.pushProvider` | `apns` / `fcm` | Rendimiento por proveedor |
| Push Provider Message ID | `pushNotificationTracking.pushProviderMessageID` | ID del proveedor | Correlación de logs |
| Rich Media | `pushNotificationTracking.richMedia` | Imágenes/vídeo de la notificación | Efectividad de rich media |
| Custom Action | `pushNotificationTracking.customAction` | Acciones/botones | Engagement |
| Custom Action ID | `pushNotificationTracking.customAction.actionID` | ID del botón pulsado | Reporting de acciones |
| Is Launch | `pushNotificationTracking.isLaunch` | La push abrió la app | Uso de app |
| Delivery Status | `messageInteraction.deliveryStatus` | Estado de entrega | Deliverability |
| Bounce Type | `messageInteraction.bounceType` | soft / hard | Diagnóstico |
| Open Count | `messageInteraction.openCount` | Aperturas | Engagement |
| Click Count | `messageInteraction.clickCount` | Clics | Engagement |
| Unsubscribe | `messageInteraction.unsubscribe` | Baja | List hygiene |
| Tracker URL | `messageInteraction.urlID` | URL clicada | Engagement |
| Offer ID | `messageInteraction.offers.offerID` | Oferta | Engagement de ofertas |
| Landing Page ID | `messageInteraction.landingPage.landingPageID` | Landing visitada | Conversión |
| Landing Page Name | `messageInteraction.landingPage.landingPageName` | Nombre de la landing | Conversión |
| Proposition Time | `messageInteraction.propositionTime` | Momento de la oferta | Timing |
| Campaign ID | `messageExecution.campaignID` | Campaña | Métricas |
| Message ID | `messageExecution.messageID` | Mensaje | Unir |
| Journey Action ID | `messageExecution.journeyActionID` | Acción del journey | Métricas |
| Message Type | `messageExecution.messageType` | marketing / transactional | Segmentar |
| Is Test Execution | `messageProfile.isTestExecution` | Prueba | Excluir tests |
| Interaction Outcome | `decisioning.propositions.items.interactionOutcome` | Resultado | Conversiones |
| Event Type | `eventType` | Tipo de evento | Categorizar |
| Timestamp | `timestamp` | Momento del evento | Series temporales |

> **`pushProvider` vs `platform`:** la página usa `pushChannelContext.pushProvider`; el diccionario oficial expone el mismo dato como `pushChannelContext.platform` (`apns` / `fcm`). Si una ruta falla, prueba la otra y valida con `information_schema.columns`.

### SMS

La página documenta estos campos en la sección de push tracking (SMS y push comparten dataset/schema en su ejemplo). Confirma en tu sandbox si los eventos SMS llegan aquí o a un dataset SMS propio.

Prefijo: `_experience.customerJourneyManagement.*`

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| SMS Address | `smsChannelContext.address` (**PII**) | Teléfono destino (la página lo llama `smsAddress`) | Segmentación |
| Profile Phone Number | `smsChannelContext.profileNumber` (**PII**) | Teléfono del perfil (variante del diccionario para el mismo dato) | Segmentación |
| Namespace | `smsChannelContext.namespace` | Namespace del teléfono | Compliance |
| Channel Type | `smsChannelContext.channelType` | `SMS`, `MMS`, `RCS`... | Segmentar por tipo |
| SMS Provider | `smsChannelContext.smsProvider` | `sinch`, `infobip`, `twilio`, `vibes` | Rendimiento por proveedor |
| Short Code | `smsChannelContext.shortCode` | Short/long code de envío | Rendimiento por código |
| Carrier | `smsChannelContext.carrier` | Operador del destinatario | Rendimiento por operador |
| Provider Feedback Status | `smsChannelContext.status.providerFeedbackStatus` | Estado crudo del proveedor | Diagnóstico |
| Provider Feedback Status (normalizado) | `smsChannelContext.status.feedbackStatus` | Estado mapeado al enum estándar | Diagnóstico |
| Inbound Message | `smsChannelContext.inboundMessage` | Respuesta entrante (`STOP`, `START`...) | Opt-outs y respuestas |
| Message Content | `messageExecution.messageContent` | Contenido del SMS | Efectividad del copy |
| Opt-out Keywords | `messageInteraction.optOutKeywords` | Palabras de baja usadas (`STOP`, `UNSUBSCRIBE`) | Compliance |
| Delivery Status | `messageInteraction.deliveryStatus` | Estado de entrega | Deliverability |
| Bounce Type | `messageInteraction.bounceType` | soft / hard | Diagnóstico |
| Open Count | `messageInteraction.openCount` | Aperturas (si trackable) | Engagement |
| Click Count | `messageInteraction.clickCount` | Clics | Engagement |
| Unsubscribe | `messageInteraction.unsubscribe` | Baja | List hygiene |
| Tracker URL | `messageInteraction.urlID` | URL clicada | Engagement |
| Offer ID | `messageInteraction.offers.offerID` | Oferta | Engagement de ofertas |
| Campaign ID | `messageExecution.campaignID` | Campaña | Métricas |
| Message ID | `messageExecution.messageID` | Mensaje | Unir |
| Journey Action ID | `messageExecution.journeyActionID` | Acción del journey | Métricas |
| Message Type | `messageExecution.messageType` | marketing / transactional | Segmentar |
| Is Test Execution | `messageProfile.isTestExecution` | Prueba | Excluir tests |
| Interaction Outcome | `decisioning.propositions.items.interactionOutcome` | Resultado | Conversiones |
| Timestamp | `timestamp` | Momento del evento | Series temporales |

### WhatsApp

La página no detalla WhatsApp, pero el diccionario oficial sí. Confirma en tu sandbox si los eventos llegan a `ajo_push_tracking_experience_event_dataset` o a un dataset propio. Rutas del diccionario:

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| WhatsApp Address | `whatsAppChannelContext.profileNumber` (**PII**) | Teléfono del perfil | Segmentación |
| Channel Type | `whatsAppChannelContext.channelType` | `Utility`, `Marketing`, `Promotional`... | Segmentar por tipo |
| Message Type | `whatsAppChannelContext.messageType` | `templateBased`, `response` | Analizar plantillas |
| Provider Feedback Status | `whatsAppChannelContext.status.providerFeedbackStatus` | Estado crudo del proveedor | Diagnóstico |
| Feedback Status (normalizado) | `whatsAppChannelContext.status.feedbackStatus` | Estado mapeado al enum estándar | Diagnóstico |
| Inbound Message | `whatsAppChannelContext.inboundMessage` | Respuesta entrante | Opt-outs y respuestas |
| Interactive Type | `whatsAppChannelContext.interactiveType` | `list reply`, `button reply`, `button` | Engagement interactivo |
| Selected Option ID | `whatsAppChannelContext.interactiveSelectedID` | Opción elegida | Engagement interactivo |
| Selected Option Title | `whatsAppChannelContext.interactiveSelectedTitle` | Texto de la opción elegida | Engagement interactivo |
| Reaction Action | `whatsAppChannelContext.reactionActionName` | `react`, `unreact`, `reply` | Reacciones |
| Reaction Content | `whatsAppChannelContext.reactionEvent` | Emoji o texto de la respuesta | Reacciones |
| Original Message ID | `whatsAppChannelContext.reactionMessageID` | Mensaje respondido | Reacciones |

## 7. `ode_decisionevents_{key}` — ofertas y decisioning

Rutas de la tabla de la página:

| Campo | Ruta | Descripción | Uso |
| --- | --- | --- | --- |
| Proposition/Offer ID | `_experience.decisioning.propositionDetails.items.id` | ID de la oferta/proposición | Rendimiento de ofertas |
| Batch Identifier | `_experience.decisioning.batchID` | Decisiones en batch | Batch vs individual |
| Experience Reference | `_experience.decisioning.experienceID` | Experiencia de contenido | Comparar experiencias |
| Proposition Details | `_experience.decisioning.propositionDetails` (array) | Todas las ofertas presentadas | Contexto de la decisión |
| Activity ID | `_experience.decisioning.propositionDetails.items.activity.id` | Actividad de decisión | Trazabilidad |
| Fallback | `_experience.decisioning.propositionDetails.items.fallback` | Opción de fallback | Detectar gaps de targeting |
| Characteristics | `_experience.decisioning.propositionDetails.items.characteristics` | Atributos de la opción | Optimización |
| Placement ID | `_experience.decisioning.propositionDetails.items.placement.id` | Dónde se mostró | Rendimiento por placement |
| Selected Experience | `_experience.decisioning.propositions.items.scopeDetails.experience` | Experiencia seleccionada | Qué se mostró |
| Algorithm ID | `_experience.decisioning.propositions.items.scopeDetails.strategies.items.algorithmID` | Algoritmo de decisión | Efectividad del algoritmo |
| Decision Outcome | `_experience.decisioning.propositions.items.scopeDetails.interactionMeasurements.items.outcome` | Resultado (click, conversión...) | Efectividad |
| Identity ID | `identityMap.additionalProperties.items.id` | Identidad del consumidor | Análisis por usuario |
| Primary | `identityMap.additionalProperties.items.primary` | Identidad preferida | Análisis por usuario |
| Event Type | `eventType` | Tipo de evento | Categorizar |
| Timestamp | `timestamp` | Momento del evento | Series temporales |

Rutas que funcionan en los **ejemplos reales** de la página (tras `EXPLODE`):

| Campo | Ruta | Nota |
| --- | --- | --- |
| Proposition ID | `_id` | ID del evento de proposición |
| Activity name | `proposition.activity.name` | Dentro de `propositionDetails` |
| Activity ID | `proposition.activity.id` | Dentro de `propositionDetails` |
| Placement name | `proposition.placement.name` | Dentro de `propositionDetails` |
| Placement ID | `proposition.placement.id` | Dentro de `propositionDetails` |
| Selecciones | `proposition.selections` (array) | `EXPLODE` para una fila por oferta |
| Offer name | `proposition.selections.items.name` | Según el ejemplo con `EXPLODE(p.proposition.selections) AS selection` → `selection.name` |
| Customer ID | `identityMap.customerid[0].id` | Namespace de ejemplo; ajusta al tuyo |

Advertencias sobre ODE:

- La página usa `propositionDetails`, pero el diccionario del esquema de feedback expone variantes como `propositions.items.scopeDetails.*` y `propositions.items.decisionScopeDetails.*`. **No mezcles rutas de esquemas distintos.**
- Inspecciona una fila antes de escribir la query final:

```sql
SELECT to_json(_experience.decisioning)
FROM ode_decisionevents_reemplaza_esto
LIMIT 1
```

- `propositionDetails`, `propositions` y `selections` son arrays: usa `EXPLODE` (ver patrones 9 y 10).
- El nombre del dataset depende del entorno: `ode_decisionevents_{key}`.
