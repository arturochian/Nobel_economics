# Nobel de Economía 2000: James J. Heckman y Daniel L. McFadden

> **Motivación oficial:**  
> - **James J. Heckman:** *"for his development of theory and methods for analyzing selective samples"* (Por su desarrollo de la teoría y métodos para el análisis de muestras selectivas).  
> - **Daniel L. McFadden:** *"for his development of theory and methods for analyzing discrete choice"* (Por su desarrollo de la teoría y métodos para el análisis de la elección discreta).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 11 de octubre de 2000.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Heckman (Econometrica 1974, Econometrica 1979, NBER 1976) y McFadden (Academic Press 1974, JPubE 1974, TRB 1978), junto con los informes científicos oficiales de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, identificadores DOI, URLs y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Repositorio local de documentos de libre acceso (`nobel2000scientific.pdf`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación econométrica integral con deducción matemática, simulación estocástica en R, estimación en dos etapas de Heckit y modelo Logit Condicional de McFadden.
  - [R/modelo_eleccion_y_seleccion.R](replicacion/R/modelo_eleccion_y_seleccion.R): Script autónomo en R modular que ejecuta la simulación, calcula la razón inversa de Mills, estima el logit condicional por máxima verosimilitud y genera los artefactos visuales y tabulares.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_heckman_sesgo_seleccion.png`, `fig_mcfadden_eleccion_probabilidades.png`) y tabla de resultados comparativos (`tab_resultados_estimacion.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía práctica con tres niveles de ejercitación pedagógica (Nivel 1 Básico: Intuición y cálculo manual de la razón inversa de Mills; Nivel 2 Intermedio: Restricciones de exclusión y multicolinealidad en Heckit; Nivel 3 Reto Avanzado: Propiedad de Independencia de Alternativas Irrelevantes - IIA en Logit Multinomial y paradoja del autobús rojo/azul).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía metodológica para docentes con derivaciones algebraicas rigurosas, notas didácticas, trampas conceptuales frecuentes y código de respuesta detallado.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter y secciones canónicas para el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

James J. Heckman y Daniel L. McFadden sentaron los cimientos de la **microeconometría moderna**, dotando a la ciencia económica y a las ciencias sociales aplicadas de herramientas cuantitativas para analizar decisiones individuales en situaciones del mundo real donde las hipótesis estadísticas estándar fracasan:

1. **James J. Heckman y el Sesgo de Selección Muestral:**
   - *El Problema:* En datos socioeconómicos observacionales, rara vez contamos con asignación aleatoria. Quienes participan en el mercado laboral, acceden a un programa social o asisten a la universidad no son una muestra aleatoria de la población, sino un grupo autoseleccionado en función de beneficios individuales anticipados. Estimar por MCO en la muestra de participantes genera un sesgo severo equivalente a omitir una variable relevante.
   - *El Aporte:* Heckman conceptualizó el sesgo de selección como un error de especificación por variable omitida y formuló el célebre **Método en Dos Etapas de Heckman (Heckit)**. Mediante un modelo Probit de participación en la primera etapa, calcula la **Razón Inversa de Mills** ($\lambda$), la cual se introduce como regresor de control en la ecuación sustantiva de salarios para restaurar estimadores insesgados y consistentes.

2. **Daniel L. McFadden y los Modelos de Elección Discreta:**
   - *El Problema:* Los modelos de regresión lineal tradicionales asumían variables dependientes continuas, resultando inadecuados para estudiar decisiones cualitativas discretas entre múltiples alternativas mutuamente excluyentes (elegir medio de transporte, ocupación laboral, lugar de residencia o tecnología de consumo).
   - *El Aporte:* McFadden integró la teoría microeconómica del consumidor con modelos estocásticos a través del **Modelo de Utilidad Aleatoria** (*Random Utility Model*, RUM). Al asumir perturbaciones con distribución de valor extremo tipo I (Gumbel), derivó analíticamente el **Logit Condicional** (*Conditional Logit* / Multinomial Logit), permitiendo modelar probabilidades de elección en función de los atributos de las alternativas y de los individuos.
   - *Impacto Práctico:* Su estudio predictivo sobre la demanda del sistema de tránsito rápido de la bahía de San Francisco (**BART**) en la década de 1970 demostró una precisión asombrosa frente a los modelos tradicionales, transformando para siempre la planificación urbana, el marketing cuantitativo y la organización industrial.
