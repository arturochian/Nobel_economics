# Nobel de Economía 1983: Gérard Debreu

> **Motivación oficial:**  
> *"for having incorporated new analytical methods into economic theory and for his rigorous reformulation of the theory of general equilibrium"* (Por haber incorporado nuevos métodos analíticos a la teoría económica y por su rigurosa reformulación de la teoría del equilibrio general).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 17 de octubre de 1983.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX verificado con las obras fundamentales de Debreu (*Econometrica* 1954 con Kenneth Arrow, *Theory of Value* 1959, *International Economic Review* 1963 con Herbert Scarf, *PNAS* 1952, *Econometrica* 1970, Discurso Nobel 1984) y los comunicados oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, identificadores DOI, enlaces canónicos y régimen de licencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos en PDF de acceso abierto y notas técnicas del Comité Nobel (1983).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible exhaustivo en Quarto que documenta la fundamentación matemática y topológica del equilibrio general, la demostración axiomática de existencia de precios competitivos y el Teorema del Núcleo de Debreu-Scarf.
  - [R/equilibrio_general_y_nucleo.R](replicacion/R/equilibrio_general_y_nucleo.R): Script autónomo y ejecutable en R que calibra la economía de intercambio puro, grafica la Caja de Edgeworth con tangencia de curvas de indiferencia y simula la contracción del Núcleo hacia el equilibrio walrasiano en economías replicadas ($N = 1, 2, 5, 20, 50$).
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución ([fig_debreu_caja_edgeworth.png](replicacion/salidas/fig_debreu_caja_edgeworth.png), [fig_debreu_convergencia_nucleo.png](replicacion/salidas/fig_debreu_convergencia_nucleo.png)) y tabla cuantitativa de resultados ([tab_resultados_debreu.csv](replicacion/salidas/tab_resultados_debreu.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de trabajo pedagógico con tres ejercicios prácticos graduados (básico: equilibrio Arrow-Debreu en Caja de Edgeworth; intermedio: Teorema de Debreu-Scarf y coaliciones bloqueantes en réplicas; reto: economías regulares, Teorema de Sard e indeterminación de Sonnenschein-Mantel-Debreu).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, demostraciones analíticas completas paso a paso y solucionario exhaustivo con rúbricas cuantitativas para el equipo docente.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con metadatos YAML canónicos para el portal web estático de la colección Nobel.

---

## Resumen Ejecutivo de las Contribuciones

Gérard Debreu (1921–2004), economista y matemático francocanadiense-estadounidense formado en la *École Normale Supérieure* de París e influenciado decisivamente por el grupo Nicolas Bourbaki, transformó la ciencia económica al refundar la teoría del equilibrio general sobre bases matemáticas de rigurosa axiomática:

1. **El Teorema de Existencia Arrow-Debreu (1954):**
   - Junto a Kenneth Arrow (Nobel 1972), resolvió definitivamente la conjetura centenaria de Léon Walras (1874) sobre si las fuerzas descentralizadas de la oferta y la demanda en múltiples mercados interconectados pueden alcanzar simultáneamente un estado de reposo armónico.
   - Demostró que contar el número de ecuaciones e incógnitas (la intuición walrasiana) era matemáticamente insuficiente: se requería probar que el exceso de demanda agregada admite un vector de precios no negativo donde la demanda neta es nula o no positiva.
   - Utilizó la teoría moderna de conjuntos convexos, hiperplanos separadores y el **Teorema de Punto Fijo de Kakutani (1941)** aplicado a correspondencias de exceso de demanda, estableciendo las condiciones mínimas bajo las cuales el equilibrio competitivo existe formalmente.

2. **Monografía Axiomática: *Theory of Value* (1959):**
   - En su obra cumbre (*Theory of Value: An Axiomatic Analysis of Economic Equilibrium*, Monografía 17 de la Cowles Foundation), Debreu despojó a la economía del cálculo diferencial clásico y construyó un marco puramente conjuntista y topológico.
   - Introdujo la noción canónica de bien definido exhaustivamente por cuatro dimensiones: características físicas, localización geográfica, fecha de entrega temporal y estado de la naturaleza condicionante. Esta definición unificada permitió modelar simultáneamente el comercio internacional, el equilibrio intertemporal y los mercados de activos bajo incertidumbre (valores Arrow-Debreu).
   - Formalizó los **Dos Teoremas Fundamentales de la Economía del Bienestar** con máxima generalidad: todo equilibrio competitivo es eficiente en el sentido de Pareto (Primer Teorema), y cualquier asignación óptima de Pareto puede descentralizarse como un equilibrio competitivo mediante transferencias de riqueza a suma fija (Segundo Teorema), apoyado en el teorema del hiperplano de Hahn-Banach.

3. **Teorema del Núcleo y Equivalencia de Debreu-Scarf (1963):**
   - Junto a Herbert Scarf, tendió un puente matemático definitivo entre la teoría de juegos cooperativos (iniciada por Edgeworth en 1881 y formalizada por John von Neumann y Oskar Morgenstern) y el equilibrio walrasiano.
   - Demostró que el **Núcleo** (*Core*) de una economía —el conjunto de asignaciones que ningún subgrupo o coalición de agentes puede bloquear reasignando sus propios recursos— contiene al equilibrio walrasiano.
   - Probó que al replicar la población de agentes hacia el infinito ($N \to \infty$), el Núcleo se contrae monótonamente a una tasa de orden $O(1/N)$ hasta colapsar exactamente en el conjunto de equilibrios walrasianos. Este resultado suministra la justificación teórica más profunda de por qué los mercados perfectamente competitivos emergen espontáneamente cuando el número de participantes es suficientemente amplio.

4. **Economías Regulares y Topología Diferencial (Debreu 1970):**
   - Abordó la crítica de la multiplicidad y estabilidad de equilibrios introduciendo la topología diferencial y el **Teorema de Sard**.
   - Demostró que casi todas las economías (en un sentido de medida completa y conjunto abierto denso en el espacio de dotaciones) son "regulares", lo que garantiza que el conjunto de vectores de precios de equilibrio es finito e insensible localmente a perturbaciones infinitesimales de los fundamentos económicos.
