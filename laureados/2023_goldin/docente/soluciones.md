# Soluciones y Pautas de Evaluación (Docente)
## Laureada 2023: Claudia Goldin

> **Nota confidencial para el profesor:** Este material contiene las soluciones conceptuales, analíticas y de código a los ejercicios propuestos en `estudiante/ejercicios.qmd`. Mantener en uso exclusivo del equipo docente; no publicar en repositorios de libre acceso para estudiantes.

---

### Solución Ejercicio 1: Efecto Ingreso vs. Efecto Sustitución en la Curva en U

1. **Predominio del Efecto Ingreso:**
   - La condición de optimalidad del hogar iguala la tasa marginal de sustitución al salario de mercado: $\frac{\theta C}{L_m} = W_m$.
   - Cuando los salarios masculinos ($W_h$) se incrementan sustancialmente por la industrialización urbana y la mujer no tiene salarios atractivos ni ocupaciones compatibles con el hogar ($W_m$ bajo en fábricas ruidosas y peligrosas), el ingreso no laboral de la mujer ($W_h H_h$) aumenta fuertemente.
   - Si el ocio/tiempo en el hogar es un bien normal ($\theta > 0$), el **efecto ingreso** domina rotundamente: la familia prefiere comprar "estatus social" y bienestar doméstico retirando a la mujer casada del mercado fabril. Esto explica la caída de la participación femenina casada hasta mínimos de ~10% a finales del siglo XIX.

2. **Impacto de las Barreras Matrimoniales (*Marriage Bars*):**
   - Las *marriage bars* introdujeron una restricción de esquina institucional no lineal: prohibición absoluta de trabajar si se estaba casada.
   - Esto truncó la oferta laboral femenina a cero para un amplio segmento educado (maestras de escuela, telefonistas, oficinistas bancarias) sin importar el nivel del salario $W_m$. La elasticidad salario de la oferta se volvió inelástica o discontinua en el margen del matrimonio, obligando a las mujeres a una elección excluyente entre carrera o familia.

3. **Giro del Siglo XX (Auge del Terciario y Educación):**
   - La invención de electrodomésticos redujo el tiempo requerido para el trabajo doméstico, abaratando el costo de oportunidad.
   - El surgimiento de puestos administrativos, secretariales y comerciales con mejores condiciones laborales elevó el salario neto percibido $W_m$, haciendo que el **efecto sustitución** (el costo de oportunidad de quedarse en casa) superara al efecto ingreso, impulsando la porción ascendente de la curva en U.

---

### Solución Ejercicio 2: La Píldora Anticonceptiva y el Retraso del Matrimonio

1. **Horizonte Temporal e Inversión en Carreras Largas:**
   - Carreras profesionales como Medicina (MD) o Derecho (JD) requieren entre 3 y 7 años de educación de posgrado con altos costos fijos y jornadas intensivas previas al inicio del ejercicio profesional.
   - La píldora otorgó a las mujeres un método anticonceptivo de eficacia cercana al 99%, disociado del acto sexual y controlado exclusivamente por ellas. Esto redujo el riesgo de interrupción involuntaria de los estudios por embarazo, garantizando el retorno esperado a la inversión en capital humano de alta cualificación.

2. **Externalidad Positiva en el Mercado Matrimonial (*Thick Market Effect*):**
   - Goldin y Katz (2002) modelan el mercado matrimonial como un juego de emparejamiento con fricciones de búsqueda. Si una cohorte se casa temprano (edad 21–22), la mujer que decide retrasar el matrimonio para estudiar corre el riesgo de quedarse sin parejas afines (*thin market* o mercado estrecho a los 26–28 años).
   - Cuando la píldora se generalizó para mujeres jóvenes y solteras (a través de leyes estatales que rebajaron la mayoría de edad o autorizaron la prescripción a menores emancipadas), **todas las mujeres retrasaron colectivamente el matrimonio**. Esto mantuvo el mercado matrimonial abierto y denso (*thick market*) en edades más avanzadas (25–30 años), eliminando la penalización social por esperar.

3. **Hechos Empíricos (1970–1985):**
   - Entre 1970 y 1985, la participación femenina en las admisiones a facultades de Derecho en EE. UU. saltó de menos del 5% a más del 40%; en escuelas de Medicina pasó de ~8% a más del 35%. La edad media del primer matrimonio para mujeres con título universitario aumentó de 22.5 años en 1965 a más de 25.5 años a mediados de los 80.

---

### Solución Ejercicio 3: Reto de Simulación en R: Empleos Codiciosos y Flexibilidad

1. **Modificación del Parámetro en R:**
   - En el bloque de mujeres en *greedy jobs*:
     ```r
     # Escenario contrafactual con regulación / límites de horas:
     # Caída inmediata al nacer el hijo se reduce a 12% (en vez de 28%): factor 0.88
     # Crecimiento salarial posterior aumenta de 3.8% a 6.0% anual
     ingresos_greedy_m_reforma <- sapply(anios_evento, function(t) {
       if (t < 0) {
         100 * (1 + 0.078 * (t + 4)) * 0.97
       } else {
         base_t0 <- 100 * (1 + 0.080 * 4) * 0.97 * 0.88 # ~112.6
         base_t0 * (1 + 0.060 * t)
       }
     })
     ```

2. **Cálculo Numérico a los 10 Años ($t = 10$):**
   - En el escenario base sin reforma:
     - Ingreso Hombres ($t = 10$): $212.0$.
     - Ingreso Mujeres ($t = 10$): $127.2$.
     - Brecha base: $(1 - 127.2 / 212.0) \times 100 = 40.0\%$.
   - En el escenario con reforma:
     - Ingreso Mujeres reformado ($t = 10$): $112.6 \times (1 + 0.060 \times 10) = 112.6 \times 1.60 = 180.2$.
     - Brecha con reforma: $(1 - 180.2 / 212.0) \times 100 = (1 - 0.850) \times 100 = 15.0\%$.
   - **Resultado:** La brecha salarial a 10 años cae del **40.0% al 15.0%**, lo que representa una reducción masiva de **25 puntos porcentuales**.

3. **Discusión Económica Central de Claudia Goldin:**
   - Las leyes tradicionales de "igual salario por igual trabajo" (*Equal Pay Act*) son ineficaces cuando la disparidad no proviene de pagar distinto por la misma hora en la misma oficina, sino de remunerar desproporcionadamente las horas marginales 50 a 80 de la semana frente a las horas 1 a 40.
   - En los *greedy jobs*, una persona disponible las 24 horas vale más que dos personas trabajando 12 horas si la información entre ellas es imperfecta y los clientes demandan atención del mismo socio.
   - La verdadera solución estriba en la reorganización tecnológica y organizativa del trabajo: estandarización de procesos, historias clínicas/legales compartidas y equipos multidisciplinarios donde un profesional pueda sustituir perfectamente a otro sin merma de calidad para el cliente, tal como ocurrió en el sector de la farmacia en EE. UU. (Goldin y Katz, 2016).
