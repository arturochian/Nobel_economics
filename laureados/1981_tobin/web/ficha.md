---
anio: 1981
slug: 1981_tobin
laureados: ["James Tobin"]
motivacion_oficial: "for his analysis of financial markets and their relations to expenditure decisions, employment, production and prices [por su análisis de los mercados financieros y sus relaciones con las decisiones de gasto, empleo, producción y precios]"
area: ["Macroeconomía", "Economía Financiera", "Econometría"]
tags: ["q de Tobin", "inversión empresarial", "teorema de separación", "preferencia por liquidez", "modelo Tobit", "tasa Tobin", "equilibrio general financiero"]
referencias_clave: ["tobin1958liquidity", "tobin1958tobit", "tobin1969general", "brainard1968pitfalls", "tobin1978tax", "tobin1982lecture", "hayashi1982tobin"]
replicacion: "laureados/1981_tobin/replicacion/replicar.qmd"
nivel_replicacion: "completa"
---

## En una frase
James Tobin tendió un puente analítico riguroso entre las finanzas y la economía real al demostrar que la inversión física responde al valor de mercado del capital frente a su costo de reposición (la $q$ de Tobin) y que los inversores separan racionalmente la selección de activos de riesgo de su preferencia por liquidez.

## Resumen de la investigación
James Tobin (1918–2002), catedrático de la Universidad de Yale y asesor económico de la administración Kennedy, revolucionó la macroeconomía poskeynesiana mediante cuatro contribuciones fundamentales:

1. **La q de Tobin y la Inversión Empresarial (1969):** Demostró que la inversión física en fábricas, maquinarias e instalaciones no responde simplemente a una tasa de interés aislada, sino a la ratio entre el valor bursátil del capital instalado y su costo de reposición física en la economía real ($q = V / p_K K$). Cuando $q > 1$, las empresas encuentran más rentable crear nuevo capital físico que comprar activos existentes, estimulando la formación bruta de capital y el empleo agregado.
2. **El Teorema de Separación de Cartera y la Preferencia por Liquidez (1958):** Despojó a la teoría keynesiana de la demanda de dinero de supuestos psicológicos rígidos, demostrando que los agentes racionales diversifican entre liquidez y activos de riesgo para optimizar la relación media-varianza. Su **Teorema de Separación de Dos Fondos** demostró que la cartera óptima de activos riesgosos es la misma para todos los inversores; la tolerancia individual al riesgo solo determina qué proporción se guarda en dinero líquido seguro. Este resultado fue la base inmediata sobre la que William Sharpe erigió el modelo CAPM (*Capital Asset Pricing Model*).
3. **El Modelo Tobit para Variables Censuradas (1958):** Desarrolló el método econométrico pionero de máxima verosimilitud para corregir el sesgo sistemático en regresiones con datos acotados en cero (como la compra de bienes duraderos o las donaciones), cimiento esencial de la microeconometría empírica moderna.
4. **La Tasa Tobin (1978):** Propuso un gravamen internacional uniforme sobre las transacciones de divisas de corto plazo para "echar arena en los engranajes de las finanzas internacionales" y amortiguar la especulación cambiaria sin entorpecer el comercio real.

---

## Metodología y resultados

### 1. La Microeconomía de la q de Tobin y los Costos de Ajuste
En el marco de equilibrio general financiero formulado por Tobin (1969) y formalizado analíticamente con costos de ajuste convexos por Fumio Hayashi (1982), la empresa maximiza el valor presente descontado de sus flujos de efectivo:

$$\max_{\{I_t\}} V_0 = \int_0^\infty e^{-r t} \left[ \Pi(K_t) - I_t - \frac{\chi}{2}\left(\frac{I_t}{K_t} - \delta\right)^2 K_t \right] dt$$

sujeto a la acumulación de capital $\dot{K}_t = I_t - \delta K_t$. La condición de primer orden de este problema de control óptimo establece:

$$\frac{I_t}{K_t} = \delta + \frac{1}{\chi}(q_t - 1)$$

donde $q_t$ es el precio sombra de una unidad adicional de capital instalado. 
- Si $q = 1$, la inversión se limita a la reposición por depreciación ($I/K = \delta$).
- Si $q > 1$, la empresa genera valor emitiendo acciones o deuda para comprar maquinaria nueva, acelerando la formación neta de capital a un ritmo moderado por el coeficiente de costo de ajuste $\chi$.
- Gracias al **Teorema de Hayashi (1982)**, bajo rendimientos constantes a escala y competencia en mercados de factores, la $q$ marginal coincide con la $q$ media observada en las bolsas de valores.

### 2. El Teorema de Separación de Dos Fondos (*Two-Fund Separation*)
Al considerar un activo libre de riesgo (dinero / bonos de gobierno de corto plazo con retorno $R_f$) y una cesta de $N$ activos de riesgo con matriz de covarianzas $\boldsymbol{\Sigma}$ y retornos esperados $\boldsymbol{\mu}$, la cartera tangente $\mathbf{w}_T$ que maximiza el ratio de Sharpe viene dada por:

$$\mathbf{w}_T = \frac{\boldsymbol{\Sigma}^{-1}(\boldsymbol{\mu} - R_f \mathbf{1})}{\mathbf{1}^\top \boldsymbol{\Sigma}^{-1}(\boldsymbol{\mu} - R_f \mathbf{1})}$$

La decisión de inversión se separa en dos problemas independientes:
1. **Fase Técnica:** El mercado determina unívocamente la cartera tangente $T$, idéntica para todos los agentes racionales.
2. **Fase Subjetiva:** Cada inversor, según su parámetro de aversión al riesgo $\gamma$, asigna una fracción $x^* = \frac{\mu_T - R_f}{\gamma \sigma_T^2}$ a la cartera riesgosa y retiene $(1 - x^*)$ en dinero líquido, trazando la Línea de Asignación de Capital (CAL):

$$\mu_c = R_f + \left(\frac{\mu_T - R_f}{\sigma_T}\right) \sigma_c$$

---

## Antes y después

### Antes
- **Inversión atada exclusivamente al costo del crédito:** La macroeconomía tradicional (síntesis neoclásica y modelo IS-LM) asumía que la inversión dependía mecánicamente de una única tasa de interés bancaria pasiva o de bonos del Estado ($I = I(r)$), ignorando el papel del mercado bursátil y el valor de reposición de las empresas.
- **Demanda especulativa de dinero basada en creencias rígidas:** Keynes explicaba la preferencia por liquidez suponiendo que los individuos tenían una expectativa fija sobre la tasa de interés normal, prediciendo decisiones absurdas de "todo o nada" (o $100\%$ en bonos o $100\%$ en dinero en efectivo).
- **Regresiones lineales con datos acotados distorsionadas:** Las estimaciones econométricas de gasto o empleo ignoraban el amontonamiento de ceros en encuestas familiares, aplicando Mínimos Cuadrados Ordinarios y generando coeficientes severamente sesgados.

### Después
- **Teoría macrofinanciera de la inversión:** La $q$ de Tobin unificó la política monetaria, la valoración bursátil y la formación bruta de capital fijo en un marco riguroso de equilibrio de activos, permitiendo entender por qué los auges bursátiles estimulan la inversión real y cómo la incertidumbre demora la compra de maquinaria.
- **Microfundamentación del riesgo y nacimiento del CAPM:** El Teorema de Separación de Tobin probó que la preferencia por liquidez es el resultado natural de la aversión al riesgo y la diversificación, sentando los cimientos de la moderna teoría de finanzas y la Línea del Mercado de Capitales de William Sharpe.
- **El Modelo Tobit en microeconometría:** Se dotó a la disciplina del primer estimador no lineal de máxima verosimilitud para datos censurados y truncados, estándar analítico indiscutido en la investigación empírica.

---

## Cómo se aplica hoy

1. **Monitoreo de Estabilidad Financiera y Burbujas en Bancos Centrales:**  
   La **Reserva Federal de EE. UU. (Federal Reserve Board)** y el **Banco Central Europeo (BCE)** calculan periódicamente la $q$ de Tobin agregada a través de las Cuentas Financieras (*Financial Accounts of the United States / Flow of Funds Z.1*) para detectar desviaciones entre la capitalización bursátil corporativa y el costo de reposición física de los activos netos, sirviendo como indicador clave de vulnerabilidad macrofinanciera ([Federal Reserve Financial Stability Report, 2024](https://www.federalreserve.gov/data/z1.htm)).
2. **Modelos Macroeconómicos de Política Monetaria (DSGE):**  
   Los bancos centrales más avanzados del mundo, incluidos el BCE (modelo Smets-Wouters) y el Banco de la Reserva Federal de Nueva York, modelan la dinámica del bloque de inversión mediante la ecuación de la $q$ de Tobin con costos convexos de ajuste e irreversibilidad del capital, simulando cómo los tipos de interés de política afectan la formación bruta de capital fijo.
3. **Estrategias de Asignación de Activos y Fondos de Ciclo de Vida (BlackRock y Vanguard):**  
   La industria mundial de gestión patrimonial aplica el Teorema de Separación de Tobin en los fondos de ciclo de vida (*target-date funds*): en lugar de diseñar una cartera riesgosa a medida para cada cliente, replican una única cartera diversificada global (acciones y bonos globales) y modulan la proporción asignada a instrumentos monetarios líquidos o letras del tesoro libres de riesgo según la edad y aversión al riesgo del ahorrador ([Vanguard Target Retirement Funds, 2024](https://investor.vanguard.com/)).
4. **Impuestos sobre Transacciones Financieras (ITF) en la Unión Europea:**  
   La propuesta de la Tasa Tobin de 1978 inspiró directamente las legislaciones de gravamen a las transacciones bursátiles implementadas en **Francia (2012)** y **España (Ley 5/2020 del Impuesto sobre las Transacciones Financieras)**, diseñadas para desincentivar operaciones especulativas intradía de muy alta frecuencia (*high-frequency trading*) sin dañar la inversión corporativa de largo plazo.
5. **Microeconometría de Políticas Públicas con el Modelo Tobit:**  
   Agencias estadísticas internacionales como la **OCDE** y el **Banco Mundial** utilizan rutinariamente regresiones Tobit para modelar gastos familiares en salud, educación o donaciones benéficas, donde una porción considerable de la población registra consumos iguales a cero.

---

## Replicación en R

El paquete de replicación en `laureados/1981_tobin/replicacion/` contiene:
- **`R/q_de_tobin_y_seleccion_cartera.R`:** Script modular ejecutable que calcula de forma analítica y simula numéricamente:
  1. La tasa de inversión empresarial bruta y neta como función de la $q$ de Tobin ante diferentes coeficientes de fricción cuadrática ($\chi \in \{5, 10, 20\}$) y depreciación ($\delta = 8\%$).
  2. La solución matricial de la cartera tangente de Tobin ($\mathbf{w}_T$) con tres clases de activos de riesgo y un activo libre de riesgo ($R_f = 3\%$), maximizando el ratio de Sharpe.
  3. La Línea de Asignación de Capital (CAL) y los equilibrios de optimización para tres perfiles de aversión al riesgo ($\gamma = 18, 9, 5.5$).
- **Salidas generadas:**
  - `salidas/fig_tobin_q_inversion.png`: Curvas teóricas de inversión frente a la ratio $q$, delimitando las zonas de expansión neta ($q > 1$) y desinversión ($q < 1$).
  - `salidas/fig_tobin_separacion_cartera.png`: Diagrama riesgo-retorno con la nube de carteras factibles, frontera eficiente de Markowitz, cartera tangente $T$, recta CAL y curvas de indiferencia.
  - `salidas/tab_resultados_tobin.csv`: Ponderaciones numéricas, retornos esperados, volatilidades y ratios de Sharpe consolidados.
- **Nivel de replicación declarado:** **Completa e Ilustrativa Rigurosa**.

---

## Para profundizar

- **Tobin, J. (1958).** *"Liquidity Preference as Behavior Towards Risk"*, *The Review of Economic Studies*, 25(2), pp. 65–86. DOI: [10.2307/2296205](https://doi.org/10.2307/2296205) (`tobin1958liquidity`).
- **Tobin, J. (1958).** *"Estimation of Relationships for Limited Dependent Variables"*, *Econometrica*, 26(1), pp. 24–36. DOI: [10.2307/1907382](https://doi.org/10.2307/1907382) (`tobin1958tobit`).
- **Tobin, J. (1969).** *"A General Equilibrium Approach to Monetary Theory"*, *Journal of Money, Credit and Banking*, 1(1), pp. 15–29. DOI: [10.2307/1991374](https://doi.org/10.2307/1991374) (`tobin1969general`).
- **Brainard, W. C., & Tobin, J. (1968).** *"Pitfalls in Financial Model Building"*, *The American Economic Review*, 58(2), pp. 99–122. JSTOR: [1831626](https://www.jstor.org/stable/1831626) (`brainard1968pitfalls`).
- **Tobin, J. (1978).** *"A Proposal for International Monetary Reform"*, *Eastern Economic Journal*, 4(3/4), pp. 153–159. JSTOR: [40722214](https://www.jstor.org/stable/40722214) (`tobin1978tax`).
- **Tobin, J. (1982).** *"Money and Finance in the Macroeconomic Process"*, *The American Economic Review*, 72(2), pp. 171–204 (Discurso Nobel). JSTOR: [1802325](https://www.jstor.org/stable/1802325) (`tobin1982lecture`).
- **Hayashi, F. (1982).** *"Tobin's Marginal q and Average q: A Neoclassical Interpretation"*, *Econometrica*, 50(1), pp. 213–224. DOI: [10.2307/1912538](https://doi.org/10.2307/1912538) (`hayashi1982tobin`).
- **The Royal Swedish Academy of Sciences (1981).** *The Sveriges Riksbank Prize in Economic Sciences in Memory of Alfred Nobel 1981: Press Release*. [Nobelprize.org](https://www.nobelprize.org/prizes/economic-sciences/1981/press-release/) (`nobel1981press`).
