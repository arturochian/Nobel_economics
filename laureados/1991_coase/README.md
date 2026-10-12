# Nobel de Economía 1991: Ronald H. Coase

> **Motivación oficial:** *"for his discovery and clarification of the significance of transaction costs and property rights for the institutional structure and functioning of the economy"* (Por su descubrimiento y clarificación del significado de los costos de transacción y los derechos de propiedad para la estructura institucional y el funcionamiento de la economía).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 15 de octubre de 1991.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras cumbre de Ronald H. Coase (1937–1992) y los documentos oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de libre acceso y reportes oficiales del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y formal del Teorema de Coase, las fricciones de transacción y la frontera óptima de la empresa.
  - [R/teorema_coase_y_costos_transaccion.R](replicacion/R/teorema_coase_y_costos_transaccion.R): Script autónomo en R que simula y grafica el equilibrio de negociación de externalidades, la sensibilidad a costos de transacción y la frontera de la firma ante disrupciones digitales.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_coase_negociacion_externalidad.png](replicacion/salidas/fig_coase_negociacion_externalidad.png), [fig_coase_frontera_empresa.png](replicacion/salidas/fig_coase_frontera_empresa.png)) y tabla de resultados numéricos ([tab_resultados_coase.csv](replicacion/salidas/tab_resultados_coase.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 ejercicios prácticos (básico sobre el conflicto del médico y el confitero *Sturges v. Bridgman*; intermedio sobre costos de transacción positivos, multiplicidad de víctimas y reglas de responsabilidad de Calabresi-Melamed; avanzado/reto en R sobre la frontera *Make or Buy* de la empresa en la era de plataformas digitales).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, derivaciones matemáticas completas, código R reproducible para el reto de la frontera de la empresa y rúbrica analítica confidencial para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

Ronald H. Coase (1910–2013) revolucionó los fundamentos de la microeconomía al demostrar que los mercados y los intercambios no ocurren en una pizarra abstracta sin costo, sino dentro de una estructura institucional de contratos, derechos de propiedad y organizaciones jerárquicas:

1. **La Naturaleza de la Empresa (*The Nature of the Firm*, 1937):** Formuló una pregunta elemental que la ciencia económica había ignorado: *si los precios de mercado asignan los recursos eficientemente, ¿por qué existen las empresas y la autoridad del jefe?* Coase descubrió el concepto de **costos de transacción**: recurrir al mercado acarrea costos reales (búsqueda de precios, negociación y redacción de contratos independientes para cada operación, riesgo de oportunismo). La empresa sustituye al mercado cuando resulta más económico coordinar actividades mediante la dirección consciente del empresario. El tamaño óptimo de la firma se fija donde el costo marginal de organizar una transacción internamente iguala al costo marginal de transarla en el mercado abierto.
2. **El Problema del Costo Social (*The Problem of Social Cost*, 1960):** Desafió la doctrina pigouviana tradicional según la cual las externalidades deben ser corregidas mecánicamente por el Estado mediante impuestos o prohibiciones. Coase probó que los daños tienen una **naturaleza recíproca**: proteger al perjudicado implica infligir un costo al emisor. Bajo el célebre **Teorema de Coase**, demostró que si los costos de transacción son nulos y los derechos de propiedad están claramente delimitados, las partes negociarán privadamente hasta alcanzar la asignación de recursos socialmente eficiente, con total independencia de a quién asigne la ley la titularidad inicial. Sin embargo, en el mundo real donde los costos de transacción son positivos ($T > 0$), la delimitación jurídica inicial de los derechos y la arquitectura institucional determinan críticamente la eficiencia y la riqueza generada.
3. **El Espectro Radioeléctrico y las Subastas de Frecuencias (1959):** Propuso por primera vez sustituir la asignación burocrática discrecional del espectro de telecomunicaciones por derechos de propiedad transables y subastas de mercado, sentando las bases de las modernas subastas de la FCC que han recaudado cientos de miles de millones de dólares a nivel global.
4. **El Faro en la Economía (*The Lighthouse in Economics*, 1974):** Cuestionó la tesis clásica de los libros de texto que consideraba al faro como un bien público puro que jamás podía ser provisto por el mercado privado, demostrando mediante evidencia histórica que en Gran Bretaña los faros fueron construidos y operados con éxito por agentes privados financiados mediante peajes portuarios.

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde la raíz del proyecto:

```bash
# Ejecutar script R
Rscript laureados/1991_coase/replicacion/R/teorema_coase_y_costos_transaccion.R
```

Para renderizar el informe de Quarto:

```bash
quarto render laureados/1991_coase/replicacion/replicar.qmd
```
