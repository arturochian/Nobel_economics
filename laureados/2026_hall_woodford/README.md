# Nobel de Economía 2026: Robert E. Hall y Michael Woodford

> **Motivación oficial:** *"for microeconomic foundations of macroeconomic stabilisation"* (Por los microfundamentos de la estabilización macroeconómica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 12 de octubre de 2026.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Hall y Woodford y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Almacén para documentos de libre acceso.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación dinámica del Modelo Nuevo Keynesiano de 3 ecuaciones.
  - [R/modelo_nuevo_keynesiano.R](replicacion/R/modelo_nuevo_keynesiano.R): Script en R que resuelve el sistema dinámico y calcula las funciones impulso-respuesta (IRF).
  - [salidas/](replicacion/salidas/): Gráficos exportados en alta resolución (`irf_shock_monetario.png`, `irf_shock_demanda.png`) y datos numéricos (`tabla_irf_simulaciones.csv`).
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para integración en la plataforma web del proyecto.

---

## Resumen Ejecutivo del Aporte
Robert E. Hall y Michael Woodford resolvieron la ruptura fundamental de la macroeconomía de los años 70 (la crisis de la estanflación y la Crítica de Lucas) dotando a las políticas de estabilización monetaria y fiscal de cimientos rigurosos basados en agentes optimizadores:
1. **Hall:** Demostró el suavizamiento del consumo (ecuación de Euler y caminata aleatoria del consumo) y la naturaleza de las rigideces salariales en el mercado de trabajo.
2. **Woodford:** Diseñó el modelo Nuevo Keynesiano moderno (Curva IS de expectativas, Curva de Phillips con fricciones de precios y Regla de Taylor con gestión de expectativas a futuro), herramienta canónica empleada hoy por los bancos centrales de todo el mundo.
