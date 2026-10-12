# Nobel de Economía 2009: Elinor Ostrom y Oliver E. Williamson

> **Motivación oficial:**  
> - **Elinor Ostrom:** *"for her analysis of economic governance, especially the commons"* (Por su análisis de la gobernanza económica, especialmente los bienes comunes).  
> - **Oliver E. Williamson:** *"for his analysis of economic governance, especially the boundaries of the firm"* (Por su análisis de la gobernanza económica, especialmente los límites de la empresa).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 12 de octubre de 2009.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras fundamentales de Ostrom (1990, 1994), Williamson (1975, 1985, 1991), Hardin (1968) y los informes de la Real Academia Sueca de Ciencias (2009).
  - [manifest.csv](referencias/manifest.csv): Inventario sistemático de fuentes, identificadores DOI, URLs y derechos de uso.
  - [pdf/](referencias/pdf/): Documentos oficiales de libre acceso de la Fundación Nobel (`nobel2009scientific.pdf`, `nobel2009popular.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con formulación analítica y computacional del dilema de extracción en recursos de uso común (CPR) de Ostrom y la selección de estructuras discretas de gobernanza bajo costos de transacción de Williamson.
  - [R/gobernanza_comunes_y_empresas.R](replicacion/R/gobernanza_comunes_y_empresas.R): Script autónomo en R que modela ambos marcos teóricos y genera los artefactos visuales y tabulares.
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución ([fig_ostrom_dilema_comunes.png](replicacion/salidas/fig_ostrom_dilema_comunes.png), [fig_williamson_costos_transaccion.png](replicacion/salidas/fig_williamson_costos_transaccion.png)) y tabla resumen de resultados ([tab_gobernanza_resultados.csv](replicacion/salidas/tab_gobernanza_resultados.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios aplicados de dificultad progresiva (básico: los 8 principios de diseño institucional de Ostrom frente al sobrepastoreo; intermedio: especificidad de activos y el problema del chantaje contractual o *hold-up* de Williamson; avanzado/reto: gobernanza policéntrica de cuencas hídricas vs. integración vertical en semiconductores).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pauta confidencial de evaluación con soluciones analíticas, deducciones formales, criterios de corrección y sugerencias didácticas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha en Markdown estructurada con YAML front-matter lista para el portal web.

---

## Resumen Ejecutivo del Aporte

Elinor Ostrom y Oliver E. Williamson demostraron que la gobernanza económica trasciende con creces la dicotomía tradicional entre el mercado libre desregulado y el Estado centralizado planificador:

1. **Elinor Ostrom y la Gobernanza de los Bienes Comunes (Ostrom 1990, 1994):**
   Ostrom refutó el dogma imperante de la "Tragedia de los Comunes" (*Tragedy of the Commons*, formulada por Garrett Hardin en 1968), el cual sostenía que los recursos compartidos están inexorablemente condenados a la sobreexplotación a menos que sean privatizados o estatizados. A través de extensos estudios empíricos de campo (sistemas de regadío en España y Filipinas, pastizales alpinos en Suiza, bosques comunales en Nepal y pesquerías costeras en Turquía) y experimentos controlados de laboratorio, Ostrom descubrió que las comunidades locales son capaces de autogobernarse eficazmente. Identificó **8 principios de diseño institucional** (límites claros, reglas adaptadas al contexto local, toma colectiva de decisiones, monitoreo mutuo, sanciones graduales, resolución rápida de disputas, reconocimiento gubernamental y estructuras anidadas policéntricas) que garantizan la sostenibilidad ecológica y económica a largo plazo sin necesidad de coerción centralizada ni parcelación privada.

2. **Oliver E. Williamson y los Límites de la Empresa (Williamson 1975, 1985, 1991):**
   Williamson construyó las bases operativas de la **Economía de Costos de Transacción** (*Transaction Cost Economics* - TCE), operacionalizando la intuición seminal de Ronald Coase (1937). Williamson explicó por qué existen las empresas y cuáles son sus límites mediante la interacción entre dos supuestos conductuales (la **racionalidad limitada** de los seres humanos y su propensión potencial al **oportunismo**) y dos características de las transacciones: la **especificidad de los activos** (*asset specificity*) y la incertidumbre. Cuando los activos no son específicos, el mercado es superior porque aporta incentivos de alta potencia. Sin embargo, cuando se requieren inversiones fuertemente específicas (en capital físico, localización geográfica o capital humano dedicado), los contratos de mercado son vulnerables al chantaje oportunista (*hold-up problem*). Ante costos contractuales prohibitivos, la jerarquía interna (la empresa integrada) se convierte en la forma discreta más eficiente al permitir la resolución de conflictos mediante autoridad y directiva interna (*fiat*). Entre ambos extremos, Williamson delimitó las formas híbridas (franquicias, *joint ventures* y contratos relacionales).
