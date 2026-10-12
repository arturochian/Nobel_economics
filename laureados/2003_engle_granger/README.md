# Nobel de Economía 2003: Robert F. Engle III y Clive W. J. Granger

> **Motivación oficial:** *"for methods of analyzing economic time series with time-varying volatility (ARCH)"* (Robert F. Engle III) y *"for methods of analyzing economic time series with common trends (cointegration)"* (Clive W. J. Granger).  
> **Anuncio oficial:** Real Academia Sueca de Ciencias, 8 de octubre de 2003.

---

## Contenido de la Carpeta

- [referencias/](referencias/):
  - [referencias.bib](referencias/referencias.bib): Entradas BibTeX verificadas de las obras seminales de Engle y Granger y los documentos oficiales del comité Nobel.
  - [manifest.csv](referencias/manifest.csv): Inventario de fuentes, identificadores DOI, enlaces y estado de licencias de acceso abierto.
  - [pdf/](referencias/pdf/): Directorio preparado para albergar documentos y reportes oficiales de acceso público.
- [replicacion/](replicacion/):
  - [replicar.qmd](replicacion/replicar.qmd): Documento Quarto reproducible con desarrollo analítico, simulaciones de procesos ARCH/GARCH y cointegración en dos pasos con VECM.
  - [R/econometria_arch_cointegracion.R](replicacion/R/econometria_arch_cointegracion.R): Script principal en R que simula y estima procesos GARCH(1,1), demuestra la regresión espuria de Granger-Newbold y estima la cointegración bipaso con corrección de error.
  - [salidas/](replicacion/salidas/): Gráficos en alta resolución (`fig_arch_volatilidad_clustering.png`, `fig_cointegracion_vs_espuria.png`, con alias compatibles) y tabla de resultados econométricos (`tab_resultados_series_tiempo.csv`).
- [estudiante/](estudiante/):
  - [ejercicios.qmd](estudiante/ejercicios.qmd): Guía pedagógica con ejercicios graduados (básico sobre volatilidad condicional y VaR, intermedio sobre regresión espuria y prueba de Engle-Granger, avanzado/reto sobre dinámica VECM y pairs trading).
- [docente/](docente/):
  - [soluciones.md](docente/soluciones.md): Pautas docentes confidenciales con derivaciones matemáticas completas y respuestas numéricas detalladas.
- [web/](web/):
  - [ficha.md](web/ficha.md): Ficha canónica con metadatos YAML para la web estática del proyecto Nobel_economics.

---

## Resumen Ejecutivo del Aporte

Robert F. Engle III y Clive W. J. Granger transformaron la econometría de series temporales al proporcionar soluciones matemáticas a dos de las limitaciones más severas de los datos económicos y financieros:

1. **Robert F. Engle (1982) — Heterocedasticidad Condicional Autorregresiva (ARCH):**
   - Demostró que en los mercados financieros la varianza de los retornos no es estática ni constante en el tiempo, sino que experimenta acumulación o agrupamiento de volatilidad (*volatility clustering*).
   - Desarrolló los modelos ARCH y sentó las bases para los modelos GARCH (Bollerslev, 1986), permitiendo a bancos centrales, gestores de fondos e instituciones reguladoras cuantificar el riesgo de mercado en tiempo real, calcular el Valor en Riesgo (VaR) y valorar derivados financieros con volatilidad dinámica.

2. **Clive W. J. Granger (1974, 1987) — Regresión Espuria, Cointegración y Modelos VECM:**
   - Descubrió junto a Paul Newbold (1974) el peligro de la **regresión espuria**: al relacionar variables no estacionarias $I(1)$ que evolucionan como paseos aleatorios independientes, las regresiones de Mínimos Cuadrados Ordinarios exhiben coeficientes $R^2$ artificialmente inflados y estadísticos $t$ falsamente significativos ($DW < R^2$).
   - Desarrolló junto a Robert Engle (1987) el concepto de **Cointegración**: dos o más series no estacionarias que comparten una tendencia estocástica común pueden tener una combinación lineal estacionaria $I(0)$, capturando un genuino equilibrio económico de largo plazo.
   - Demostró el **Teorema de Representación de Granger**, probando que cualquier sistema cointegrado tiene una representación equivalente como Modelo de Corrección de Error (VECM), separando con rigor la dinámica de ajuste de corto plazo de las fuerzas estructurales de largo plazo.

---

## Cómo Ejecutar la Replicación

Para ejecutar el script de replicación y regenerar todas las figuras y tablas desde una terminal PowerShell:

```powershell
Rscript laureados/2003_engle_granger/replicacion/R/econometria_arch_cointegracion.R
```

O desde la consola interactiva de R:

```r
source("laureados/2003_engle_granger/replicacion/R/econometria_arch_cointegracion.R")
```
