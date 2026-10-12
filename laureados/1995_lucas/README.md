# Nobel de Economía 1995: Robert E. Lucas Jr.

> **Motivación oficial:** *"for having developed and applied the hypothesis of rational expectations, and thereby having transformed macroeconomic analysis and deepened our understanding of economic policy"* (por haber desarrollado y aplicado la hipótesis de expectativas racionales, y con ello haber transformado el análisis macroeconómico y profundizado nuestra comprensión de la política económica).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 10 de octubre de 1995.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Entradas BibTeX verificadas de las obras seminales de Lucas (1972, 1973, 1976, 1978, 1988, 1990) y los documentos oficiales del comité Nobel (comunicado de prensa e información científica avanzada).
  - [manifest.csv](referencias/manifest.csv): Inventario sistemático de fuentes, identificadores DOI, enlaces canónicos y licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio preparado para albergar documentos y reportes oficiales de la Real Academia Sueca de Ciencias.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Documento Quarto reproducible con desarrollo matemático exhaustivo de la extracción de señal de Lucas y la demostración formal de la Crítica de Lucas.
  - [R/critica_lucas_y_expectativas.R](replicacion/R/critica_lucas_y_expectativas.R): Script autónomo y modular en R que simula numéricamente el problema de extracción de señal, la hipótesis de varianza internacional y el colapso de los coeficientes de política reducidos.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución (`fig_lucas_extraccion_senal.png`, `fig_lucas_critica_politica.png`) y matriz de resultados cuantitativos consolidada (`tab_resultados_lucas.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica estructurada con tres niveles de dificultad (básico: extracción de señal y proyección lineal; intermedio: la Crítica de Lucas y colapso de parámetros; avanzado/reto: crecimiento endógeno con capital humano y la Paradoja de Lucas).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Manual confidencial para profesores con derivaciones analíticas paso a paso, demostraciones formales, soluciones numéricas y rúbrica de corrección pedagógica.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica con metadatos estructurados en YAML para el portal web del proyecto Nobel_economics.

---

## Resumen Ejecutivo del Aporte

Robert E. Lucas Jr. lideró la llamada **revolución de las expectativas racionales**, transformando para siempre la metodología macroeconómica y la teoría de la política económica:

1. **El Modelo de las Islas y la Extracción de Señal (1972, 1973):**
   - Demostró que una relación positiva transitoria entre inflación y producto no requiere suponer irracionalidad ni miopía en los agentes, sino que puede surgir como consecuencia de **información imperfecta** sobre precios locales versus el nivel general de precios.
   - El coeficiente de oferta $\theta = \frac{\sigma_z^2}{\sigma_z^2 + \sigma_p^2}$ disminuye conforme aumenta la volatilidad nominal agregada $\sigma_p^2$. En países con inflación crónica y errática, los productores descuentan las subidas de precios y la curva de Phillips agregada se vuelve estrictamente vertical, invalidando el estímulo monetario.

2. **La Crítica de Lucas y la Invarianza de Parámetros (1976):**
   - Lucas probó que los coeficientes de las regresiones macroeconométricas tradicionales de forma reducida no son constantes estructurales, sino que dependen de las reglas de política vigentes.
   - Cuando el banco central o el gobierno modifican sistemáticamente sus reglas para intentar explotar una correlación empírica histórica, los agentes forward-looking adaptan sus expectativas racionales, haciendo colapsar los parámetros estimados y provocando el fracaso sistemático de las proyecciones macroeconómicas.
   - Este hallazgo forzó a la disciplina a abandonar los modelos ad-hoc y fundar la macroeconomía en **microfundamentos estructurales** basados en preferencias y tecnología profunda, sentando las bases de los modelos DSGE contemporáneos.

3. **Capital Humano y la Paradoja de Lucas (1988, 1990):**
   - En teoría del crecimiento, formalizó el rol del capital humano con externalidades como motor autónomo de expansión económica endógena de largo plazo.
   - En economía internacional, planteó la célebre Paradoja de Lucas: por qué el capital internacional no fluye masivamente de los países ricos a los países pobres donde su productividad marginal teórica es astronómicamente más alta, señalando el papel determinante del capital humano, los derrames tecnológicos y las garantías institucionales.

---

## Cómo Ejecutar la Replicación

Para reproducir computacionalmente los modelos, generar las figuras y verificar las tablas desde PowerShell:

```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" laureados/1995_lucas/replicacion/R/critica_lucas_y_expectativas.R
```

O dentro de una sesión interactiva de R:

```r
source("laureados/1995_lucas/replicacion/R/critica_lucas_y_expectativas.R")
```

Las figuras se generarán automáticamente en `laureados/1995_lucas/replicacion/salidas/`:
- `fig_lucas_extraccion_senal.png`
- `fig_lucas_critica_politica.png`
- `tab_resultados_lucas.csv`
