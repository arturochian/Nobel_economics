# Nobel de Economía 2002: Daniel Kahneman y Vernon L. Smith

> **Motivación oficial:**  
> - **Daniel Kahneman:** *"for having integrated insights from psychological research into economic science, especially concerning human judgment and decision-making under uncertainty"* (Por haber integrado conocimientos de la investigación psicológica en la ciencia económica, especialmente en lo relativo al juicio humano y la toma de decisiones bajo incertidumbre).  
> - **Vernon L. Smith:** *"for having established laboratory experiments as a tool in empirical economic analysis, especially in the study of alternative market mechanisms"* (Por haber establecido los experimentos de laboratorio como una herramienta en el análisis económico empírico, especialmente en el estudio de mecanismos de mercado alternativos).  
>  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 9 de octubre de 2002.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Daniel Kahneman y Vernon Smith (Econometrica 1979, J. Risk & Uncertainty 1992, Science 1974, JPE 1962, AER 1976, AER 1982, Econometrica 1988) y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes bibliográficas, DOIs, enlaces y licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento de documentos de libre acceso (`.gitkeep`).
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto reproducible con la derivación matemática de la Teoría Prospectiva, la teoría del valor inducido y la dinámica de la subasta doble.
  - [R/teoria_prospectiva_y_mercados_exp.R](replicacion/R/teoria_prospectiva_y_mercados_exp.R): Script autónomo en R que modela la función de valor con aversión a pérdidas, la función de ponderación no lineal de probabilidades de Kahneman y Tversky, y simula la convergencia del mercado experimental smithiano de subasta doble continua.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución y datos cuantitativos generados por el script:
    - [fig_kahneman_prospect_theory.png](replicacion/salidas/fig_kahneman_prospect_theory.png): Panel doble con la función de valor $v(x)$ asimétrica ($\lambda = 2.25$, $\alpha = \beta = 0.88$) y la curva de ponderación no lineal $w(p)$ en forma de "S" invertida.
    - [fig_smith_subasta_doble_convergencia.png](replicacion/salidas/fig_smith_subasta_doble_convergencia.png): Panel doble con las curvas de oferta y demanda escalonadas inducidas y la trayectoria temporal de convergencia hacia el precio competitivo ($P^* = \$3.00$).
    - [tab_resultados_experimentales.csv](replicacion/salidas/tab_resultados_experimentales.csv): Tabla de métricas por ronda: dispersión, coeficiente de convergencia $\alpha$ de Smith y eficiencia asignativa ($100\%$).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: aversión a pérdidas vs. utilidad esperada neoclásica; intermedio: ponderación no lineal de probabilidades, equivalentes de certeza y equilibrio experimental de Smith; avanzado/reto: efecto dotación, colapso de Coase y burbujas especulativas en mercados de activos).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Guía pedagógica con deducciones analíticas completas, cálculos aritméticos paso a paso y rúbrica formativa de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con front-matter YAML para el portal web estático.

---

## Resumen Ejecutivo del Aporte

El Premio Nobel de 2002 marcó un punto de inflexión epistemológico en la historia del pensamiento económico moderno, fusionando la psicología experimental y el diseño institucional empírico en la ciencia económica:

### 1. Daniel Kahneman: Integración de la Psicología y Economía Conductual
- **Crítica a la Utilidad Esperada:** Demostró sistemáticamente que los seres humanos violan los axiomas de von Neumann-Morgenstern (efecto certeza, efecto marco, aislamiento).
- **Teoría Prospectiva (*Prospect Theory*, 1979, 1992):** Formalizó una teoría descriptiva basada en:
  1. *Dependencia del punto de referencia:* Las decisiones se evalúan en términos de ganancias y pérdidas relativas al *status quo*.
  2. *Aversión a las pérdidas (*loss aversion*):* El sufrimiento psicológico generado por una pérdida económica es significativamente más intenso que el bienestar derivado de una ganancia simétrica ($\lambda \approx 2.25$).
  3. *Ponderación no lineal de probabilidades:* Sobreponderación de eventos raros pero extremos y subponderación de probabilidades intermedias y altas.
- **Heurísticas y Sesgos Cognitivos (1974):** Identificó mecanismos mentales sistemáticos como la representatividad, la disponibilidad y el anclaje, sentando las bases del paradigma de los Dos Sistemas de pensamiento (*Thinking, Fast and Slow*).

### 2. Vernon L. Smith: Fundación de la Economía Experimental
- **Teoría del Valor Inducido (*Induced Value Theory*, 1976):** Estableció los preceptos metodológicos (no saciedad, saliencia, dominancia y privacidad de la información) que permiten controlar las motivaciones de los participantes en el laboratorio mediante incentivos monetarios reales.
- **La Subasta Doble Continua (*Double Auction*, 1962):** Probó que no se requiere omnisciencia ni información perfecta para alcanzar el equilibrio competitivo marshalliano: bajo instituciones con reglas de interacción apropiadas, un puñado de agentes con información privada convergen rápidamente al precio teórico y extraen prácticamente el $100\%$ del excedente social.
- **Bancos de Pruebas Institucionales (*Testbed Experiments*):** Convirtió el laboratorio en un túnel de viento para evaluar diseños de mercado complejos antes de su implementación en el mundo real, transformando la regulación de los mercados eléctricos mayoristas, la asignación de franjas horarias de aterrizaje y las subastas de derechos de emisión y espectro.

---

## Instrucciones de Ejecución

Para replicar las simulaciones cuantitativas y regenerar todas las figuras y tablas:

```powershell
# En terminal de Windows / PowerShell desde la raíz del proyecto
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" laureados/2002_kahneman_smith/replicacion/R/teoria_prospectiva_y_mercados_exp.R
```
