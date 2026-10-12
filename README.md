# Nobel Economics (1969–presente)

Repositorio reproducible y sitio de divulgación científica para cada **Premio de Ciencias Económicas del Banco de Suecia en Memoria de Alfred Nobel**.

## Estructura del Proyecto

Para cada laureado o premio otorgado:
1. **Referencias documentadas**: papers y libros seminales con metadatos BibTeX y PDFs de acceso abierto verificados.
2. **Replicación en R**: código estructurado y reproducible (simulaciones, modelos macroeconómicos, microeconometría, inferencia causal).
3. **Ficha divulgativa**: análisis de la investigación, marco metodológico, contraste *Antes vs. Después*, y aplicaciones contemporáneas en bancos centrales, industria y políticas públicas.

## Estructura de Carpetas

- `data/`: Catálogo maestro de laureados (`laureados.csv`).
- `laureados/`: Carpetas por año y laureados (`AAAA_apellido`).
- `scripts/`: Herramientas de automatización, descarga legal de referencias y validación.
- `web/`: Sitio estático para divulgación y exploración de la colección.
- `docs/`: Bitácoras metodológicas (`DECISIONES.md`, `ESTADO.md`, `FUENTES.md`).

## Requisitos de Ejecución

- R (≥ 4.3)
- Paquetes clave: `tidyverse`, `rmarkdown`, `knitr`, `renv`

Para reproducir una replicación específica en R:
```r
# Correr script de replicación
source("laureados/2026_hall_woodford/replicacion/R/modelo_nuevo_keynesiano.R")
```

## Ver la web localmente

La web se genera desde el catálogo y las fichas Markdown existentes; no requiere R ni Quarto.

En Windows, la forma más sencilla es abrir con doble clic `web/ver_web.bat`.

```bash
cd web
npm ci
npm run build
npm run serve
```

El build queda en `web/dist/`. Las entradas todavía incompletas se muestran como contenido en preparación y se actualizan automáticamente al añadir nuevas fichas.
