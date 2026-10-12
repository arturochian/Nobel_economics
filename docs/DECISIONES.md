# DECISIONES.md — Registro de Decisiones de Arquitectura y Diseño

Este documento registra las decisiones clave tomadas durante el desarrollo del proyecto *Nobel_economics*, según las pautas de `AGENTS.md`.

---

## 2026-10-12: Prioridad 0 — Nobel 2026 (Robert E. Hall y Michael Woodford)
- **Decisión:** Iniciar la construcción del repositorio de forma end-to-end con el premio anunciado el 12 de octubre de 2026 para Robert E. Hall y Michael Woodford ("for microeconomic foundations of macroeconomic stabilisation"), tal como instruye la sección 11 de `AGENTS.md`.
- **Motivación:** Garantizar la cobertura inmediata de la última frontera de la ciencia económica con fuentes primarias y replicación del modelo Nuevo Keynesiano tri-ecuacional de Woodford y la hipótesis de caminata aleatoria/rigideces de Hall.

## 2026-10-12: Motor de Replicación y Formato
- **Decisión:** Para las replicaciones se utilizan scripts estándar de R en `replicacion/R/` con salidas tabulares y gráficas en `replicacion/salidas/`, acompañados de un reporte en Quarto / RMarkdown reproducible (`replicar.qmd`).
- **Motivación:** Asegura portabilidad inmediata tanto en entornos con Quarto instalado como en entornos R base / RStudio mediante `knitr` o ejecución directa con `Rscript`.

## 2026-10-12: Nivel de Replicación para 2026 Hall & Woodford
- **Decisión:** Declarar nivel **ilustrativa** para el modelo Nuevo Keynesiano dinámico (Euler IS + Curva de Phillips Nuevo Keynesiana de Calvo-Woodford + Regla de Taylor con inercia).
- **Motivación:** Honestidad metodológica (sección 6 y 11 de `AGENTS.md`). No se simula sobre microdatos propietarios no publicados sino sobre el marco canónico de 3 ecuaciones de Woodford (2003) resolviendo el sistema determinista y estocástico de impulso-respuesta ante shocks de política monetaria y demanda.

## 2026-10-12: Sitio estático generado con Node.js
- **Decisión:** Construir `web/` con un generador estático pequeño en Node.js, sin framework de cliente ni backend. El build combina `data/laureados.csv` con `laureados/*/web/ficha.md`, genera HTML accesible y copia las figuras disponibles a `web/dist/`.
- **Motivación:** La web puede publicarse aunque R y Quarto no estén disponibles en el entorno de despliegue. El contenido académico conserva una sola fuente de verdad y la dependencia de JavaScript en el navegador se limita a búsqueda, filtros, navegación y modo de color.
- **Contenido parcial:** El generador incluye fichas descubiertas aunque todavía no estén en el catálogo y crea páginas de estado para filas del catálogo cuya ficha aún no existe. Esto permite publicar avances sin representar material pendiente como completo.
- **Despliegue:** GitHub Actions construye `web/dist/` y lo publica en GitHub Pages bajo la subruta del repositorio. `dist/` y `node_modules/` son artefactos locales ignorados por Git.
