# Pautas Docentes y Solucionario: Nobel de Economía 1990
## Harry M. Markowitz, Merton H. Miller y William F. Sharpe

> **Premio Nobel de Economía 1990:** *"for their pioneering work in the theory of financial economics"*.  
> **Área temática:** Economía Financiera Cuantitativa, Teoría de Selección de Cartera, CAPM y Finanzas Corporativas.  
> **Público objetivo:** Cursos universitarios de pregrado avanzado y posgrado en Finanzas Cuantitativas, Economía Financiera, Gestión de Activos y Valoración Corporativa.

---

## 1. Orientación Pedagógica para el Docente

El Premio Nobel de 1990 representa el nacimiento formal de las finanzas científicas modernas. Antes de estos tres aportes, el mundo financiero operaba con anécdotas, contabilidad empírica y recomendaciones ad-hoc. El objetivo docente es conectar los tres aportes en una secuencia pedagógica coherente:

1. **Markowitz (Nivel Micro / Normativo del Inversor):** 
   - El estudiante debe comprender que el riesgo de un activo no es intrínseco, sino contextual. Un activo muy volátil puede reducir el riesgo global si covaría negativamente con el resto de la cartera.
   - El gran descubrimiento es que el riesgo idiosincrático se diversifica a costo cero.
2. **Sharpe (Nivel Macro / Equilibrio Positivo del Mercado):**
   - Si todos los inversores aplican Markowitz y coinciden en expectativas, todos escogerán la misma cartera riesgosa óptima: la cartera de mercado.
   - Como el riesgo idiosincrático puede eliminarse gratis, **el mercado no paga prima alguna por soportarlo**. La única fuente de rentabilidad esperada por encima de la tasa libre de riesgo es el riesgo sistemático no diversificable ($\beta$).
3. **Miller (Nivel Corporativo / Arbitraje de Finanzas de la Empresa):**
   - Los directores financieros no pueden engañar al mercado reorganizando títulos de deuda y acciones. La ley de un solo precio y el arbitraje de los inversores individuales ("apalancamiento casero") desmantelan la ilusión de que el endeudamiento crea valor de la nada.
   - Introduce la noción crítica de que el valor emana de los activos reales y las decisiones operativas, no de las técnicas de ingeniería financiera contable.

---

## 2. Solucionario Detallado de la Guía de Ejercicios

### Ejercicio 1: Diversificación de Markowitz en Cartera de Dos Activos (Nivel Básico)

**Datos:**  
- $\mathbb{E}[R_A] = 0.12$, $\sigma_A = 0.20$ ($\sigma_A^2 = 0.04$).  
- $\mathbb{E}[R_B] = 0.06$, $\sigma_B = 0.10$ ($\sigma_B^2 = 0.01$).

#### Pregunta 1: Expresiones Analíticas
Retorno esperado:
$$\mathbb{E}[R_p] = w \mathbb{E}[R_A] + (1 - w)\mathbb{E}[R_B] = 0.12 w + 0.06(1 - w) = 0.06 + 0.06 w$$

Varianza:
$$\sigma_p^2 = w^2 \sigma_A^2 + (1 - w)^2 \sigma_B^2 + 2 w (1 - w) \rho_{AB} \sigma_A \sigma_B$$
$$\sigma_p^2 = 0.04 w^2 + 0.01(1 - w)^2 + 2 w (1 - w)(0.20)(0.10)\rho_{AB} = 0.04 w^2 + 0.01(1 - w)^2 + 0.04 w (1 - w)\rho_{AB}$$

#### Pregunta 2: Impacto de la Correlación ($w = 0.5$)
Con $w = 0.5$:
$$w^2 \sigma_A^2 = 0.25 \times 0.04 = 0.0100$$
$$(1 - w)^2 \sigma_B^2 = 0.25 \times 0.01 = 0.0025$$
$$2 w (1 - w) \sigma_A \sigma_B = 2 \times 0.25 \times 0.02 = 0.0100$$
$$\sigma_p^2 = 0.0125 + 0.0100 \rho_{AB}$$

- **Caso 1 ($\rho_{AB} = +1.0$):**
  $$\sigma_p^2 = 0.0125 + 0.0100 = 0.0225 \implies \sigma_p = \sqrt{0.0225} = \mathbf{0.1500} \text{ (15.0\%)}$$
  *(Promedio ponderado lineal exacto: $0.5 \times 20\% + 0.5 \times 10\% = 15\%$, sin ganancia por diversificación).*

- **Caso 2 ($\rho_{AB} = 0.0$):**
  $$\sigma_p^2 = 0.0125 + 0 = 0.0125 \implies \sigma_p = \sqrt{0.0125} \approx \mathbf{0.1118} \text{ (11.18\%)}$$
  *(Notable reducción de casi 4 puntos porcentuales de volatilidad manteniendo el mismo retorno esperado del $9\%$).*

- **Caso 3 ($\rho_{AB} = -1.0$):**
  $$\sigma_p^2 = 0.0125 - 0.0100 = 0.0025 \implies \sigma_p = \sqrt{0.0025} = \mathbf{0.0500} \text{ (5.0\%)}$$
  *(La volatilidad se desploma al $5.0\%$, ¡la mitad del riesgo del activo más seguro!).*

**Intuición:** Cuando los activos no marchan al unísono, las pérdidas en un activo quedan compensadas por las ganancias en el otro, cancelando la variabilidad mutua sin penalizar el retorno medio.

#### Pregunta 3: Cartera de Mínima Varianza ($\rho_{AB} = 0.20$)
Covarianza: $\text{Cov}_{AB} = \rho_{AB} \sigma_A \sigma_B = 0.20 \times 0.20 \times 0.10 = 0.004$.

Condición de primer orden:
$$\frac{d\sigma_p^2}{dw} = 2 w \sigma_A^2 - 2 (1 - w)\sigma_B^2 + 2(1 - 2w)\text{Cov}_{AB} = 0$$
$$w^* = \frac{\sigma_B^2 - \text{Cov}_{AB}}{\sigma_A^2 + \sigma_B^2 - 2\text{Cov}_{AB}} = \frac{0.01 - 0.004}{0.04 + 0.01 - 2(0.004)} = \frac{0.006}{0.042} = \frac{1}{7} \approx \mathbf{0.1429} \text{ (14.29\%)}$$

Ponderación en el Activo B: $1 - w^* = 1 - 0.1429 = \mathbf{0.8571} \text{ (85.71\%)}$.

Retorno esperado de la cartera:
$$\mathbb{E}[R_p] = 0.1429(0.12) + 0.8571(0.06) = 0.01715 + 0.05143 = \mathbf{6.86\%}$$

Varianza y desviación estándar:
$$\sigma_p^2 = (0.1429)^2 (0.04) + (0.8571)^2 (0.01) + 2(0.1429)(0.8571)(0.004)$$
$$\sigma_p^2 = 0.000817 + 0.007346 + 0.000980 = 0.009143$$
$$\sigma_p = \sqrt{0.009143} \approx \mathbf{0.0956} \text{ (9.56\%)}$$

**Conclusión pedagógica:** La volatilidad de la cartera combinada ($9.56\%$) es estrictamente menor que la del Activo B ($10.0\%$), a pesar de haber incorporado un activo sustancialmente más riesgoso (Activo A, $20\%$). Este resultado formaliza matemáticamente el teorema de diversificación de Markowitz.

---

### Ejercicio 2: El CAPM, la Línea SML y el Alfa de Jensen (Nivel Intermedio)

**Datos:** $r_f = 4.0\%$, $\mathbb{E}[R_M] = 10.0\%$, $\sigma_M = 15.0\%$.

#### Pregunta 1: Línea SML y Prima de Riesgo
Prima por riesgo de mercado:
$$\mathbb{E}[R_M] - r_f = 10.0\% - 4.0\% = \mathbf{6.0\%}$$

Ecuación SML:
$$\mathbb{E}[R_i] = 4.0\% + \beta_i \times 6.0\%$$

#### Pregunta 2: Retornos Requeridos por el CAPM
- **Fondo Titán ($\beta = 1.40$):**
  $$\mathbb{E}[R_{\text{Titán}}] = 4.0\% + 1.40 \times 6.0\% = 4.0\% + 8.4\% = \mathbf{12.40\%}$$
- **Fondo Centinela ($\beta = 0.60$):**
  $$\mathbb{E}[R_{\text{Centinela}}] = 4.0\% + 0.60 \times 6.0\% = 4.0\% + 3.6\% = \mathbf{7.60\%}$$
- **Fondo Horizonte ($\beta = 1.00$):**
  $$\mathbb{E}[R_{\text{Horizonte}}] = 4.0\% + 1.00 \times 6.0\% = 4.0\% + 6.0\% = \mathbf{10.00\%}$$

#### Pregunta 3: Alfa de Jensen ($\alpha_i = \bar{R}_i - \mathbb{E}[R_i]$)
- **Fondo Titán:** $\alpha = 13.5\% - 12.4\% = \mathbf{+1.10\%}$ ($+110$ pb). Genera valor genuino por encima del riesgo asumido.
- **Fondo Centinela:** $\alpha = 7.8\% - 7.6\% = \mathbf{+0.20\%}$ ($+20$ pb). Supera ligeramente la exigencia de equilibrio.
- **Fondo Horizonte:** $\alpha = 9.5\% - 10.0\% = \mathbf{-0.50\%}$ ($-50$ pb). Destruye valor: rindió menos que el mercado teniendo el mismo riesgo sistemático ($\beta = 1.0$). Probable efecto de comisiones de gestión excesivas.

#### Pregunta 4: Ratio de Sharpe vs. Ratio de Treynor
| Fondo | Retorno $\bar{R}_i$ | $\sigma_i$ | Beta $\beta_i$ | Ratio de Sharpe ($\frac{\bar{R}-r_f}{\sigma}$) | Ratio de Treynor ($\frac{\bar{R}-r_f}{\beta}$) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Titán** | $13.5\%$ | $24\%$ | $1.40$ | $\frac{9.5}{24} = \mathbf{0.396}$ | $\frac{9.5}{1.40} = \mathbf{6.79\%}$ |
| **Centinela** | $7.8\%$ | $11\%$ | $0.60$ | $\frac{3.8}{11} = \mathbf{0.345}$ | $\frac{3.8}{0.60} = \mathbf{6.33\%}$ |
| **Horizonte** | $9.5\%$ | $16\%$ | $1.00$ | $\frac{5.5}{16} = \mathbf{0.344}$ | $\frac{5.5}{1.00} = \mathbf{5.50\%}$ |
| *Mercado M* | $10.0\%$ | $15\%$ | $1.00$ | $\frac{6.0}{15} = \mathbf{0.400}$ | $\frac{6.0}{1.00} = \mathbf{6.00\%}$ |

**Elección de métrica:**
- **Cartera Total / Única:** Debe usarse el **Ratio de Sharpe**, pues considera el riesgo total ($\sigma$). El inversor no está diversificado y sufrirá tanto el riesgo sistemático como el idiosincrático.
- **Sub-cartera / Cartera Agregada:** Debe usarse el **Ratio de Treynor** o el **Alfa de Jensen**, pues el riesgo específico del fondo se diluirá dentro del portafolio global del inversor y solo impactará la contribución al riesgo sistemático ($\beta$).

---

### Ejercicio 3: Teorema de Modigliani-Miller y Apalancamiento Casero (Nivel Reto)

**Datos:** EBIT $= \$12{,}000{,}000$, $r_0 = 12\%$, Acciones $= 1{,}000{,}000$, Deuda nueva $D = \$40{,}000{,}000$ a $r_D = 6\%$.

#### Pregunta 1: Proposición I de MM (Sin Impuestos)
Valor de la empresa no apalancada:
$$V_U = \frac{\text{EBIT}}{r_0} = \frac{\$12{,}000{,}000}{0.12} = \mathbf{\$100{,}000{,}000}$$

Precio por acción inicial:
$$P_0 = \frac{V_U}{N_0} = \frac{\$100{,}000{,}000}{1{,}000{,}000} = \mathbf{\$100.00 \text{ por acción}}$$

Por la Proposición I de MM, el valor total no cambia:
$$V_L = V_U = \mathbf{\$100{,}000{,}000}$$
El valor del capital propio restante es:
$$E = V_L - D = \$100{,}000{,}000 - \$40{,}000{,}000 = \mathbf{\$60{,}000{,}000}$$

Recompra de acciones:
$$\text{Acciones recompradas} = \frac{\$40{,}000{,}000}{\$100.00} = 400{,}000 \text{ acciones}$$
$$\text{Acciones en circulación} = 1{,}000{,}000 - 400{,}000 = \mathbf{600{,}000 \text{ acciones}}$$
Precio por acción: $\frac{\$60{,}000{,}000}{600{,}000} = \mathbf{\$100.00}$. La riqueza de los accionistas se preserva íntegramente.

#### Pregunta 2: Proposición II de MM
Ratio de apalancamiento:
$$\frac{D}{E} = \frac{\$40{,}000{,}000}{\$60{,}000{,}000} = \frac{2}{3} \approx \mathbf{0.6667}$$

Costo del capital propio ($r_E$):
$$r_E = r_0 + (r_0 - r_D)\frac{D}{E} = 0.12 + (0.12 - 0.06)\left(\frac{2}{3}\right) = 0.12 + 0.04 = \mathbf{0.1600} \text{ (16.0\%)}$$

Comprobación del WACC:
$$\text{WACC} = \left(\frac{E}{V}\right) r_E + \left(\frac{D}{V}\right) r_D = \left(\frac{60}{100}\right)(0.16) + \left(\frac{40}{100}\right)(0.06) = 0.096 + 0.024 = \mathbf{0.1200} \text{ (12.0\%)}$$
El WACC se mantiene estrictamente en el $12\%$.

#### Pregunta 3: Apalancamiento Casero (*Homemade Leverage*)
Supongamos que un inversor posee 100 acciones de la empresa desapalancada (valor $\$10,000$).
- En la empresa apalancada, por cada $\$100$ de capital propio hay $\$66.67$ de deuda corporativa.
- El inversor pide un préstamo personal de $\$6,666.67$ al $6\%$ y utiliza su capital total de $\$16,666.67$ para comprar $166.67$ acciones de la firma no apalancada.
- Retorno de las acciones: $166.67 \text{ acciones} \times \frac{\$12{,}000{,}000}{1{,}000{,}000 \text{ acciones}} = 166.67 \times \$12 = \$2{,}000$.
- Interés personal pagado: $\$6,666.67 \times 0.06 = \$400$.
- Flujo neto para el inversor: $\$2{,}000 - \$400 = \$1{,}600$.
- Rentabilidad sobre sus $\$10,000$ propios: $\frac{\$1{,}600}{\$10,000} = \mathbf{16.0\%}$.
- **Conclusión:** El inversor ha sintetizado de forma idéntica el $16\%$ de retorno de la firma apalancada sin costo adicional. Por ende, la política corporativa de endeudamiento es superflua para el inversor.

#### Pregunta 4: Extensión con Impuestos Corporativos ($t_c = 0.30$)
Interés anual deducible: $I = D \times r_D = \$40{,}000{,}000 \times 0.06 = \$2{,}400{,}000$.
Ahorro fiscal anual: $t_c \times I = 0.30 \times \$2{,}400{,}000 = \$720{,}000$.

Valor presente del escudo fiscal (*Tax Shield*):
$$\text{PV}(\text{Tax Shield}) = \frac{t_c r_D D}{r_D} = t_c D = 0.30 \times \$40{,}000{,}000 = \mathbf{\$12{,}000{,}000}$$

Valor total de la firma apalancada:
$$V_L = V_U + t_c D = \$100{,}000{,}000 + \$12{,}000{,}000 = \mathbf{\$112{,}000{,}000}$$

Valor de mercado del patrimonio:
$$E = V_L - D = \$112{,}000{,}000 - \$40{,}000{,}000 = \mathbf{\$72{,}000{,}000}$$

Como el anuncio de la recompra y el escudo fiscal capitaliza de inmediato, el valor de las acciones sube a:
$$P_1 = \frac{V_L}{N_0} = \frac{\$112{,}000{,}000}{1{,}000{,}000} = \mathbf{\$112.00 \text{ por acción}}$$
Número de acciones recompradas con los $\$40\text{M}$ de deuda:
$$N_{\text{recompradas}} = \frac{\$40{,}000{,}000}{\$112.00} \approx 357{,}143 \text{ acciones}$$
Acciones restantes: $1{,}000{,}000 - 357{,}143 = 642{,}857 \text{ acciones}$.
Valor final por acción: $\frac{\$72{,}000{,}000}{642{,}857} = \mathbf{\$112.00}$.
Los accionistas obtienen una ganancia neta de capital de $\$12.00$ por acción gracias al subsidio tributario estatal a la deuda.
