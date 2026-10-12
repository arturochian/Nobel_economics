# Soluciones y Pautas de Evaluación (Docente)
## Laureados 2026: Robert E. Hall y Michael Woodford

> **Nota confidencial para el profesor:** Este material contiene las soluciones conceptuales y numéricas a los ejercicios propuestos en `estudiante/ejercicios.qmd`. No incluir en la compilación web para estudiantes.

---

### Solución Ejercicio 1 (Principio de Taylor)
- **Mecanismo:** Si $\phi_\pi \le 1.0$, ante un shock de demanda que eleva la inflación esperada $\mathbb{E}_t[\pi_{t+1}]$, el banco central sube la tasa nominal $i_t$ en una cuantía menor o igual a la inflación esperada.
- **Resultado:** La tasa de interés real esperada $r_t = i_t - \mathbb{E}_t[\pi_{t+1}]$ cae en lugar de subir. Esto estimula aún más el consumo intertemporal de los hogares (ecuación de Euler / IS dinámica de Hall y Woodford), alimentando un espiral expansivo desanclado (indeterminación o divergencia). Por ello, $\phi_\pi > 1$ es condición necesaria de equilibrio determinista único.

### Solución Ejercicio 2 (Inercia de Tasas $\rho_i$)
- **Mecanismo:** Con $\rho_i = 0$, el shock monetario actúa como un pico aislado que se desvanece inmediatamente al periodo siguiente. Los hogares descuentan que la tasa alta es estrictamente transitoria.
- **Con $\rho_i = 0.85$ (Woodford, 1999, 2003):** La tasa se mantiene persistentemente alta en los trimestres futuros. Debido a que las tasas de interés de largo plazo y el consumo intertemporal responden al valor presente descontado de toda la senda futura de tasas, una política inercial y predecible tiene un impacto estabilizador más potente sin requerir saltos extremos y desestabilizadores en la tasa de intervención a corto plazo.

### Solución Ejercicio 3 (Rigidez de Precios $\kappa$)
- Con $\kappa$ pequeño (alta rigidez nominal), los precios se ajustan lentamente, por lo que la política monetaria tiene un fuerte impacto sobre variables reales (brecha de producto y empleo). A medida que $\kappa \to \infty$ (precios perfectamente flexibles), la dicotomía clásica reaparece y el dinero se vuelve neutral sobre el producto real.
