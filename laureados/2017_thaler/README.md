# Nobel de Economía 2017: Richard H. Thaler

> **Motivación oficial:**  
> *"for his contributions to behavioural economics"* (Por sus contribuciones a la economía conductual).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 9 de octubre de 2017.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Richard Thaler (JPE 2004, JEBO 1980, Marketing Science 1985, Yale University Press 2008, JPE 1990, JPE 1981) y los informes científicos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, DOIs, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento de documentos de libre acceso (`.gitkeep`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación ilustrativa con la derivación de contabilidad mental, conflicto planificador-ejecutor, efecto dotación y la arquitectura del programa *Save More Tomorrow*.
  - [R/simulacion_thaler_conductual.R](replicacion/R/simulacion_thaler_conductual.R): Script autónomo en R que modela la trayectoria de la tasa de ahorro previsional bajo *Save More Tomorrow* frente al status quo neoclásico, y simula el experimento de laboratorio del efecto dotación frente al Teorema de Coase.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución y tablas cuantitativas generadas por la ejecución del script:
    - [fig_ahorro_save_more_tomorrow.png](replicacion/salidas/fig_ahorro_save_more_tomorrow.png): Trayectoria longitudinal de la tasa de contribución al ahorro (% del salario) en 4 incrementos anuales bajo SMarT vs. asesoría tradicional vs. status quo.
    - [fig_efecto_dotacion_mental.png](replicacion/salidas/fig_efecto_dotacion_mental.png): Panel doble que ilustra la asimetría valorativa (densidad WTA vs. WTP con ratio $\approx 2.5$) y el colapso del volumen de transacciones de mercado frente a la predicción de Coase.
    - [tab_resultados_conductuales.csv](replicacion/salidas/tab_resultados_conductuales.csv): Métricas numéricas clave de retención, tasas de ahorro e intercambios de mercado.
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: contabilidad mental, no fungibilidad y falacia del costo hundido; intermedio: diseño matemático de *Save More Tomorrow* y aversión a pérdidas; avanzado/reto: paternalismo libertario, no neutralidad del default y ética de los *sludges* o patrones oscuros).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía pedagógica confidencial con deducciones algebraicas, cálculos paso a paso y rúbrica de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con front-matter YAML para el portal web estático.

---

## Resumen Ejecutivo del Aporte

Richard H. Thaler incorporó supuestos psicológicamente realistas al análisis de la toma de decisiones económicas, fundando la moderna **economía conductual** (*behavioural economics*) y las **finanzas conductuales**:

1. **Racionalidad Limitada y Contabilidad Mental:**
   - Demostró que las personas no gestionan su patrimonio como una cartera financiera única y fungible, sino que clasifican los recursos en cuentas mentales separadas (*mental accounts*), lo que genera comportamientos aparentemente paradójicos como mantener deudas de alto interés en tarjetas de crédito mientras se conservan fondos de bajo rendimiento en cuentas de ahorro.
   - Formalizó la **utilidad de transacción** (el valor psicológico de percibir una "buena oferta") frente a la utilidad de adquisición clásica, y explicó la **falacia del costo hundido** (*sunk cost fallacy*) a través del dolor de cerrar cuentas mentales con pérdidas asumidas.

2. **Autocontrol y el Dilema Intertemporal:**
   - Junto a Hersh Shefrin (1981), formuló el **modelo Planificador-Ejecutor** (*planner-doer model*), resolviendo las tensiones intrapersonales entre el planificador de largo plazo (que desea ahorrar para la vejez) y los múltiples ejecutores de corto plazo dominados por la gratificación inmediata (*present bias*).
   - Desarrolló, junto a Shlomo Benartzi (2004), el programa **Save More Tomorrow™ (SMarT)**, que sincroniza el incremento de las contribuciones a fondos de retiro con futuros aumentos de sueldo, neutralizando la aversión a pérdidas y apalancando la inercia cognitiva a favor del trabajador.

3. **Efecto Dotación y Preferencias Sociales:**
   - Demostró, junto a Daniel Kahneman y Jack Knetsch (1990), que la posesión legal o física de un bien dispara su valoración subjetiva (**efecto dotación** / *endowment effect*), provocando que la disposición a aceptar para venderlo (WTA) duplique con creces la disposición a pagar para comprarlo (WTP), invalidando en la práctica las predicciones del Teorema de Coase.
   - Documentó la relevancia de la **justicia distributiva (*fairness*)**: los consumidores castigan activamente a empresas que aprovechan aumentos repentinos de demanda (como desastres naturales o nevadas) para elevar precios, forzando a los mercados a respetar normas sociales de equidad.

4. **Paternalismo Libertario y "Nudges":**
   - En coautoría con Cass Sunstein (*Nudge*, 2008), introdujo el paradigma de la **arquitectura de las decisiones**: la modificación sutil de las opciones predeterminadas (*defaults*) y el entorno de elección para guiar a las personas hacia decisiones saludables y financieramente sostenibles, preservando plenamente su libertad individual de elección.
