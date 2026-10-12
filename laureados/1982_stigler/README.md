# Nobel de Economía 1982: George J. Stigler

> **Motivación oficial:** *"for his seminal studies of industrial structures, markets and the causes and effects of public regulation"* (Por sus estudios seminales de las estructuras industriales, el funcionamiento de los mercados y las causas y efectos de la regulación pública).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 20 de octubre de 1982.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Catálogo BibTeX con las obras cumbre de George J. Stigler (1958–1983) y los documentos oficiales del Comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Control de publicaciones, identificadores DOI, enlaces verificados y estado de licencias de acceso.
  - [pdf/](referencias/pdf/): Directorio reservado para documentos de libre acceso y reportes oficiales del Comité Nobel.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Reporte reproducible en Quarto con el desarrollo teórico y formal del modelo de búsqueda de información de Stigler (1961), la regla de parada óptima y la teoría de la captura regulatoria de la Escuela de Chicago (1971).
  - [R/economia_informacion_y_regulacion.R](replicacion/R/economia_informacion_y_regulacion.R): Script autónomo en R que simula y grafica el equilibrio de búsqueda óptima bajo dispersión de precios (analítica y Monte Carlo) y el impacto sobre el bienestar social de la captura regulatoria mediante licencias y restricciones a la entrada.
  - [salidas/](replicacion/salidas/): Figuras en alta resolución ([fig_stigler_busqueda_precios.png](replicacion/salidas/fig_stigler_busqueda_precios.png), [fig_stigler_captura_regulatoria.png](replicacion/salidas/fig_stigler_captura_regulatoria.png)) y tabla de resultados numéricos ([tab_resultados_stigler.csv](replicacion/salidas/tab_resultados_stigler.csv)).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con 3 problemas analíticos y aplicados (básico sobre la regla de parada óptima de búsqueda de Stigler; intermedio sobre captura regulatoria, licencias de entrada y disipación de rentas; avanzado/reto en R sobre la técnica del superviviente y economías de escala).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes completas, derivaciones matemáticas paso a paso, código R reproducible para el ejercicio de supervivencia industrial y rúbrica analítica de evaluación.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha divulgativa estructurada con front-matter YAML para su integración directa en el portal web del proyecto.

---

## Resumen Ejecutivo del Aporte

George Joseph Stigler (1911–1991), figura señera de la **Escuela de Chicago**, revolucionó la microeconomía aplicada, la organización industrial y el análisis económico del derecho mediante tres innovaciones fundamentales:

1. **La Economía de la Información (*The Economics of Information*, 1961):** Antes de Stigler, la teoría económica asumía que los agentes disponían de información perfecta y sin costo, tratando la dispersión de precios en el mercado como una mera anomalía temporal. Stigler demostró que **la dispersión de precios es la medida de la ignorancia en el mercado** y que la información es un bien escaso que cuesta tiempo y dinero obtener. Formuló el primer modelo cuantitativo de búsqueda racional: el comprador recoge cotizaciones hasta que el beneficio marginal esperado (el ahorro en el precio mínimo) iguala el costo marginal de una búsqueda adicional ($MB(n^*) = c$). Mostró que los compradores de mayor volumen adquieren más información y que la publicidad, lejos de ser mero despilfarro, es un poderoso instrumento economizador de costos de búsqueda.
2. **La Teoría de la Captura Regulatoria (*The Theory of Economic Regulation*, 1971):** Demolió la ingenua "teoría del interés público" (heredada de Pigou), que asumía que los gobiernos regulan los mercados para proteger a los consumidores de monopolios y fallas de mercado. Stigler demostró que **la regulación es un bien económico demandado por las propias industrias reguladas**: las empresas consolidadas adquieren del poder político barreras legales a la entrada (licencias, cupos, aranceles, tarifas mínimas oficiales) para cartelizar el sector, restringir rivales y extraer rentas monopólicas a expensas de consumidores desorganizados.
3. **El Principio del Superviviente (*The Survivor Principle*, 1958) y Economías de Escala:** Rechazó las estimaciones contables e ingenieriles tradicionales de las curvas de costos en forma de U. Argumentó que si una escala de planta o técnica de producción es eficiente en el mundo real (considerando incertidumbre, relaciones laborales y regulación), **sobrevivirá y aumentará su cuota de mercado en la competencia de mercado a lo largo del tiempo**. Las escalas ineficientes decrecerán o quebrarán.
4. **Evaluación Empírica de la Regulación (*What Can Regulators Regulate?*, 1962 con Claire Friedland):** En el primer estudio econométrico moderno sobre comisiones reguladoras de electricidad en EE.UU., Stigler y Friedland demostraron que los estados con regulación tarifaria no presentaban tarifas eléctricas más bajas ni menores tasas de beneficio que los estados no regulados: la burocracia estatal era incapaz de disciplinar los monopolios naturales mejor que las presiones competitivas sustitutas.
5. **Teoría del Oligopolio y Colusión (*A Theory of Oligopoly*, 1964):** Reformuló la teoría de carteles estableciendo que el desafío de un acuerdo colusorio no es pactar precios, sino **detectar a los miembros que hacen trampa y bajan precios en secreto**. La estabilidad del cártel depende de la probabilidad de detección mediante el monitoreo de cuotas de mercado.

---

## Instrucciones de Reproducción

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde la raíz del proyecto:

```bash
# Ejecutar script R
Rscript laureados/1982_stigler/replicacion/R/economia_informacion_y_regulacion.R
```

Para renderizar el informe completo en Quarto:

```bash
# Renderizar reporte en Quarto
quarto render laureados/1982_stigler/replicacion/replicar.qmd
```
