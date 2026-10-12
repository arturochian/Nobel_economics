# Nobel de Economía 2013: Eugene F. Fama, Lars Peter Hansen y Robert J. Shiller

> **Motivación oficial:** *"for their empirical analysis of asset prices"* (Por su análisis empírico de los precios de los activos).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 2013.  
> **Distribución:** Eugene F. Fama (1/3), Lars Peter Hansen (1/3), Robert J. Shiller (1/3).

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con los artículos seminales de Fama, Hansen y Shiller y el documento oficial de antecedentes científicos de la Real Academia Sueca de Ciencias.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs, estado de acceso y licencias de las obras analizadas.
  - [pdf/](referencias/pdf/): Directorio preparado para almacenamiento de versiones de acceso público.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación empírica y metodológica de los tres pilares del premio.
  - [R/analisis_precios_activos.R](replicacion/R/analisis_precios_activos.R): Script autónomo en R que ejecuta las simulaciones y estimaciones econométricas: test de volatilidad de Shiller (1981), modelo de tres factores de Fama-French (1993) y estimación GMM con test $J$ de Hansen (1982).
  - [salidas/](replicacion/salidas/): Figuras generadas en alta resolución ([`fig_shiller_exceso_volatilidad.png`](replicacion/salidas/fig_shiller_exceso_volatilidad.png), [`fig_fama_french_factores.png`](replicacion/salidas/fig_fama_french_factores.png)) y tabla de estimaciones consolidadas ([`tab_estimacion_activos.csv`](replicacion/salidas/tab_estimacion_activos.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía de 3 problemas prácticos secuenciales sin resolución: eficiencia débil vs. semifuerte y alfa de Jensen (básico), la paradoja de Shiller y exceso de volatilidad (intermedio), y estimación GMM de la ecuación de Euler de consumo CCAPM y cota Hansen-Jagannathan (reto).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas pedagógicas, demostraciones matemáticas completas, códigos explicativos y soluciones detalladas para el profesor.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha técnica y pedagógica formateada con metadatos YAML para el sitio web del proyecto, incluyendo "Antes y después" y aplicaciones prácticas contemporáneas fechadas.

---

## Resumen Ejecutivo del Aporte

El Premio Nobel de Economía 2013 reconoció una aparente paradoja que definió las finanzas modernas: **los precios de los activos son sumamente difíciles de predecir en el corto plazo (días o semanas), pero exhiben patrones significativos de predictibilidad en horizontes largos (tres a cinco años)**. Tres economistas aportaron las herramientas teóricas y econométricas fundamentales para entender esta dinámica:

1. **Eugene F. Fama (1970, 1993):**
   - Formalizó la **Hipótesis de Mercados Eficientes** (*Efficient Market Hypothesis*, EMH), demostrando que a corto plazo los precios reflejan con rapidez la información disponible, comportándose como un paseo aleatorio (*random walk*) o martingala donde los retornos futuros no pueden pronosticarse con reglas técnicas o datos públicos pasados.
   - Demostró el problema de la **hipótesis conjunta** (*joint hypothesis problem*): cualquier prueba de eficiencia de mercado es simultáneamente una prueba del modelo de equilibrio de precios asumido.
   - Desarrolló junto a Kenneth French el **Modelo de Tres Factores (1993)**, superando las limitaciones del CAPM clásico al mostrar que las anomalías de tamaño (*Small Minus Big*, SMB) y valor (*High Minus Low*, HML) reflejan primas de riesgo sistemático multidimensional y no ineficiencias de mercado.

2. **Robert J. Shiller (1981, 1988):**
   - Demostró la **Paradoja de Exceso de Volatilidad**: los precios de las acciones fluctúan sustancialmente más de lo que podría justificar el valor presente descontado de los dividendos futuros posteriores ($Var(P_t) \gg Var(P_t^*)$).
   - Desarrolló, junto a John Campbell, técnicas de descomposición de la varianza del ratio dividendo-precio que revelaron que las fluctuaciones de mercado no provienen de noticias sobre dividendos futuros, sino de cambios temporales en las tasas de descuento y el apetito por el riesgo de los inversionistas.
   - Popularizó el ratio **CAPE** (*Cyclically Adjusted Price-to-Earnings* o Shiller P/E), probando que las valuaciones extremas del mercado predicen retornos reales inferiores a largo plazo, abriendo la puerta a las finanzas conductuales (*behavioral finance*).

3. **Lars Peter Hansen (1982; Hansen y Singleton 1982):**
   - Desarrolló el **Método Generalizado de Momentos** (*Generalized Method of Moments*, GMM), el marco econométrico fundamental para estimar y contrastar modelos de valoración de activos dinámicos no lineales sin requerir supuestos restrictivos sobre la distribución conjunta de las variables (como normalidad o homocedasticidad).
   - Introdujo el **Test $J$ de Hansen** para evaluar restricciones sobreidentificadas, permitiendo contrastar rigurosamente si las condiciones de primer orden (ecuaciones de Euler de consumo intertemporal) se sostienen en los datos empíricos.
   - Sentó las bases analíticas (junto a Ravi Jagannathan) de las cotas de volatilidad del factor de descuento estocástico (*Hansen-Jagannathan bounds*), unificando la macroeconomía y la economía financiera moderna.
