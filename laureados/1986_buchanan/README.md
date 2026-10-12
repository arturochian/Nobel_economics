# Nobel de Economía 1986: James M. Buchanan Jr.

> **Motivación oficial:** *"for his development of the contractual and constitutional bases for the theory of economic and political decision-making"* (Por su desarrollo de las bases contractuales y constitucionales para la teoría de la toma de decisiones económicas y políticas).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 16 de octubre de 1986.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras cumbre de James M. Buchanan Jr. y Gordon Tullock (1949–1987) y los documentos oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de libre acceso y reportes oficiales del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y formal del modelo de reglas de votación de Buchanan-Tullock, la búsqueda de rentas de Tullock y la economía constitucional.
  - [R/eleccion_publica_y_reglas_votacion.R](replicacion/R/eleccion_publica_y_reglas_votacion.R): Script autónomo en R que simula y grafica el equilibrio de la regla óptima de votación colectiva, la sensibilidad entre materias ordinarias y constitucionales, y la disipación agregada en concursos de cabildeo.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_buchanan_regla_optima_votacion.png](replicacion/salidas/fig_buchanan_regla_optima_votacion.png), [fig_buchanan_disipacion_rentas.png](replicacion/salidas/fig_buchanan_disipacion_rentas.png)) y tabla de resultados numéricos ([tab_resultados_buchanan.csv](replicacion/salidas/tab_resultados_buchanan.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 ejercicios prácticos (básico sobre el modelo de Buchanan-Tullock de regla de mayoría óptima; intermedio sobre el concurso de Tullock y la disipación del excedente social frente a Harberger; avanzado/reto en R sobre la ilusión fiscal, el sesgo al déficit y las reglas presupuestarias constitucionales).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, derivaciones matemáticas completas, código R reproducible para el reto de dinámica fiscal y rúbrica analítica confidencial para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

James M. Buchanan Jr. (1919–2013) transformó los cimientos de la ciencia económica y la teoría política al desmitificar la benevolencia del Estado y aplicar las herramientas del análisis microeconómico al comportamiento del sector público:

1. **"Política sin Romanticismo" (*Politics without Romance*):** Antes de Buchanan, la teoría económica tradicional modelaba a los consumidores y empresarios como agentes racionales maximizadores en el mercado, pero suponía ingenuamente que los gobernantes y burócratas eran agentes desinteresados orientados a maximizar una abstracta "función de bienestar social". Buchanan unificó el método bajo el **individualismo metodológico**: los políticos compiten por votos y reelección, los burócratas buscan expandir el presupuesto y la influencia de sus departamentos, y los grupos de presión intercambian favores legislativos (*logrolling* y *pork barrel*).
2. **El Cálculo del Consenso (*The Calculus of Consent*, 1962):** En colaboración con Gordon Tullock, demostró que la regla de decisión democrática es el resultado de minimizar la suma de dos costos: los **costos externos** $C(K)$ (el riesgo de que una mayoría circunstancial imponga tributos o leyes lesivas a la minoría) y los **costos de toma de decisión** $D(K)$ (el tiempo y concesiones necesarias para alcanzar el consenso). Demostraron que la regla de mayoría simple (50% + 1) carece de cualquier santidad natural; en materias constitucionales y de derechos de propiedad, la regla óptima exige **mayorías calificadas** (dos tercios o tres cuartos) o cuasi-unanimidad.
3. **Economía Constitucional (Dos Etapas Decisionales):** Distinguió tajantemente entre la **etapa constitucional** (donde los ciudadanos eligen las reglas del juego tras un velo de incertidumbre y se requiere amplio consenso) y la **etapa post-constitucional** (donde se juega dentro de las reglas preestablecidas, delegando materias operativas a mayorías simples o representativas).
4. **Búsqueda de Rentas (*Rent-Seeking*) y Pérdida Social:** Formuló junto a Tullock la teoría de que la intervención estatal en forma de cuotas, licencias o monopolios crea rentas artificiales que incitan a las empresas a gastar enormes sumas en cabildeo y relaciones públicas. Este gasto no crea riqueza sino que disipa el excedente social, multiplicando el daño del intervencionismo muy por encima del clásico triángulo de pérdida irrecuperable de Harberger.
5. **Ilusión Fiscal y Reglas Presupuestarias Vinculantes:** Mostró que las democracias representativas sufren un sesgo crónico hacia el déficit público y la deuda soberana, ya que los votantes perciben los beneficios del gasto público inmediato pero descuentan de forma irracional los impuestos futuros que recaerán sobre las próximas generaciones. Por ello, Buchanan fue el pionero intelectual de las **enmiendas de presupuesto equilibrado** y los frenos constitucionales a la deuda (*debt brakes*).

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde la raíz del proyecto:

```bash
# Ejecutar script R
Rscript laureados/1986_buchanan/replicacion/R/eleccion_publica_y_reglas_votacion.R
```

Para renderizar el informe de Quarto:

```bash
# Renderizar reporte en Quarto
quarto render laureados/1986_buchanan/replicacion/replicar.qmd
```
