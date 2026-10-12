# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2024: Daron Acemoglu, Simon Johnson y James A. Robinson

> **Nota confidencial para el profesor:** Este material contiene las soluciones conceptuales, analíticas y econométricas a los ejercicios propuestos en `estudiante/ejercicios.qmd`. Mantener reservado para evaluación pedagógica.

---

### Solución Ejercicio 1 (Correlación MCO vs. Causalidad)

#### (a) Sesgo de Endogeneidad en MCO
- **Causalidad Reversa:** Los países con mayor nivel de ingreso per cápita poseen mayor base tributaria para financiar tribunales independientes, sistemas catastrales computarizados, policía profesional y órganos reguladores no corruptos. Por ende, la riqueza puede causar mejores instituciones jurídicas tanto o más de lo que las instituciones causan riqueza.
- **Variables Omitidas:** Factores no observados (como el capital social, la cultura cívica, la dotación de recursos naturales o la exposición geográfica a rutas de comercio marítimo) pueden correlacionar positivamente tanto con la calidad institucional como con la productividad global.
- **Conclusión:** El estimador de MCO captura la correlación bruta ($\mathbb{E}[Y|X]$), pero no el efecto causal estructural ($\frac{\partial Y}{\partial X}$). No se puede interpretar $\hat{\beta}_{\text{MCO}} = 0.522$ como el retorno contrafactual garantizado de una reforma institucional unilateral.

#### (b) ¿Por qué $\hat{\beta}_{\text{IV}} > \hat{\beta}_{\text{MCO}}$?
- Intuitivamente, si el sesgo por causalidad reversa es positivo ($\text{Cov}(R_i, u_i) > 0$), se esperaría que $\hat{\beta}_{\text{MCO}}$ estuviera sobreestimado respecto al parámetro causal ($\beta$).
- Sin embargo, la variable de instituciones (`avexpr`) es un proxy subjetivo construido por consultores privados (Political Risk Services) sobre la percepción de riesgo en 1985–1995. Esto genera **error de medición clásico**.
- El error de medición en la variable explicativa induce **sesgo por atenuación** (*attenuation bias*), empujando el estimador MCO hacia cero:
  $$\text{plim} \, \hat{\beta}_{\text{MCO}} = \beta \cdot \frac{\sigma_{R^*}^2}{\sigma_{R^*}^2 + \sigma_e^2} < \beta$$
- Al usar una variable instrumental válida no correlacionada con el error de medición contemporáneo, 2SLS purga la atenuación. El hecho de que $\hat{\beta}_{\text{IV}} = 0.944$ sea casi el doble de $\hat{\beta}_{\text{MCO}} = 0.522$ sugiere que el sesgo por atenuación dominaba empíricamente sobre el sesgo positivo de simultaneidad.

---

### Solución Ejercicio 2 (Supuesto de Exclusión y Canales Alternativos)

#### (a) La Crítica de Sachs (Efecto Directo de la Salud/Geografía)
- Si la presencia endémica de malaria y fiebre amarilla determina la carga de morbilidad y productividad de la fuerza laboral contemporánea de forma directa, entonces $\text{Cov}(\ln M_i, \varepsilon_i) \ne 0$.
- En términos del grafo acíclico dirigido (DAG), existiría un canal abierto no mediado por las instituciones:
  $$\text{Mortalidad Colonial} \longrightarrow \text{Enfermedades Actuales} \longrightarrow \text{PIB pc 1995}$$
- En tal caso, el supuesto de exclusión fallaría y $\hat{\beta}_{\text{IV}}$ atribuiría erróneamente a las instituciones el impacto directo del entorno biológico y sanitario. AJR respondieron a esta crítica controlando por prevalencia moderna de malaria y demostrando que, una vez instrumentadas las instituciones, el coeficiente de malaria directa deja de ser estadísticamente significativo.

#### (b) Capital Humano vs. Mecanismo Institucional
- Si las metrópolis que enfrentaron baja mortalidad construyeron escuelas, hospitales e infraestructura cívica que facilitaron la acumulación de capital humano temprano (Glaeser et al., 2004), esto puede interpretarse de dos formas:
  1. Si las escuelas forman parte de la provisión pública de bienes garantizada por *instituciones inclusivas*, el mecanismo es complementario y ratifica la teoría amplia de AJR.
  2. Si el capital humano opera con independencia de las instituciones de derechos de propiedad (es decir, una dictadura educada que crece rápido), entonces el instrumento captura tanto instituciones como capital humano colonial, obligando a modelar la endogeneidad conjunta de ambos factores.

---

### Solución Ejercicio 3 (Diagnóstico de Relevancia y Control por Latitud)

#### 1. Diagnóstico de Relevancia de Primera Etapa
- En la especificación simple:
  - $\hat{\gamma}_1 = -0.607$ ($t = -4.79$, $p < 0.0001$).
  - Estadístico $F = t^2 = (-4.790)^2 = \mathbf{22.95}$.
- Puesto que $F = 22.95 > 10$, se rechaza con solvencia la hipótesis nula de instrumento débil según la regla empírica de Stock y Yogo (2005) para un sesgo relativo máximo de 2SLS inferior al 10%.
- Si $F < 10$, los errores estándar convencionales de 2SLS estarían severamente subestimados y las pruebas de hipótesis no tendrían tamaño controlado (requiriendo inferencia robusta como la prueba de Anderson-Rubin).

#### 2. Prueba con Control por Latitud (`lat_abst`)
- **Resultados estimados con latitud:**
  - $\hat{\beta}_{\text{IV, lat}} = 0.996$ ($e.e. = 0.222$, $t = 4.49$, $p < 0.0001$).
  - Coeficiente de latitud: $-0.65$ ($p = 0.42$, no significativo).
  - Estadístico $F$ de primera etapa sobre el instrumento excluido: $F \approx 12.82$.
- **Conclusión pedagógica:** A pesar de controlar explícitamente por la distancia al ecuador (proxy canónica de clima tropical y ecología), el coeficiente institucional se mantiene prácticamente idéntico ($\approx 1.0$) y altamente significativo. Esto demuestra empíricamente que la geografía no condena mecánicamente a las naciones al subdesarrollo: su principal canal de influencia histórica operó a través de las instituciones coloniales que contribuyó a forjar.
