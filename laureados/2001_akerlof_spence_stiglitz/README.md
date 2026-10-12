# Nobel de Economía 2001: George A. Akerlof, A. Michael Spence y Joseph E. Stiglitz

> **Motivación oficial:** *"for their analyses of markets with asymmetric information"* (Por sus análisis de mercados con información asimétrica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 2001.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras seminales de Akerlof (1970), Spence (1973, 1974), Rothschild y Stiglitz (1976), Stiglitz y Weiss (1981), Shapiro y Stiglitz (1984) y los documentos oficiales del comité Nobel (2001).
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, identificadores de descarga y licencias.
  - [pdf/](referencias/pdf/): Monografía oficial del Nobel descargada de libre acceso (`nobel2001scientific.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con la derivación matemática rigurosa del colapso del mercado de limones de Akerlof, el equilibrio de señalización de Spence bajo la condición de cruce único (*Single-Crossing*) y el racionamiento de crédito de Stiglitz-Weiss.
  - [R/mercados_informacion_asimetrica.R](replicacion/R/mercados_informacion_asimetrica.R): Script autónomo en R que simula numéricamente y mediante Monte Carlo los modelos teóricos de Akerlof, Spence, Rothschild-Stiglitz y Stiglitz-Weiss, generando las figuras y tablas.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución (`fig_akerlof_colapso_limones.png`, `fig_spence_equilibrio_senalizacion.png`) y tabla de resultados (`tab_resultados_informacion.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: selección adversa y colapso en autos usados; intermedio: señalización laboral y equilibrio de Riley; avanzado/reto: selección adversa y racionamiento de crédito bancario).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes completas con resoluciones matemáticas paso a paso y análisis económico aplicado.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha Markdown estructurada con YAML front-matter y secciones canónicas para el portal web estático.

---

## Resumen Ejecutivo del Aporte

George Akerlof, Michael Spence y Joseph Stiglitz sentaron las bases de la moderna **economía de la información**, transformando profundamente la microeconomía y la teoría de los mercados:

1. **George Akerlof y la Selección Adversa (1970):**
   Demostró que en mercados donde los vendedores conocen mejor la calidad del bien que los compradores, el precio refleja únicamente la calidad promedio. Esto incentiva a los dueños de productos de alta calidad a abandonar el mercado, reduciendo sucesivamente la calidad promedio en una espiral que puede culminar en la desaparición completa de las transacciones (*the lemons problem*). Su trabajo explicó el rol vital de garantías, sellos de calidad y regulaciones públicas.

2. **Michael Spence y la Teoría de la Señalización (1973):**
   Explicó cómo los agentes informados pueden superar la desconfianza del mercado emitiendo señales costosas y observables. En el mercado laboral, demostró que la educación puede funcionar como un filtro creíble para distinguir la productividad innata siempre que cumpla la **condición de Spence-Mirrlees (Single-Crossing)**: el costo marginal de educarse debe ser sistemáticamente menor para las personas más productivas.

3. **Joseph Stiglitz y el Mecanismo de Screening (1976, 1981):**
   Estudió cómo la parte desinformada del mercado puede diseñar menús de contratos para inducir la autorrevelación de información privada:
   - **Mercado de seguros (Rothschild y Stiglitz, 1976):** Menús con combinaciones de primas y deducibles para separar clientes de alto y bajo riesgo.
   - **Mercado financiero (Stiglitz y Weiss, 1981):** Explicó el **racionamiento de crédito**, demostrando que subir la tasa de interés atrae a prestatarios arriesgados (selección adversa) e incentiva proyectos peligrosos (riesgo moral), por lo que los bancos maximizan sus beneficios limitando el volumen de crédito en lugar de elevar las tasas.
