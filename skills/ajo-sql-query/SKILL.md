---
name: AJO SQL Query
description: Genera queries SQL para Adobe Journey Optimizer (AJO) en Adobe Experience Platform Query Service / Data Distiller. Úsala cuando se pida una query, consulta o SQL sobre journeys, campañas, mensajes, entregas, bounces, aperturas, clics, unsubscribes, pasos de journey u ofertas/decisioning de AJO.
---

# AJO SQL Query

Convierte una petición en lenguaje natural en SQL válido para **Adobe Experience Platform (AEP) Query Service / Data Distiller** sobre los datasets de sistema de Adobe Journey Optimizer.

## Cuándo se activa

- El usuario pide una **query**, **consulta** o **SQL**.
- La petición trata de **journeys**, **campañas**, **mensajes**, **entregas**, **bounces**, **aperturas**, **clics**, **unsubscribes**, **pasos de journey** u **ofertas/decisioning**.
- La petición menciona datasets de AJO (`ajo_*`, `journey_step_events`, `ode_decisionevents_*`) o pide métricas/reporting sobre ellos.

Si el contexto es AEP/AJO pero el grano no está claro, elige la interpretación más útil, declárala y entrega una sola query.

## Supuestos por defecto

Si el usuario no indica otra cosa:

- **Rango temporal:** últimos 90 días → `timestamp >= CURRENT_TIMESTAMP - INTERVAL '90' DAY`; si la petición implica un periodo concreto, respétalo.
- **Ejecuciones de prueba:** excluidas con `COALESCE(...isTestExecution, false) = false`.
- **Límite:** `LIMIT 50` en el `SELECT` final.
- **Sandbox:** el usuario trabaja en un sandbox concreto; no inventes nombres de datasets ODE ni namespaces de identidad.
- **PII:** no selecciones emails, teléfonos, tokens ni direcciones salvo que sean imprescindibles.

## Regla de simplicidad: una tabla si basta

El objetivo es la query **más simple** que responda exactamente lo pedido. No añadas datasets "por si acaso".

- **Empieza por un único dataset** y añade otro solo si un campo o un filtro pedido no existe en el primero.
- **No unas `ajo_entity_dataset` si el usuario no pide** nombres de campaña/journey, asunto, canal, nodo, experimento o tags, ni quiere filtrar por ellos. Los IDs (`campaignID`, `messageID`, `journeyActionID`, `sourceType`) ya están en feedback, tracking, journey steps y ODE: agrupa y filtra por ellos y devuélvelos tal cual.
- **Entregas, bounces o motivos de fallo** ("entregas por campaña", "bounces por mensaje") → solo `ajo_message_feedback_event_dataset`.
- **Aperturas, clics o unsubscribes** → solo el dataset de tracking correspondiente (email o push/SMS).
- **Errores o embudo de pasos** → solo `journey_step_events`.
- **Ofertas o proposiciones** → solo `ode_decisionevents_{key}`.
- **Feedback + tracking** solo si se piden métricas de entrega **y** de interacción en la misma tabla, unidas por `messageID`.
- Un join está justificado solo si **(a)** aporta una columna que se muestra o **(b)** aplica un filtro que no se puede expresar en el dataset base. Si no cumple ninguna, elimínalo.
- No cruces para "enriquecer" ni para deduplicar el dataset base: deduplica dentro del dataset que ya usas (p. ej. `MAX(...)` por `messageID`).
- Si haces un join, dilo en el formato de salida y deduplica la entidad (patrón 2).

## Filtros temporales relativos

Cuando el usuario diga "en los últimos X días/horas/semanas/meses", **no calcules una fecha concreta**: usa `INTERVAL` sobre `CURRENT_TIMESTAMP`.

| Expresión del usuario | Filtro |
| --- | --- |
| últimas 24 horas | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '24' HOUR` |
| últimos 7 días | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '7' DAY` |
| últimas 4 semanas | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '4' WEEK` |
| últimos 6 meses | `timestamp >= CURRENT_TIMESTAMP - INTERVAL '6' MONTH` |

Reglas:

- Unidad en singular: `DAY`, `HOUR`, `WEEK`, `MONTH`, `YEAR`.
- **El número va entre comillas** (sintaxis ANSI): `INTERVAL '30' DAY`. Sin comillas (`INTERVAL 30 DAY`) Query Service devuelve error de sintaxis.
- No mezcles `YEAR`/`MONTH` con `DAY`/`HOUR` en el mismo literal de intervalo.
- Para "hoy", "ayer" o días naturales, usa `CURRENT_DATE` como referencia.
- Si el usuario da fechas explícitas ("desde el 1 de enero"), usa literales ISO con `>=` / `<`.
- Para `ajo_entity_dataset`, usa una ventana más amplia que la de los eventos (`INTERVAL '180' DAY` o más), porque el mensaje pudo publicarse antes.
- Si `timestamp` está almacenado como string, valida el tipo con `information_schema.columns`; si hace falta, usa `CAST(timestamp AS TIMESTAMP)` o `TO_TIMESTAMP(timestamp)`.

## Regla del LIMIT (obligatoria)

Toda query final termina con `LIMIT 50`, **incluidas las agregaciones**.

Excepciones, solo si el usuario lo pide:

- Otro tamaño explícito ("top 10", "los 200 primeros") → usa ese número.
- "Sin límite", "todos los resultados" o una exportación → omite `LIMIT` y dilo en las notas.
- Un `LIMIT` mayor pedido para explorar (p. ej. `LIMIT 500`) → respétalo.

No pongas `LIMIT` en subconsultas o CTEs salvo que sea imprescindible; el límite va en el `SELECT` final.

## Flujo obligatorio

1. **Lee las referencias antes de escribir SQL. Nunca inventes rutas de campos:**
   - `references/datasets-and-joins.md` — catálogo de datasets, claves de join, mapa pregunta → dataset.
   - `references/fields.md` — campos documentados de cada dataset en dot notation.
   - `references/query-patterns.md` — patrones SQL listos para adaptar (dedup, funnel, `EXPLODE`, series temporales).
   - `references/message-feedback-field-dictionary.md` — diccionario exhaustivo de 235 campos del esquema de message feedback, con enums (`feedbackStatus`, `messageFailure.type`, `channelType`, etc.). Consúltalo para cualquier campo de entrega/feedback, SMS o WhatsApp.

2. **Identifica el grano** de la petición: journey, campaña, mensaje, entrega, interacción (open/click), oferta/decisioning o identidad.

3. **Elige el conjunto mínimo de datasets.** Empieza por uno; añade otro solo si falta un campo o filtro. Regla rápida:
   - estructura, nombres de campaña/journey, canal, versión, tags → `ajo_entity_dataset`
   - envío, entrega, bounce, motivo de fallo, exclusión → `ajo_message_feedback_event_dataset`
   - aperturas, clics, unsubscribes, landing pages → `ajo_email_tracking_experience_event_dataset` / `ajo_push_tracking_experience_event_dataset`
   - pasos, errores, timeouts, progresión del journey → `journey_step_events`
   - ofertas, placements, estrategias, outcome → `ode_decisionevents_{key}`
   - copias BCC/CC y exclusiones de compliance → `ajo_bcc_feedback_event_dataset`

4. **Selecciona campos con su ruta completa** y alias legibles (`snake_case`). Usa `COALESCE` para nulos.

5. **Añade joins solo si son imprescindibles.** Por defecto, ninguno. Un join se justifica únicamente si el resultado debe mostrar un campo que no está en el dataset base (p. ej. nombre de campaña/journey) o si hay que filtrar por ese campo. Si unes con `ajo_entity_dataset`, deduplica primero por `messageID` (es un lookup con histórico) y amplía su ventana hacia atrás (`CURRENT_TIMESTAMP - INTERVAL '180' DAY` o más). No la añadas solo para agrupar por `campaignID`/`messageID` ni para "enriquecer" el resultado.

6. **Filtra**:
   - rango temporal: si es relativo ("últimos N días/horas/semanas/meses"), usa `timestamp >= CURRENT_TIMESTAMP - INTERVAL 'N' DAY|HOUR|WEEK|MONTH`; si el usuario da fechas explícitas, usa literales ISO;
   - excluye ejecuciones de prueba: `COALESCE(...isTestExecution, false) = false` (avísalo);
   - aplica los filtros de negocio pedidos (campaña, journey, canal, estado).

7. **Añade `LIMIT 50`** según la regla anterior.

8. **Valida el SQL mentalmente** (dialecto Spark SQL de AEP): comas, alias, `GROUP BY` completo, arrays/structs, `EXPLODE`, rangos de fechas.

9. **Responde** con el formato de salida.

## Índice de patrones

| Patrón | Cuándo usarlo |
| --- | --- |
| 0 | Consulta mínima con **una sola tabla**, sin joins (empieza aquí) |
| 1 / 1b / 1c | Descubrir datasets, columnas y valores reales de enums |
| 2 | Deduplicar `ajo_entity_dataset` (solo si necesitas sus columnas) |
| 3 | KPIs de entrega por campaña |
| 4 | Entregas con nombre de campaña/journey |
| 5 | Embudo de engagement de email |
| 6 | Rendimiento y errores por paso de journey |
| 7 | Serie temporal de envíos y entregas |
| 8 | Engagement de push y SMS |
| 9 | ODE: proposiciones por actividad/placement |
| 10 | ODE: una fila por oferta servida |
| 11 | BCC/CC y exclusiones de compliance |
| 12 | Detalle por mensaje: entrega + engagement |

## Formato de salida

1. Una línea con los datasets usados (uno si basta) y, solo si hay join, la clave de unión.
2. Supuestos relevantes en viñetas breves (rango de fechas, exclusión de tests, enums asumidos, interpretación del grano).
3. La query en un único bloque de código SQL.
4. Notas solo si hay riesgo: campo no documentado, dataset dependiente del entorno, enum a confirmar, PII.

Si la petición es ambigua en el grano (p. ej. "rendimiento de campañas" sin decir si entregas o engagement), elige la interpretación más útil, declárala en supuestos y ofrece la variante en una frase. No escribas dos queries completas salvo que el usuario las pida.

## Semántica que no debes confundir

- **sent ≠ delivered**: `feedbackStatus = 'sent'` es "enviado"; `'delivered'` es "entregado". Un mensaje puede estar `sent` y nunca `delivered`.
- **bounce ≠ error**: `'bounce'` es rechazo del destino; `'error'` es fallo de procesamiento; `'exclude'` es filtrado por typology/compliance; `'denylist'` es destino inválido.
- **No unas datasets de eventos por `_id` ni `timestamp`**: son identificadores del evento, no del mensaje. Usa IDs de mensaje, acción o proposición.
- **`messageID`** es la clave entre `ajo_entity_dataset` y feedback/tracking.
- **`journeyActionID`** (entity) enlaza con `_experience.journeyOrchestration.stepEvents.actionID` (journey steps).
- **Una fila por evento** en tracking: no mezcles `COUNT(*)` con `SUM(openCount)` sin definir la métrica. `openCount`/`clickCount` son contadores del evento; para métricas por mensaje usa `MAX(...)` por `messageID`.
- **ODE** vive en un dataset con sufijo del entorno (`ode_decisionevents_{key}`): usa un placeholder claro y dilo.
- **BCC** solo contiene copias BCC/CC; no lo uses para métricas generales de campaña.
- **Un mensaje viene de campaña o de journey**, no de ambos: distingue por `campaignID`/`journeyActionID` o por `sourceType`.
- **`propositionDetails` y `propositions` son arrays**: requieren `EXPLODE`.
- **`messageExecution.journeyVersionNodeID` no existe en todos los sandboxes**: si el struct solo expone `journeyActionID`, `journeyVersionID`, `waveID`…, usa `entities.journey.journeyNodeName` (entidad) o `stepEvents.stepName` (journey steps) y une por `journeyActionID`/`actionID`. No inventes el campo ni lo tomes del diccionario sin validarlo.
- **`identityMap`** es un mapa de identidades: usa `identityMap.<namespace>[0].id` y el flag `primary`.
- **PII**: `emailChannelContext.address`, `smsChannelContext.profileNumber` y similares son datos personales. No los incluyas si no son necesarios.

## Convenciones SQL

- Keywords en mayúsculas, un campo por línea en `SELECT` largos, alias en todas las columnas y tablas.
- CTEs (`WITH`) para separar dedup, filtros y agregaciones; luego `GROUP BY` por alias en la consulta exterior (evita depender de `GROUP BY` por posición).
- Fechas: para ventanas relativas usa `CURRENT_TIMESTAMP - INTERVAL 'N' DAY|HOUR|WEEK|MONTH`; para fechas explícitas, `timestamp >= '2025-01-01T00:00:00.000Z'`. Para agrupar por día usa `TO_DATE(timestamp)`; para mes, `DATE_TRUNC('month', CAST(timestamp AS TIMESTAMP))`. `YEAR(timestamp)` / `MONTH(timestamp)` también funcionan como en la documentación de Adobe.
- Arrays: `EXPLODE(col) AS alias` en el `SELECT` de una CTE; acceso puntual: `col[0].campo`.
- JSON: `to_json(col)`.
- Descubrimiento: `information_schema.columns` (patrón 1), no adivines campos ni enums.
- Sin `SELECT *` en la entrega final; solo para explorar.

## Checklist antes de entregar

- [ ] Cada dataset del `FROM`/`JOIN` aporta una columna mostrada o un filtro (sin joins decorativos)
- [ ] Rutas de campos verificadas en `references/`
- [ ] Dataset correcto para el grano pedido
- [ ] Join por IDs correctos y `ajo_entity_dataset` deduplicada
- [ ] Ventana de `ajo_entity_dataset` cubre la fecha de publicación del mensaje
- [ ] Campos poco comunes (p. ej. `messageExecution.journeyVersionNodeID`) validados o sustituidos por una alternativa de `fields.md`
- [ ] Ventanas relativas expresadas con `INTERVAL`, sin fechas calculadas a mano
- [ ] Número del intervalo entre comillas (`INTERVAL '30' DAY`), nunca `INTERVAL 30 DAY`
- [ ] Ejecuciones de prueba excluidas o justificadas
- [ ] `LIMIT 50` presente (o excepción explicada)
- [ ] Nombre del dataset ODE con placeholder si aplica
- [ ] Alias y `GROUP BY` coherentes
- [ ] Sin `SELECT *` en el resultado final

## Mantenimiento

Fuente principal: [EXPLORE 300: Exploring Adobe Journey Optimizer System Datasets with Data Distiller](https://data-distilller.gitbook.io/adobe-data-distiller-guide/unit-2-data-distiller-data-exploration/explore-300-exploring-adobe-journey-optimizer-system-datasets-with-data-distiller) (sincronizado 2026-11-14).

Si Adobe cambia el esquema, valida con el patrón 1 (`information_schema.columns`) y actualiza `references/fields.md`. El diccionario de `references/message-feedback-field-dictionary.md` se generó desde el export oficial del *AJO schema dictionary* de Experience League.
