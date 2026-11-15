# opencodeSkills

Skills para [OpenCode](https://opencode.ai).

## `ajo-sql-query`

Convierte peticiones en lenguaje natural sobre **Adobe Journey Optimizer (AJO)** en SQL para **Adobe Experience Platform Query Service / Data Distiller**.

### Qué hace

- Escribe queries **Spark SQL** listas para ejecutar sobre los datasets de sistema de AJO, sin inventar nombres de tablas ni rutas de campos.
- Elige el dataset correcto según el grano de la pregunta: campaña, journey, mensaje, entrega, interacción, paso de journey u oferta.
- Respeta las particularidades de Query Service: `LIMIT 50` por defecto, `INTERVAL 'N' DAY` con el número entre comillas, `EXPLODE` para arrays y validación de campos con `information_schema.columns`.
- Devuelve una única query, con los supuestos relevantes y la clave de unión cuando hay join.

### Cuándo se activa

Cuando se pide una query, consulta o SQL sobre:

- journeys, campañas y mensajes;
- entregas, bounces, motivos de fallo y exclusiones;
- aperturas, clics, unsubscribes y landing pages;
- pasos de journey, errores y tiempos;
- ofertas, placements y proposiciones (decisioning).

### Datasets que cubre

| Dataset | Contenido |
| --- | --- |
| `ajo_entity_dataset` | Metadatos de campaña, journey, mensaje, canal, versión y tags |
| `ajo_message_feedback_event_dataset` | Intentos de entrega: sent, delivered, bounce, error, exclude |
| `ajo_bcc_feedback_event_dataset` | Copias BCC/CC y exclusiones de compliance |
| `ajo_email_tracking_experience_event_dataset` | Aperturas, clics, unsubscribes y landing pages de email |
| `ajo_push_tracking_experience_event_dataset` | Interacciones de push y SMS |
| `journey_step_events` | Progreso, errores, timeouts y tiempos por paso |
| `ode_decisionevents_{key}` | Decisiones y proposiciones de ofertas |

### Reglas por defecto

- `LIMIT 50` al final de la query, salvo que se pida otro límite o "sin límite".
- Ventana de los últimos 90 días si no se indica periodo, expresada con `INTERVAL` (`CURRENT_TIMESTAMP - INTERVAL '90' DAY`).
- Se excluyen las ejecuciones de prueba (`isTestExecution = false`).
- Se usa un solo dataset cuando contiene todo lo pedido; no se cruzan tablas si no aportan columnas o filtros.
- `ajo_entity_dataset` se deduplica por `messageID` solo cuando se necesitan sus nombres o metadatos.
- Si un campo no está documentado o falla en el sandbox, se entrega una query de descubrimiento con `information_schema.columns` en lugar de adivinar.

### Ejemplo

> "Dame las aperturas y clics por campaña de email en los últimos 30 días."

La respuesta incluye la línea de datasets usados, los supuestos aplicados y una query con `INTERVAL '30' DAY` y `LIMIT 50`.

### Contenido de la skill

```text
skills/ajo-sql-query/
├── SKILL.md                                      # instrucciones y flujo de trabajo
└── references/
    ├── datasets-and-joins.md                     # datasets, joins y semántica
    ├── fields.md                                 # campos por dataset
    ├── message-feedback-field-dictionary.md      # 235 campos de feedback + enums
    └── query-patterns.md                         # patrones SQL listos para adaptar
```

### Requisitos e instalación

Requiere OpenCode V2. Copia la carpeta `skills/ajo-sql-query` en una de las ubicaciones que OpenCode descubre para skills, por ejemplo `~/.config/opencode/skills/ajo-sql-query` para tenerla disponible en todos los proyectos. Consulta la [documentación de skills](https://opencode.ai/docs/skills/) para el resto de opciones.

El ID de la skill es `ajo-sql-query`; puedes forzarla en el prompt con `@ajo-sql-query`.

### Fuente

Los esquemas y campos se basan en [EXPLORE 300: Exploring Adobe Journey Optimizer System Datasets with Data Distiller](https://data-distilller.gitbook.io/adobe-data-distiller-guide/unit-2-data-distiller-data-exploration/explore-300-exploring-adobe-journey-optimizer-system-datasets-with-data-distiller) y en el diccionario oficial de esquemas de AJO de Experience League.
