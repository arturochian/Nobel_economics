// scripts/generar_shiny_2000_2025.mjs
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

const apps = {
  "2024_acemoglu_johnson_robinson": {
    title: "2024 · Instituciones coloniales y desarrollo a largo plazo",
    sidebar: `
    sliderInput("mortalidad", "Log mortalidad de colonos europeos", min = 2.0, max = 8.0, value = 4.5, step = 0.2),
    sliderInput("efecto_inst", "Efecto causal de instituciones (beta 2SLS)", min = 0.3, max = 1.5, value = 0.94, step = 0.05),
    checkboxInput("mostrar_ols", "Comparar con sesgo MCO (OLS)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("AJR (2001): la mortalidad de colonos determina las instituciones extractivas o inclusivas, y estas explican el PIB per cápita actual.")`,
    resets: `updateSliderInput(session, "mortalidad", value = 4.5)
    updateSliderInput(session, "efecto_inst", value = 0.94)
    updateCheckboxInput(session, "mostrar_ols", value = TRUE)`,
    serverLogic: `
    datos <- reactive({
      # Simulacion calibrada con los 64 paises de la muestra base AJR (2001)
      set.seed(2024)
      n <- 64
      log_mort <- seq(2.5, 7.8, length.out = n)
      # Primera etapa: avexpr = 9.5 - 0.6 * log_mort + e
      instituciones <- 9.5 - 0.6 * log_mort + rnorm(n, 0, 0.7)
      instituciones <- pmax(3, pmin(10, instituciones))
      # Segunda etapa estructural: logpgp = alpha + beta * instituciones + u
      log_pib <- 4.0 + input$efecto_inst * instituciones + rnorm(n, 0, 0.4)
      
      # Prediccion puntual para el slider
      inst_pred <- 9.5 - 0.6 * input$mortalidad
      pib_pred <- 4.0 + input$efecto_inst * inst_pred
      
      list(log_mort = log_mort, inst = instituciones, pib = log_pib,
           inst_pred = inst_pred, pib_pred = pib_pred)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Primera etapa
      plot(d$log_mort, d$inst, pch = 19, col = "#2980b9",
           xlab = "Log mortalidad de colonos (siglos XVIII-XIX)",
           ylab = "Protección de derechos de propiedad (avexpr)",
           main = "1ra Etapa: Mortalidad -> Instituciones")
      abline(lm(d$inst ~ d$log_mort), col = "#c0392b", lwd = 2)
      points(input$mortalidad, d$inst_pred, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()

      # Panel 2: Ecuacion estructural 2SLS
      plot(d$inst, d$pib, pch = 19, col = "#27ae60",
           xlab = "Calidad institucional (avexpr)",
           ylab = "Log PIB per cápita (1995)",
           main = "2da Etapa: Instituciones -> PIB")
      mod_iv <- lm(d$pib ~ d$inst)
      abline(mod_iv, col = "#8e44ad", lwd = 2.5)
      if (input$mostrar_ols) {
        # OLS sesgado hacia arriba por causalidad inversa
        abline(a = 3.2, b = 0.52, col = "#7f8c8d", lwd = 2, lty = 2)
        legend("topleft", legend = c("Efecto causal 2SLS (IV)", "Sesgo MCO (OLS)"),
               col = c("#8e44ad", "#7f8c8d"), lwd = c(2.5, 2), lty = c(1, 2), bty = "n")
      }
      points(d$inst_pred, d$pib_pred, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Predicción del modelo para el país seleccionado:"),
        tags$p(sprintf("Con log-mortalidad = %.1f, el índice de instituciones esperado es %.2f (de 10), y el PIB per cápita proyectado es de US$ %s.",
                       input$mortalidad, d$inst_pred, format(round(exp(d$pib_pred)), big.mark = ",")))
      )
    })`,
    explanation: `
    <p>La gráfica izquierda muestra la <strong>primera etapa</strong>: donde los colonos enfrentaron alta mortalidad por malaria o fiebre amarilla, establecieron estados extractivos sin proteger derechos de propiedad. La gráfica derecha muestra la <strong>ecuación estructural</strong>: cómo esas instituciones heredadas explican la enorme brecha de riqueza mundial actual.</p>
    <p><strong>Contribución Nobel 2024:</strong> Daron Acemoglu, Simon Johnson y James A. Robinson resolvieron el dilema de causalidad inversa utilizando la mortalidad histórica de colonos como instrumento exógeno de las instituciones modernas.</p>`
  },

  "2023_goldin": {
    title: "2023 · La brecha de género y la curva en U en el desarrollo",
    sidebar: `
    sliderInput("pib_pc", "PIB per cápita (miles de USD constantes)", min = 2, max = 55, value = 25, step = 1),
    sliderInput("penalizacion_maternidad", "Penalización por maternidad en empleos 'codiciosos' (%)", min = 10, max = 60, value = 35, step = 5),
    sliderInput("flexibilidad", "Grado de flexibilidad horaria del mercado", min = 0, max = 1, value = 0.4, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Claudia Goldin: la participación femenina sigue una curva en U a lo largo del desarrollo; la brecha moderna se explica por los 'greedy jobs'.")`,
    resets: `updateSliderInput(session, "pib_pc", value = 25)
    updateSliderInput(session, "penalizacion_maternidad", value = 35)
    updateSliderInput(session, "flexibilidad", value = 0.4)`,
    serverLogic: `
    datos <- reactive({
      # 1. Curva en U historica
      pib_seq <- seq(1.5, 60, length.out = 100)
      flfp_teorica <- 45 - 28 * (log(pib_seq) - log(2)) / (log(12) - log(2)) + 
                      42 * ((log(pib_seq) - log(12)) / (log(60) - log(12)))^2
      flfp_teorica <- pmax(12, pmin(75, flfp_teorica))
      
      # Punto actual
      flfp_actual <- 45 - 28 * (log(input$pib_pc) - log(2)) / (log(12) - log(2)) + 
                     42 * ((log(input$pib_pc) - log(12)) / (log(60) - log(12)))^2
      flfp_actual <- max(12, min(75, flfp_actual))
      
      # 2. Brecha salarial por anios de experiencia tras el primer hijo
      anios <- 0:15
      brecha_base <- (input$penalizacion_maternidad * (1 - input$flexibilidad * 0.8)) * (1 - exp(-0.25 * anios))
      
      list(pib_seq = pib_seq, flfp_teorica = flfp_teorica, flfp_actual = flfp_actual,
           anios = anios, brecha = brecha_base)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Curva en U
      plot(d$pib_seq, d$flfp_teorica, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "PIB per cápita (miles de USD)", ylab = "Participación laboral femenina (%)",
           main = "Curva en U Histórica (Goldin)")
      points(input$pib_pc, d$flfp_actual, pch = 21, bg = "#e74c3c", cex = 2.2, lwd = 2)
      text(d$pib_seq[15], 38, "Fase agrícola", cex = 0.85, col = "#555")
      text(d$pib_seq[35], 16, "Industrialización", cex = 0.85, col = "#555")
      text(d$pib_seq[80], 65, "Sector servicios", cex = 0.85, col = "#555")
      grid()

      # Panel 2: Penalizacion por maternidad en empleos codiciosos
      plot(d$anios, d$brecha, type = "b", pch = 19, col = "#c0392b", lwd = 2.5,
           xlab = "Años tras el nacimiento del primer hijo",
           ylab = "Brecha salarial hombre-mujer (%)",
           ylim = c(0, 60),
           main = "Penalización Salarial de la Maternidad")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diagnóstico del mercado laboral:"),
        tags$p(sprintf("A un nivel de ingreso de US$ %d k, la participación femenina estimada es %.1f%%. La brecha salarial a 10 años del primer hijo se sitúa en %.1f%% debido a la prima por horas largas en empleos no flexibles.",
                       input$pib_pc, d$flfp_actual, d$brecha[11]))
      )
    })`,
    explanation: `
    <p>Claudia Goldin corrigió más de dos siglos de datos para demostrar que la participación femenina no creció en línea recta: en la economía agraria era alta, cayó drásticamente con las fábricas por estigmas sociales, y volvió a subir con las oficinas y la píldora anticonceptiva.</p>
    <p><strong>Contribución Nobel 2023:</strong> Goldin descubrió que la mayor parte de la brecha salarial actual no surge dentro del mismo puesto, sino por la penalización que sufren las mujeres al buscar flexibilidad en empleos 'codiciosos' con retornos desproporcionados a horas continuas.</p>`
  },

  "2022_bernanke_diamond_dybvig": {
    title: "2022 · Bancos, liquidez y corridas bancarias (Diamond-Dybvig)",
    sidebar: `
    sliderInput("t_prop", "Proporción de depositantes impacientes (t)", min = 0.10, max = 0.50, value = 0.25, step = 0.05),
    sliderInput("r1", "Retorno prometido en retiro temprano (r1)", min = 1.05, max = 1.40, value = 1.20, step = 0.05),
    sliderInput("R", "Retorno de proyectos productivos maduros (R)", min = 1.20, max = 2.00, value = 1.50, step = 0.05),
    checkboxInput("seguro_depositos", "Activar seguro de depósitos (FDIC)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Diamond & Dybvig (1983): los bancos transforman plazos pero crean fragilidad intrínseca ante pánicos autorrealizables.")`,
    resets: `updateSliderInput(session, "t_prop", value = 0.25)
    updateSliderInput(session, "r1", value = 1.20)
    updateSliderInput(session, "R", value = 1.50)
    updateCheckboxInput(session, "seguro_depositos", value = FALSE)`,
    serverLogic: `
    datos <- reactive({
      t <- input$t_prop
      r1 <- input$r1
      R <- input$R
      
      # Retorno optimo tarde
      r2_opt <- (R * (1 - t * r1)) / (1 - t)
      # Umbral agotamiento
      f_bar <- 1 / r1
      # Umbral critico de panico f* donde V2(f*) = r1
      f_star <- (R - r1) / (r1 * (R - 1))
      
      f_vec <- seq(0.01, 0.99, length.out = 150)
      
      if (input$seguro_depositos) {
        # Con seguro, no hay incentivo para corrida de pacientes
        V1 <- rep(r1, length(f_vec))
        V2 <- rep(r2_opt, length(f_vec))
      } else {
        V1 <- ifelse(f_vec <= f_bar, r1, 1 / f_vec)
        V2 <- pmax(0, (R * (1 - f_vec * r1)) / (1 - f_vec))
        V2[f_vec > f_bar] <- 0
      }
      
      list(f = f_vec, V1 = V1, V2 = V2, r2_opt = r2_opt, f_star = f_star, f_bar = f_bar)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$f, d$V2, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Fracción de personas que retiran sus fondos (f)",
           ylab = "Retorno recibido por dólar depositado",
           ylim = c(0, max(d$V1, d$V2, 1.8)),
           main = "Dilema del Depositante Paciente: V2(f) vs. V1")
      lines(d$f, d$V1, col = "#e74c3c", lwd = 2.5, lty = 2)
      
      if (!input$seguro_depositos && d$f_star > 0 && d$f_star < 1) {
        abline(v = d$f_star, col = "#d35400", lty = 3, lwd = 2)
        text(d$f_star + 0.03, 0.4, sprintf("Umbral pánico f* = %.2f", d$f_star), col = "#d35400", adj = 0)
      }
      grid()
      legend("topright", legend = c("Esperar a maduración V2(f)", "Retirar temprano V1(f)"),
             col = c("#2980b9", "#e74c3c"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$seguro_depositos) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Seguro de depósitos activado:"),
          " El seguro elimina el equilibrio de pánico. Los pacientes siempre prefieren esperar a T=2 (retorno = ", sprintf("%.2f", d$r2_opt), "), haciendo imposible una corrida bancaria."
        )
      } else {
        tags$div(
          class = "alert alert-warning mt-3",
          tags$strong("Vulnerabilidad bancaria:"),
          sprintf(" Si más del %.1f%% de los depositantes retira prematuramente, el banco liquida inversiones y V2 cae por debajo de V1, detonando un colapso sistémico.", d$f_star * 100)
        )
      }
    })`,
    explanation: `
    <p>El modelo Diamond-Dybvig muestra que la intermediación bancaria ofrece seguros de liquidez a los ahorristas, pero sufre de equilibrios múltiples: el óptimo cooperativo y el pánico bancario donde todos corren a retirar antes de que el banco quiebre.</p>
    <p><strong>Contribución Nobel 2022:</strong> Ben Bernanke analizó el colapso del crédito en la Gran Depresión de 1929, mientras que Douglas Diamond y Philip Dybvig formalizaron matemáticamente por qué las corridas bancarias requieren prestamistas de última instancia y seguro de depósitos.</p>`
  },

  "2021_card_angrist_imbens": {
    title: "2021 · Diferencias en Diferencias y Salario Mínimo (Card & Krueger)",
    sidebar: `
    sliderInput("empleo_pa", "Empleo promedio PA (Estado Control)", min = 15, max = 28, value = 21.2, step = 0.5),
    sliderInput("cambio_macro", "Variación económica general (shock común)", min = -4.0, max = 2.0, value = -2.1, step = 0.2),
    sliderInput("efecto_salario", "Efecto causal del salario mínimo en NJ", min = -4.0, max = 5.0, value = 2.76, step = 0.2),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Card & Krueger (1994): experimento natural evaluando el aumento del salario mínimo de 1992 entre Nueva Jersey y Pensilvania.")`,
    resets: `updateSliderInput(session, "empleo_pa", value = 21.2)
    updateSliderInput(session, "cambio_macro", value = -2.1)
    updateSliderInput(session, "efecto_salario", value = 2.76)`,
    serverLogic: `
    datos <- reactive({
      # Valores antes
      nj_antes <- 20.4
      pa_antes <- input$empleo_pa
      
      # Despues
      pa_despues <- pa_antes + input$cambio_macro
      # Contrafactual de NJ si siguiera tendencia paralela
      nj_contrafactual <- nj_antes + input$cambio_macro
      # Observado NJ
      nj_despues <- nj_contrafactual + input$efecto_salario
      
      did <- (nj_despues - nj_antes) - (pa_despues - pa_antes)
      
      list(nj_antes = nj_antes, nj_despues = nj_despues,
           pa_antes = pa_antes, pa_despues = pa_despues,
           nj_cf = nj_contrafactual, did = did)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      x <- c(1, 2)
      plot(x, c(d$pa_antes, d$pa_despues), type = "b", pch = 19, col = "#7f8c8d", lwd = 2.5,
           xlim = c(0.8, 2.2), ylim = c(14, 27), xaxt = "n",
           xlab = "Momento del tiempo", ylab = "Empleo FTE promedio por restaurante",
           main = "Diseño de Diferencias en Diferencias (DiD)")
      axis(1, at = c(1, 2), labels = c("Antes (Feb 1992)", "Después (Nov 1992)"))
      
      # NJ observado
      lines(x, c(d$nj_antes, d$nj_despues), type = "b", pch = 19, col = "#2980b9", lwd = 3)
      # Contrafactual
      lines(x, c(d$nj_antes, d$nj_cf), type = "l", lty = 2, col = "#e67e22", lwd = 2)
      points(2, d$nj_cf, pch = 1, col = "#e67e22", cex = 1.8, lwd = 2)
      
      # Flecha did
      arrows(2, d$nj_cf, 2, d$nj_despues, col = "#27ae60", lwd = 3, length = 0.12)
      text(2.05, (d$nj_cf + d$nj_despues)/2, sprintf("DiD = %+0.2f FTE", d$did), col = "#27ae60", font = 2, adj = 0)
      
      grid()
      legend("topleft", legend = c("PA (Control - sin cambio)", "NJ (Tratado - sube salario)", "NJ (Contrafactual no observado)"),
             col = c("#7f8c8d", "#2980b9", "#e67e22"), lwd = c(2.5, 3, 2), lty = c(1, 1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estimador de Diferencias en Diferencias:"),
        tags$p(sprintf("Variación en Pensilvania: %+.2f FTE | Variación en Nueva Jersey: %+.2f FTE. El impacto causal estimado del salario mínimo es de %+.2f empleos equivalentes a tiempo completo por establecimiento.",
                       d$pa_despues - d$pa_antes, d$nj_despues - d$nj_antes, d$did))
      )
    })`,
    explanation: `
    <p>El gráfico compara Nueva Jersey (que elevó su salario mínimo de US$ 4.25 a 5.05) con Pensilvania oriental (que lo mantuvo sin cambios). Al restar la tendencia macroeconómica observada en Pensilvania, se obtiene el efecto causal neto sobre el empleo.</p>
    <p><strong>Contribución Nobel 2021:</strong> David Card revolucionó la economía laboral con experimentos naturales, mientras que Joshua Angrist y Guido Imbens crearon el marco metodológico LATE para interpretar la causalidad con instrumentos imperfectos.</p>`
  },

  "2020_milgrom_wilson": {
    title: "2020 · Teoría de Subastas y la Maldición del Ganador",
    sidebar: `
    sliderInput("N", "Número de postores en la subasta (N)", min = 2, max = 30, value = 8, step = 1),
    sliderInput("ruido", "Incertidumbre / dispersión de señales (epsilon)", min = 5, max = 40, value = 20, step = 5),
    checkboxInput("es_racional", "Postor Racional (corrige maldición del ganador)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Wilson (1977) y Milgrom (1982): en bienes con valor común, el postor más optimista gana la subasta pero sobrepaga si no descuenta el sesgo.")`,
    resets: `updateSliderInput(session, "N", value = 8)
    updateSliderInput(session, "ruido", value = 20)
    updateCheckboxInput(session, "es_racional", value = FALSE)`,
    serverLogic: `
    datos <- reactive({
      N <- input$N
      eps <- input$ruido
      V_true <- 150
      
      # Esperanza del maximo de N uniformes: V + eps * (N - 1)/(N + 1)
      E_max_senal <- V_true + eps * (N - 1) / (N + 1)
      
      # Postor ingenuo descuenta como si fuera valor privado
      puja_ingenua <- E_max_senal - (2 * eps) / (N + 1)
      beneficio_ingenuo <- V_true - puja_ingenua
      
      # Postor racional descuenta condicionando en ser el maximo
      puja_racional <- V_true - eps + (2 * eps) / (N + 1) # Sombreado correcto
      beneficio_racional <- eps - (2 * eps) / (N + 1)
      
      # Curva para varios N
      n_vec <- 2:30
      curva_ing <- numeric(length(n_vec))
      curva_rac <- numeric(length(n_vec))
      for (i in seq_along(n_vec)) {
        nn <- n_vec[i]
        max_s <- V_true + eps * (nn - 1) / (nn + 1)
        p_ing <- max_s - (2 * eps) / (nn + 1)
        curva_ing[i] <- V_true - p_ing
        curva_rac[i] <- eps - (2 * eps) / (nn + 1)
      }
      
      list(N = N, beneficio_ing = beneficio_ingenuo, beneficio_rac = beneficio_racional,
           n_vec = n_vec, curva_ing = curva_ing, curva_rac = curva_rac)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$n_vec, d$curva_ing, type = "l", col = "#c0392b", lwd = 2.5,
           ylim = c(min(d$curva_ing) - 5, max(d$curva_rac) + 5),
           xlab = "Número de postores compitiendo (N)",
           ylab = "Beneficio esperado del ganador",
           main = "Maldición del Ganador: Pérdidas por Competencia")
      lines(d$n_vec, d$curva_rac, col = "#27ae60", lwd = 2.5, lty = 2)
      abline(h = 0, lty = 3, col = "#7f8c8d")
      
      # Punto actual
      ben_actual <- if (input$es_racional) d$beneficio_rac else d$beneficio_ing
      col_pt <- if (input$es_racional) "#27ae60" else "#c0392b"
      points(input$N, ben_actual, pch = 21, bg = col_pt, cex = 2.2, lwd = 2)
      
      grid()
      legend("topright", legend = c("Postor Ingenuo (Maldición)", "Postor Racional (Sombreado)"),
             col = c("#c0392b", "#27ae60"), lwd = c(2.5, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$es_racional) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Estrategia racional activada:"),
          sprintf(" Al sombrar la puja tomando en cuenta que ganar significa haber recibido la señal más alta, el postor obtiene un beneficio positivo de +%.2f unidades.", d$beneficio_rac)
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Maldición del ganador en acción:"),
          sprintf(" Con N = %d postores, el ganador ingenuo sufre pérdidas sistemáticas de %.2f unidades debido a que confunde el optimismo de su estimación con el verdadero valor del bien.", input$N, d$beneficio_ing)
        )
      }
    })`,
    explanation: `
    <p>En subastas de espectro radioeléctrico o yacimientos petrolíferos, el valor del recurso es el mismo para todos pero nadie lo conoce con exactitud. Ganar la subasta contiene la mala noticia de haber sido el postor con la estimación más exagerada.</p>
    <p><strong>Contribución Nobel 2020:</strong> Paul Milgrom y Robert Wilson diseñaron nuevos formatos de subastas ascendentes simultáneas (SMRA) que permiten a los participantes aprender del comportamiento ajeno, mitigando la maldición del ganador y recaudando cientos de miles de millones de dólares para el erario público.</p>`
  },

  "2019_banerjee_duflo_kremer": {
    title: "2019 · Ensayos Clínicos Aleatorizados en Desarrollo (RCT)",
    sidebar: `
    sliderInput("cobertura", "Porcentaje de escuelas asignadas a tratamiento (%)", min = 20, max = 80, value = 50, step = 5),
    sliderInput("efecto_directo", "Efecto clínico directo en asistencia escolar (%)", min = 2, max = 15, value = 7.5, step = 0.5),
    sliderInput("externalidad", "Efecto derrame / externalidad comunitaria (%)", min = 0, max = 6, value = 2.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Miguel & Kremer (2004) / Banerjee, Duflo & Kremer: evaluación experimental rigurosa de desparasitación infantil en Kenia.")`,
    resets: `updateSliderInput(session, "cobertura", value = 50)
    updateSliderInput(session, "efecto_directo", value = 7.5)
    updateSliderInput(session, "externalidad", value = 2.0)`,
    serverLogic: `
    datos <- reactive({
      tasa_base <- 72.0
      cob <- input$cobertura / 100
      
      # Asistencia en escuelas control
      asist_control <- tasa_base + input$externalidad * cob
      # Asistencia en escuelas tratadas
      asist_tratadas <- tasa_base + input$efecto_directo + input$externalidad * cob
      
      # Impacto observado simple vs impacto total real
      impacto_obs <- asist_tratadas - asist_control
      impacto_total <- input$efecto_directo + input$externalidad * cob
      
      list(base = tasa_base, control = asist_control, tratadas = asist_tratadas,
           obs = impacto_obs, total = impacto_total)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      vals <- c(d$base, d$control, d$tratadas)
      bp <- barplot(vals, names.arg = c("Sin programa (Base)", "Grupo Control (con derrame)", "Grupo Tratado (Desparasitado)"),
                    col = c("#bdc3c7", "#f39c12", "#27ae60"),
                    ylab = "Asistencia escolar promedio (%)",
                    ylim = c(0, 100),
                    main = "Evaluación Experimental de Desparasitación Escolar")
      text(bp, vals + 3, sprintf("%.1f%%", vals), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultados del RCT:"),
        tags$p(sprintf("La comparación simple Tratado vs Control reporta una ganancia de +%.1f puntos porcentuales. Sin embargo, al existir externalidades epidemiológicas en las escuelas vecinas, el beneficio social total alcanza +%.1f puntos.",
                       d$obs, d$total))
      )
    })`,
    explanation: `
    <p>Los ensayos controlados aleatorizados (RCT) permiten aislar el impacto de intervenciones sociales dividiendo a las comunidades al azar entre beneficiarios y grupos de comparación.</p>
    <p><strong>Contribución Nobel 2019:</strong> Abhijit Banerjee, Esther Duflo y Michael Kremer transformaron la economía del desarrollo al convertir la lucha contra la pobreza en una ciencia experimental basada en intervenciones evaluadas rigurosamente en terreno.</p>`
  },

  "2018_nordhaus_romer": {
    title: "2018 · Economía del Cambio Climático y Crecimiento Endógeno",
    sidebar: `
    sliderInput("tax_co2", "Impuesto al carbono ($/tonelada de CO2)", min = 0, max = 250, value = 40, step = 10),
    sliderInput("subsidio_id", "Subsidio a I+D e innovación verde (%)", min = 0, max = 50, value = 15, step = 5),
    sliderInput("horizonte", "Horizonte de proyección (años)", min = 20, max = 100, value = 60, step = 10),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Nordhaus (Modelo DICE) y Romer (Ideas no rivales): integración del daño climático y la innovación endógena.")`,
    resets: `updateSliderInput(session, "tax_co2", value = 40)
    updateSliderInput(session, "subsidio_id", value = 15)
    updateSliderInput(session, "horizonte", value = 60)`,
    serverLogic: `
    datos <- reactive({
      t_seq <- 0:input$horizonte
      tax <- input$tax_co2
      sub_id <- input$subsidio_id / 100
      
      # Emisiones bajo escenario business as usual vs impuesto
      reduccion_emisiones <- min(0.85, (tax / 300)^0.6 + sub_id * 0.5)
      emisiones_bau <- 36 * (1 + 0.015 * t_seq)
      emisiones_opt <- 36 * (1 + 0.015 * t_seq) * (1 - reduccion_emisiones)
      
      # Calentamiento proyectado
      temp_bau <- 1.1 + 0.028 * t_seq
      temp_opt <- 1.1 + 0.028 * t_seq * (1 - reduccion_emisiones * 0.7)
      
      list(t = t_seq, e_bau = emisiones_bau, e_opt = emisiones_opt,
           t_bau = temp_bau, t_opt = temp_opt, red = reduccion_emisiones)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Emisiones
      plot(d$t, d$e_bau, type = "l", col = "#c0392b", lwd = 2.5, lty = 2,
           xlab = "Años desde el presente", ylab = "Gt CO2 anuales",
           ylim = c(0, max(d$e_bau) * 1.1), main = "Trayectoria de Emisiones")
      lines(d$t, d$e_opt, col = "#27ae60", lwd = 3)
      grid()
      legend("topleft", legend = c("Inacción (BAU)", "Con Política Óptima"),
             col = c("#c0392b", "#27ae60"), lwd = c(2.5, 3), lty = c(2, 1), bty = "n")

      # Temperatura
      plot(d$t, d$t_bau, type = "l", col = "#c0392b", lwd = 2.5, lty = 2,
           xlab = "Años desde el presente", ylab = "Aumento de Temperatura (°C)",
           ylim = c(1.0, 3.5), main = "Temperatura Global Media")
      lines(d$t, d$t_opt, col = "#2980b9", lwd = 3)
      abline(h = 1.5, lty = 3, col = "#e67e22")
      abline(h = 2.0, lty = 3, col = "#d35400")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Balance del Modelo DICE-Romer:"),
        tags$p(sprintf("Un precio al carbono de $%d/t combinado con %.0f%% de subsidio a la tecnología verde abate el %.1f%% de las emisiones contaminantes, limitando el calentamiento global a %.2f °C en el año %d.",
                       input$tax_co2, input$subsidio_id, d$red * 100, tail(d$t_opt, 1), tail(d$t, 1)))
      )
    })`,
    explanation: `
    <p>William Nordhaus construyó el modelo de Evaluación Integrada Clima-Economía (DICE), calculando el costo social del carbono. Paul Romer demostró matemáticamente que las ideas son bienes no rivales que generan rendimientos crecientes y crecimiento ilimitado.</p>
    <p><strong>Contribución Nobel 2018:</strong> Integraron las dos mayores fuerzas globales a largo plazo en el análisis macroeconómico: el agotamiento ambiental y la generación de conocimiento tecnológico.</p>`
  },

  "2017_thaler": {
    title: "2017 · Economía Conductual y Arquitectura de Decisión",
    sidebar: `
    sliderInput("beta", "Sesgo del presente / Impaciencia (beta)", min = 0.5, max = 1.0, value = 0.75, step = 0.05),
    sliderInput("lambda", "Aversión a las pérdidas (lambda)", min = 1.0, max = 3.5, value = 2.25, step = 0.25),
    checkboxInput("usar_nudge", "Aplicar 'Nudge' (Ahorro automático SMarT)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Richard Thaler: los humanos sufren de autocontrol imperfecto, contabilidad mental y aversión asimétrica a las pérdidas.")`,
    resets: `updateSliderInput(session, "beta", value = 0.75)
    updateSliderInput(session, "lambda", value = 2.25)
    updateCheckboxInput(session, "usar_nudge", value = TRUE)`,
    serverLogic: `
    datos <- reactive({
      anios <- 0:10
      # Tasa de ahorro bajo decision tradicional (afiliacion opt-in)
      ahorro_tradicional <- 3.5 * input$beta * (1 + 0.02 * anios)
      
      # Tasa bajo Save More Tomorrow (SMarT): compromiso vinculado a aumentos salariales
      if (input$usar_nudge) {
        ahorro_nudge <- 3.5 + 1.2 * anios
        ahorro_nudge <- pmin(15.0, ahorro_nudge)
      } else {
        ahorro_nudge <- ahorro_tradicional
      }
      
      list(anios = anios, trad = ahorro_tradicional, nudge = ahorro_nudge)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$anios, d$nudge, type = "b", pch = 19, col = "#27ae60", lwd = 3,
           xlab = "Años en el plan de retiro", ylab = "Tasa de ahorro sobre el salario (%)",
           ylim = c(0, 16), main = "Ahorro para la Jubilación: Nudge vs. Opt-In Tradicional")
      lines(d$anios, d$trad, type = "b", pch = 17, col = "#c0392b", lwd = 2.5, lty = 2)
      grid()
      legend("topleft", legend = c("Con Nudge 'Save More Tomorrow'", "Sin Nudge (Tradicional Opt-in)"),
             col = c("#27ae60", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), pch = c(19, 17), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Efecto del Empujón Conductual:"),
        tags$p(sprintf("Con un coeficiente de sesgo presente beta = %.2f y aversión a pérdidas lambda = %.2f, el programa automático de Thaler eleva la tasa de ahorro final del %.1f%% al %.1f%% del ingreso.",
                       input$beta, input$lambda, tail(d$trad, 1), tail(d$nudge, 1)))
      )
    })`,
    explanation: `
    <p>La economía clásica asumía un <em>Homo economicus</em> con autocontrol infinito y racionalidad perfecta. Thaler demostró que las personas postergan decisiones complejas (como ahorrar para la vejez) debido al sesgo del presente.</p>
    <p><strong>Contribución Nobel 2017:</strong> Richard Thaler fundó la economía conductual y diseñó intervenciones institucionales ("nudges") que aumentaron el ahorro de millones de trabajadores preservando su libertad de elección.</p>`
  },

  "2016_hart_holmstrom": {
    title: "2016 · Teoría de Contratos y Compensación de Ejecutivos",
    sidebar: `
    sliderInput("riesgo_agente", "Aversión al riesgo del agente (r)", min = 0.1, max = 2.0, value = 0.8, step = 0.1),
    sliderInput("ruido_var", "Varianza de la señal de desempeño (sigma^2)", min = 0.2, max = 3.0, value = 1.0, step = 0.2),
    sliderInput("costo_esfuerzo", "Costo marginal de esfuerzo (c)", min = 0.5, max = 2.5, value = 1.0, step = 0.2),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Holmström (1979) y Hart (1986): tensión fundamental entre proveer incentivos y asegurar al trabajador contra el riesgo.")`,
    resets: `updateSliderInput(session, "riesgo_agente", value = 0.8)
    updateSliderInput(session, "ruido_var", value = 1.0)
    updateSliderInput(session, "costo_esfuerzo", value = 1.0)`,
    serverLogic: `
    datos <- reactive({
      r <- input$riesgo_agente
      sigma2 <- input$ruido_var
      c <- input$costo_esfuerzo
      
      # Pendiente optima del contrato lineal: beta* = 1 / (1 + r * c * sigma^2)
      beta_opt <- 1 / (1 + r * c * sigma2)
      esfuerzo_opt <- beta_opt / c
      salario_fijo <- 5.0 - (beta_opt * esfuerzo_opt - 0.5 * c * esfuerzo_opt^2 - 0.5 * r * beta_opt^2 * sigma2)
      
      list(beta = beta_opt, esfuerzo = esfuerzo_opt, fijo = salario_fijo)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      desempeno <- seq(0, 10, length.out = 100)
      compensacion <- d$fijo + d$beta * desempeno
      
      plot(desempeno, compensacion, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Resultado observado de la empresa (Ventas / Rendimiento)",
           ylab = "Compensación total del ejecutivo (W)",
           ylim = c(0, 15), main = "Estructura del Contrato Óptimo de Holmström")
      abline(h = d$fijo, lty = 2, col = "#7f8c8d")
      grid()
      legend("topleft", legend = c("Contrato W = alfa + beta * Y", "Salario base fijo (alfa)"),
             col = c("#2980b9", "#7f8c8d"), lwd = c(3, 1.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Propiedades del contrato de incentivos:"),
        tags$p(sprintf("La fuerza óptima del incentivo es beta* = %.2f. Cuanto mayor es el riesgo no controlable (sigma^2 = %.1f) o la aversión al riesgo (r = %.1f), menor debe ser el componente variable para evitar trasladar volatilidad indeseada al trabajador.",
                       d$beta, input$ruido_var, input$riesgo_agente))
      )
    })`,
    explanation: `
    <p>Bengt Holmström formalizó el "Principio de Informatividad": los pagos solo deben vincularse a métricas que revelen esfuerzo no observable, descartando shocks exógenos ajenos al control del agente.</p>
    <p><strong>Contribución Nobel 2016:</strong> Oliver Hart y Bengt Holmström revolucionaron la comprensión de los contratos incompletos, la propiedad de las empresas y los límites entre el empleo asalariado y el mercado.</p>`
  },

  "2015_deaton": {
    title: "2015 · Consumo, Demanda (AIDS) y Medición de Pobreza",
    sidebar: `
    sliderInput("gasto", "Presupuesto total del hogar ($)", min = 200, max = 2500, value = 800, step = 50),
    sliderInput("precio_alim", "Precio relativo de alimentos básicos", min = 0.5, max = 2.0, value = 1.0, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Angus Deaton: el Sistema Casi Ideal de Demanda (AIDS) conecta microdatos de consumo con bienestar agregado.")`,
    resets: `updateSliderInput(session, "gasto", value = 800)
    updateSliderInput(session, "precio_alim", value = 1.0)`,
    serverLogic: `
    datos <- reactive({
      # Sistema AIDS simplificado para 3 bienes: Alimentos (necesidad), Vivienda, Lujos
      # w_i = alpha_i + beta_i * log(X / P)
      X <- input$gasto
      p1 <- input$precio_alim
      log_xp <- log(X / (p1^0.4))
      
      # Alimentos: beta negativo (bien necesario - Ley de Engel)
      w_alim <- 0.65 - 0.08 * log_xp
      w_alim <- max(0.10, min(0.70, w_alim))
      
      # Lujos: beta positivo (bien suntuario)
      w_lujo <- 0.05 + 0.07 * log_xp
      w_lujo <- max(0.05, min(0.60, w_lujo))
      
      # Vivienda: residuo
      w_viv <- 1 - w_alim - w_lujo
      
      # Curva de Engel para Alimentos
      g_seq <- seq(200, 2500, length.out = 100)
      w_engel <- 0.65 - 0.08 * log(g_seq / (p1^0.4))
      
      list(w_alim = w_alim, w_lujo = w_lujo, w_viv = w_viv,
           g_seq = g_seq, w_engel = w_engel)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Composicion de la canasta
      cuotas <- c(d$w_alim, d$w_viv, d$w_lujo) * 100
      bp <- barplot(cuotas, names.arg = c("Alimentos", "Vivienda", "Bienes Lujo"),
                    col = c("#e67e22", "#3498db", "#9b59b6"),
                    ylab = "Proporción del gasto total (%)", ylim = c(0, 80),
                    main = "Estructura del Presupuesto")
      text(bp, cuotas + 3, sprintf("%.1f%%", cuotas), font = 2)
      grid(nx = NA, ny = NULL)

      # Curva de Engel (Ley de Engel de Deaton)
      plot(d$g_seq, d$w_engel * 100, type = "l", col = "#e67e22", lwd = 3,
           xlab = "Presupuesto total del hogar ($)", ylab = "% Destinado a alimentos",
           ylim = c(10, 70), main = "Curva de Engel (Alimentos)")
      points(input$gasto, d$w_alim * 100, pch = 21, bg = "#c0392b", cex = 2.2, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Cumplimiento de la Ley de Engel:"),
        tags$p(sprintf("Con un presupuesto de $%d, el hogar destina el %.1f%% a alimentos básicos. Conforme aumentan los ingresos, la proporción alimentaria decrece y la cuota de bienes suntuarios se expande hasta el %.1f%%.",
                       input$gasto, d$w_alim * 100, d$w_lujo * 100))
      )
    })`,
    explanation: `
    <p>El Almost Ideal Demand System (AIDS) propuesto por Deaton y Muellbauer en 1980 permitió contrastar las restricciones de simetría y homogeneidad de la teoría del consumidor con datos reales de encuestas de hogares.</p>
    <p><strong>Contribución Nobel 2015:</strong> Angus Deaton integró el análisis microeconómico del consumo, la nutrición y el bienestar con la medición rigurosa de la pobreza en países en desarrollo.</p>`
  }
};

for (const [slug, cfg] of Object.entries(apps)) {
  const targetDir = path.join(rootDir, "laureados", slug, "shiny");
  fs.mkdirSync(targetDir, { recursive: true });
  const appFile = path.join(targetDir, "app.R");
  
  const content = `# laureados/${slug}/shiny/app.R
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "${cfg.title}",
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#1a5276"),
  sidebar = sidebar(
${cfg.sidebar.trim()}
  ),
  card(
    card_header("Simulación Dinámica"),
    plotOutput("grafico"),
    uiOutput("lectura")
  ),
  card(
    card_header("¿Qué estoy viendo?"),
    ${cfg.explanation.trim().split("\n").map(l => l.trim()).filter(Boolean).map(l => `HTML('${l.replace(/'/g, "\\'")}')`).join(",\n    ")}
  )
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    ${cfg.resets.trim()}
  })
${cfg.serverLogic}
}

shinyApp(ui = ui, server = server)
`;

  fs.writeFileSync(appFile, content, "utf8");
  console.log(`Creada app: ${slug}`);
}
