# Nobel de Economía 2024: Daron Acemoglu, Simon Johnson y James A. Robinson

> **Motivación oficial:** *"for studies of how institutions are formed and affect prosperity"* (Por sus estudios sobre cómo se forman las instituciones y cómo afectan a la prosperidad).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 2024.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Acemoglu, Johnson y Robinson (AER 2001, QJE 2002, Handbook 2005, libros 2006 y 2012) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Almacén para documentos de libre acceso (`nobel2024scientific.pdf`, `nobel2024popular.pdf`, `acemoglu2000colonial_w7771.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación completa con derivación econométrica, diagnóstico de instrumentos y discusión de controversias.
  - [R/estimacion_ajr_2001.R](replicacion/R/estimacion_ajr_2001.R): Script autónomo en R que realiza la estimación MCO, la primera etapa y el estimador 2SLS con la muestra de 64 ex-colonias.
  - [datos/](replicacion/datos/): Datos originales del artículo de 2001 (`ajr_2001.csv`, `ajr_2001.dta`).
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_ajr_ols_iv.png`, `fig_ajr_primera_etapa.png`) y tabla de resultados (`tab_regresiones_iv.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: correlación vs causalidad; intermedio: supuesto de exclusión; avanzado: instrumentos débiles y controles geográficos).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes, análisis econométrico formal y respuestas detalladas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Daron Acemoglu, Simon Johnson y James A. Robinson transformaron la comprensión del desarrollo económico al situar a las instituciones sociopolíticas en el centro de las diferencias de riqueza entre naciones:
1. **Instituciones Inclusivas vs. Extractivas:** Las sociedades con reglas del juego que protegen la propiedad privada generalizada, limitan la discrecionalidad del poder político y garantizan igualdad de oportunidades logran innovación sostenida y acumulación de capital. En contraste, las instituciones extractivas concentran el poder y la renta en pocas manos, desincentivando el esfuerzo productivo.
2. **Estrategia Empírica Pionera:** Resolvieron el enigma de la endogeneidad institucional mediante un experimento natural histórico: la tasa de mortalidad enfrentada por los colonizadores europeos entre los siglos XVII y XIX determinó si se establecieron instituciones de poblamiento (inclusivas) o economías de extracción de recursos, un legado que persiste hasta hoy.
3. **Persistencia y Dinámica del Cambio:** Modelaron formalmente cómo las instituciones persisten a través del poder político de facto y de jure (*Economic Origins of Dictatorship and Democracy*, 2006; *Why Nations Fail*, 2012), explicando por qué las élites gobernantes a menudo bloquean tecnologías o reformas modernizadoras que amenazan su control.
