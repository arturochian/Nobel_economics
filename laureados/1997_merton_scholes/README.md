# Nobel de Economía 1997: Robert C. Merton y Myron S. Scholes (con Fischer Black *in memoriam*)

> **Motivación oficial:**  
> *"for a new method to determine the value of derivatives"* (Por un nuevo método para determinar el valor de los derivados).  
> **Reconocimiento especial del comité:** La Real Academia Sueca de Ciencias destacó explícitamente que la fórmula pionera fue desarrollada en colaboración con **Fischer Black** (1938–1995), quien falleció dos años antes de la concesión del premio.  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 14 de octubre de 1997.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las publicaciones seminales de Black & Scholes (*JPE* 1973), Merton (*Bell Journal* 1973, *J. Finance* 1974, libro 1990), Cox, Ross & Rubinstein (*JFE* 1979) y los documentos del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de fuentes, DOIs, URLs y estado de licencias de las referencias.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos y notas de referencia.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte Quarto de replicación exhaustivo con la fundamentación estocástica, derivación matemática, implementación en R, cálculo de sensibilidades (las "Griegas"), simulación Monte Carlo, árboles binomiales y el modelo estructural de crédito de Merton.
  - [R/black_scholes_merton.R](replicacion/R/black_scholes_merton.R): Script autónomo y modular en R con todas las funciones de valoración analítica, árboles binomiales CRR, simulación Monte Carlo y generación de figuras y tablas.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_bsm_precio_y_griegas.png](replicacion/salidas/fig_bsm_precio_y_griegas.png), [fig_bsm_convergencia_monte_carlo.png](replicacion/salidas/fig_bsm_convergencia_monte_carlo.png)) y tabla de comparación numérica ([tab_resultados_bsm.csv](replicacion/salidas/tab_resultados_bsm.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con tres actividades prácticas graduadas (básico: valoración manual e interpretación de paridad Put-Call; intermedio: cobertura dinámica Delta-Hedging y Gamma; reto: modelo de Merton de riesgo de crédito corporativo y cálculo de spreads de quiebra).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes, derivaciones algebraicas rigurosas de la ecuación diferencial parcial (PDE) de Black-Scholes, lema de Itô, y solucionario detallado de todos los ejercicios.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada en Markdown con YAML front-matter para el sitio web estático.

---

## Resumen Ejecutivo del Aporte

Fischer Black, Myron S. Scholes (1973) y Robert C. Merton (1973, 1974) transformaron radicalmente la economía financiera moderna al resolver un problema que había eludido a los teóricos durante casi un siglo: **cómo fijar el precio de un contrato de opción sin requerir conocer la tasa esperada de retorno del activo subyacente ni las preferencias individuales de riesgo de los inversores**.

1. **La Cartera de Réplica Dinámica y la Eliminación del Riesgo:**
   Black y Scholes demostraron que al combinar una posición en la opción con una posición continuamente ajustada en el activo subyacente ($\Delta = \partial C / \partial S$), el riesgo estocástico derivado de las fluctuaciones brownianas se cancela exactamente en tiempo continuo. Por principio de no arbitraje, esta cartera perfectamente cubierta debe rendir forzosamente la **tasa de interés libre de riesgo** ($r$).

2. **La Ecuación Diferencial Parcial de Black-Scholes y la Fórmula Cerrada:**
   Mediante el lema de Itô, formularon la ecuación diferencial parabólica:
   $$\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + r S \frac{\partial V}{\partial S} - r V = 0$$
   Su solución cerrada para una opción de compra (*call*) europea es:
   $$C(S, t) = S \mathcal{N}(d_1) - K e^{-r(T-t)} \mathcal{N}(d_2)$$
   donde la volatilidad ($\sigma$) es el único parámetro no observable directamente en los mercados.

3. **Las Extensiones Fundamentales de Merton:**
   Robert C. Merton generalizó el marco al eliminar restricciones restrictivas del modelo original:
   - Incorporó el pago continuo de dividendos ($q$), esencial para índices bursátiles y divisas (modelo de Garman-Kohlhagen).
   - Desarrolló el **modelo estructural de riesgo crediticio** (Merton 1974), donde el patrimonio neto de una empresa endeudada se interpreta como una opción de compra sobre los activos totales de la firma, fundando la cuantificación moderna del riesgo de impago (*credit default*).
