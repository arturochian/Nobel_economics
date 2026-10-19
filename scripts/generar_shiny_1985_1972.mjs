// scripts/generar_shiny_1985_1972.mjs
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

const apps = {
  "1985_modigliani": {
    title: "1985 · Hipótesis del Ciclo de Vida del Consumo (Modigliani)",
    sidebar: `
    sliderInput("edad_retiro", "Edad planificada de jubilación", min = 55, max = 75, value = 65, step = 1),
    sliderInput("esperanza_vida", "Esperanza de vida estimada", min = 70, max = 95, value = 85, step = 1),
    sliderInput("ingreso_anual", "Salario anual durante la etapa laboral ($)", min = 20000, max = 100000, value = 50000, step = 5000),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Franco Modigliani (1954): los individuos suavizan su consumo a lo largo de su vida, acumulando riqueza durante sus años activos para financiar su vejez.")`,
    resets: `updateSliderInput(session, "edad_retiro", value = 65)
    updateSliderInput(session, "esperanza_vida", value = 85)
    updateSliderInput(session, "ingreso_anual", value = 50000)`,
    serverLogic: `
    datos <- reactive({
      req(input$edad_retiro < input$esperanza_vida)
      edad_inicio <- 20
      R <- input$edad_retiro
      L <- input$esperanza_vida
      Y <- input$ingreso_anual
      
      anios_trabajo <- R - edad_inicio
      anios_vida <- L - edad_inicio
      
      # Consumo constante anual: C = (anios_trabajo / anios_vida) * Y
      C <- (anios_trabajo / anios_vida) * Y
      
      edades <- edad_inicio:L
      ingresos <- ifelse(edades < R, Y, 0)
      consumo <- rep(C, length(edades))
      
      # Riqueza acumulada W_t = sum(Y - C)
      riqueza <- cumsum(ingresos - consumo)
      
      list(edades = edades, Y = ingresos, C = consumo, W = riqueza,
           c_val = C, w_max = max(riqueza), R = R)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Ingreso vs Consumo
      plot(d$edades, d$Y, type = "l", col = "#2980b9", lwd = 2.5, lty = 2,
           xlab = "Edad del individuo", ylab = "Flujo anual ($)",
           ylim = c(0, max(d$Y) * 1.2), main = "Ingreso vs. Consumo Suavizado")
      lines(d$edades, d$C, col = "#27ae60", lwd = 3)
      abline(v = d$R, col = "#7f8c8d", lty = 3)
      grid()
      legend("topright", legend = c("Ingreso Laboral", "Consumo Constante (C)"),
             col = c("#2980b9", "#27ae60"), lwd = c(2.5, 3), lty = c(2, 1), bty = "n")

      # Panel 2: Trayectoria de Riqueza Acumulada
      plot(d$edades, d$W, type = "l", col = "#e67e22", lwd = 3,
           xlab = "Edad del individuo", ylab = "Riqueza acumulada ($)",
           main = "Joroba de Riqueza (Ciclo de Vida)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = d$R, col = "#7f8c8d", lty = 3)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Patrón de Ahorro Intertemporal:"),
        tags$p(sprintf("El individuo mantiene un consumo estable de $%.0f/año. Su riqueza alcanza un pico de $%.0f a los %d años de edad (momento de jubilación) y se desahorra progresivamente hasta agotarse al final de la vida.",
                       d$c_val, d$w_max, d$R))
      )
    })`,
    explanation: `
    <p>Franco Modigliani derribó la hipótesis keynesiana simple de que el consumo dependía únicamente del ingreso corriente del mes: las familias planifican su consumo a lo largo de toda su vida, ahorrando en su juventud y desahorrando en la vejez.</p>
    <p><strong>Contribución Nobel 1985:</strong> Franco Modigliani transformó la teoría macroeconómica del ahorro y, junto a Merton Miller, fundó los teoremas modernos de estructura de capital corporativo.</p>`
  },

  "1984_stone": {
    title: "1984 · Cuentas Nacionales y Sistema Lineal de Gasto (Stone)",
    sidebar: `
    sliderInput("gasto_total", "Presupuesto total familiar ($)", min = 400, max = 3000, value = 1200, step = 100),
    sliderInput("subsistencia_alim", "Gasto de subsistencia en alimentos ($)", min = 200, max = 600, value = 350, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Richard Stone: arquitecto de los sistemas de contabilidad nacional estandarizados de la ONU y pionero del Sistema Lineal de Gasto (LES).")`,
    resets: `updateSliderInput(session, "gasto_total", value = 1200)
    updateSliderInput(session, "subsistencia_alim", value = 350)`,
    serverLogic: `
    datos <- reactive({
      X <- input$gasto_total
      gamma_alim <- input$subsistencia_alim
      gamma_otros <- 200
      
      # Gasto residual supernumerario
      supernumerario <- max(0, X - (gamma_alim + gamma_otros))
      
      # Sistema Lineal de Gasto (LES):
      # e_i = gamma_i + beta_i * (X - sum(gamma))
      beta_alim <- 0.25
      beta_otros <- 0.75
      
      gasto_alim <- gamma_alim + beta_alim * supernumerario
      gasto_otros <- gamma_otros + beta_otros * supernumerario
      
      list(ga = gasto_alim, go = gasto_otros, sup = supernumerario)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      gastos <- c(d$ga, d$go)
      bp <- barplot(gastos, names.arg = c("Alimentos Básicos", "Otros Bienes y Servicios"),
                    col = c("#e67e22", "#3498db"),
                    ylab = "Gasto realizado ($)",
                    ylim = c(0, max(gastos) * 1.25),
                    main = "Asignación del Gasto Familiar (Sistema Stone LES)")
      text(bp, gastos + 40, sprintf("$%.0f", gastos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estructura de la Demanda de Stone:"),
        tags$p(sprintf("Tras cubrir los requerimientos indispensables de subsistencia, la familia dispone de un presupuesto supernumerario de $%.0f, del cual destina el 75%% a bienes no alimentarios.",
                       d$sup))
      )
    })`,
    explanation: `
    <p>Richard Stone desarrolló el primer sistema integrado de cuentas nacionales para medir el PIB, el ahorro y la inversión de forma contable rigurosa, adoptado globalmente por la ONU, el Banco Mundial y la OCDE.</p>
    <p><strong>Contribución Nobel 1984:</strong> Richard Stone proporcionó las bases empíricas cuantitativas que permiten a los gobiernos medir y comparar la actividad macroeconómica del planeta.</p>`
  },

  "1983_debreu": {
    title: "1983 · Teoría del Valor y Equilibrio General (Gerard Debreu)",
    sidebar: `
    sliderInput("dotacion_x", "Dotación inicial de Alimentos (Agente A)", min = 2, max = 18, value = 10, step = 1),
    sliderInput("dotacion_y", "Dotación inicial de Ropa (Agente A)", min = 2, max = 18, value = 4, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gerard Debreu (1959, 'Theory of Value'): demostración matemática rigurosa de la existencia del equilibrio walrasiano en una caja de Edgeworth.")`,
    resets: `updateSliderInput(session, "dotacion_x", value = 10)
    updateSliderInput(session, "dotacion_y", value = 4)`,
    serverLogic: `
    datos <- reactive({
      wx <- input$dotacion_x
      wy <- input$dotacion_y
      
      # Dimensiones totales de la caja
      tot_x <- 20
      tot_y <- 20
      
      # Equilibrio competitivo walrasiano de intercambio puro
      p_rel <- 1.0 # Precio relativo en equilibrio simetrico
      eq_x <- 10; eq_y <- 10
      
      list(wx = wx, wy = wy, ex = eq_x, ey = eq_y, tx = tot_x, ty = tot_y)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(c(0, d$tx), c(0, d$ty), type = "n",
           xlab = "Bien X (Alimentos Agente A)", ylab = "Bien Y (Ropa Agente A)",
           main = "Caja de Edgeworth y Equilibrio General de Debreu")
      
      # Recta presupuestaria competitiva que pasa por la dotacion
      abline(a = d$wy + d$wx, b = -1, col = "#7f8c8d", lty = 2)
      
      # Curva de contrato / equilibrio
      lines(c(0, d$tx), c(0, d$ty), col = "#27ae60", lwd = 2.5)
      
      points(d$wx, d$wy, pch = 21, bg = "#3498db", cex = 2.2, lwd = 2)
      text(d$wx + 1, d$wy, "Dotación Inicial (w)", col = "#3498db", font = 2)
      
      points(d$ex, d$ey, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$ex + 1, d$ey - 1, "Equilibrio Walrasiano (x*)", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Existencia del Equilibrio General:"),
        tags$p(sprintf("Partiendo de una dotación arbitraria (X=%d, Y=%d), los precios relativos guían el intercambio voluntario hasta el punto de tangencia de óptimo de Pareto (X*=%d, Y*=%d).",
                       d$wx, d$wy, d$ex, d$ey))
      )
    })`,
    explanation: `
    <p>Adam Smith conjeturó en 1776 que una 'mano invisible' coordinaba los mercados. Gerard Debreu y Kenneth Arrow lograron la prueba matemática definitiva en los años 1950, demostrando bajo qué condiciones topológicas exactas existe un vector de precios que equilibra todos los mercados simultáneamente.</p>
    <p><strong>Contribución Nobel 1983:</strong> Gerard Debreu introdujo el rigor axiomático y los métodos de análisis convexo en la ciencia económica.</p>`
  },

  "1982_stigler": {
    title: "1982 · Economía de la Información y Captura Regulatoria (Stigler)",
    sidebar: `
    sliderInput("costo_busqueda", "Costo marginal de cotizar un precio ($)", min = 1, max = 15, value = 4, step = 1),
    sliderInput("dispersion_precios", "Dispersión de precios en el mercado (sigma)", min = 10, max = 50, value = 25, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("George Stigler (1961): la ignorancia sobre precios es económica; las personas buscan cotizaciones hasta que el ahorro esperado iguala el costo de búsqueda.")`,
    resets: `updateSliderInput(session, "costo_busqueda", value = 4)
    updateSliderInput(session, "dispersion_precios", value = 25)`,
    serverLogic: `
    datos <- reactive({
      c_b <- input$costo_busqueda
      sig <- input$dispersion_precios
      
      # Numero optimo de busquedas n*
      # Ahorro marginal decreciente: sig / sqrt(n) = c_b  =>  n* = (sig / c_b)^2
      n_opt <- (sig / c_b)^1.5 * 0.4
      n_opt <- max(1, min(20, round(n_opt)))
      
      precio_base <- 200
      precio_min_esperado <- precio_base - sig * sqrt(log(n_opt + 1)) * 0.9
      
      list(n = n_opt, p_min = precio_min_esperado, c_b = c_b)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      n_seq <- 1:20
      ahorro_mg <- input$dispersion_precios / sqrt(n_seq) * 1.5
      
      plot(n_seq, ahorro_mg, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Número de tiendas o cotizaciones consultadas (n)",
           ylab = "Ahorro marginal esperado ($)",
           ylim = c(0, max(ahorro_mg) * 1.15),
           main = "Búsqueda Óptima de Información de Stigler (1961)")
      abline(h = d$c_b, col = "#c0392b", lwd = 2.5, lty = 2)
      abline(v = d$n, col = "#27ae60", lwd = 2, lty = 3)
      grid()
      legend("topright", legend = c("Ahorro Marginal por Cotizar", "Costo de Búsqueda (Tiempo/Transporte)"),
             col = c("#2980b9", "#c0392b"), lwd = c(2.5, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Regla de Búsqueda Racional:"),
        tags$p(sprintf("El comprador óptimo consulta exactamente %d tiendas antes de comprar. Más cotizaciones costarían más tiempo del que ahorran en el precio ($%.2f esperado).",
                       d$n, d$p_min))
      )
    })`,
    explanation: `
    <p>George Stigler fundó la economía de la información al demostrar que la dispersión de precios existe no por fraude, sino porque recopilar información es costoso. También formuló la teoría de la 'captura regulatoria': las industrias reguladas terminan cooptando a los reguladores para restringir la competencia.</p>
    <p><strong>Contribución Nobel 1982:</strong> George Stigler transformó la organización industrial y el análisis económico de la regulación pública.</p>`
  },

  "1981_tobin": {
    title: "1981 · Teoría de Cartera y la Q de Tobin para Inversión",
    sidebar: `
    sliderInput("valor_mercado", "Valor de mercado en bolsa de la empresa ($ millones)", min = 50, max = 300, value = 140, step = 10),
    sliderInput("costo_reposicion", "Costo de reposición del capital físico ($ millones)", min = 50, max = 200, value = 100, step = 10),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Tobin: el ratio Q (valor de mercado / costo de reposición) explica la decisión de inversión productiva de las empresas.")`,
    resets: `updateSliderInput(session, "valor_mercado", value = 140)
    updateSliderInput(session, "costo_reposicion", value = 100)`,
    serverLogic: `
    datos <- reactive({
      vm <- input$valor_mercado
      cr <- input$costo_reposicion
      
      q <- vm / cr
      # Tasa de inversion corporativa en funcion de Q
      inversion <- max(0, 15 * (q - 1))
      
      list(q = q, inv = inversion)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      bp <- barplot(d$q, names.arg = c("Ratio Q de Tobin"),
                    col = ifelse(d$q > 1, "#27ae60", "#c0392b"),
                    ylab = "Valoración de Mercado / Costo Físico",
                    ylim = c(0, 2.5), main = "La Regla Q de Inversión de Tobin")
      abline(h = 1.0, col = "#7f8c8d", lwd = 2.5, lty = 2)
      text(bp, d$q + 0.12, sprintf("Q = %.2f", d$q), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Decisión de Inversión Empresarial:"),
        tags$p(sprintf("Con Q = %.2f: %s Tasa de inversión productiva estimada: %.1f%% del stock de capital.",
                       d$q,
                       ifelse(d$q > 1,
                              "Al ser Q > 1, comprar maquinaria nueva es más barato que comprar acciones de empresas existentes; las empresas tienen fuertes incentivos para invertir en capital físico.",
                              "Al ser Q < 1, el mercado valora el capital por debajo de su costo de reemplazo; es más barato crecer comprando competidores que construyendo fábricas nuevas."),
                       d$inv))
      )
    })`,
    explanation: `
    <p>James Tobin conectó las finanzas con la economía real formulando el indicador Q de Tobin y el Teorema de Separación de Portafolios (los inversores sólo necesitan combinar un portafolio de activos riesgosos con un activo libre de riesgo según su aversión personal).</p>
    <p><strong>Contribución Nobel 1981:</strong> James Tobin revolucionó la teoría de los mercados financieros y su relación con el gasto, el empleo y los precios.</p>`
  },

  "1980_klein": {
    title: "1980 · Modelos Macroeconométricos de Ecuaciones Simultáneas (Klein)",
    sidebar: `
    sliderInput("propension_c", "Propensión marginal a consumir (c)", min = 0.4, max = 0.9, value = 0.7, step = 0.05),
    sliderInput("gasto_publico", "Incremento de gasto público (G)", min = 0, max = 40, value = 15, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Lawrence Klein: pionero en la construcción de los primeros modelos econométricos computacionales para pronóstico macroeconómico.")`,
    resets: `updateSliderInput(session, "propension_c", value = 0.7)
    updateSliderInput(session, "gasto_publico", value = 15)`,
    serverLogic: `
    datos <- reactive({
      c <- input$propension_c
      g <- input$gasto_publico
      
      # Multiplicador keynesiano estructural de Klein: k = 1 / (1 - c)
      k <- 1 / (1 - c)
      delta_pib <- k * g
      
      list(c = c, g = g, k = k, dpib = delta_pib)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      c_seq <- seq(0.4, 0.9, length.out = 50)
      k_seq <- 1 / (1 - c_seq)
      
      plot(c_seq, k_seq, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Propensión marginal a consumir (c)", ylab = "Multiplicador del Gasto k = 1/(1-c)",
           ylim = c(1, 10), main = "Multiplicador Estructural de Klein")
      points(d$c, d$k, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Predicción del Modelo de Klein:"),
        tags$p(sprintf("Con una propensión a consumir de %.2f, el multiplicador macroeconómico es de %.2f. Un paquete de gasto fiscal de $%d genera una expansión acumulada en el PIB de +$%.1f.",
                       d$c, d$k, d$g, d$dpib))
      )
    })`,
    explanation: `
    <p>Lawrence Klein transformó la teoría keynesiana abstracta en sistemas de ecuaciones estimables empíricamente (como el Modelo Klein-Goldberger y el Proyecto LINK que conectaba los modelos económicos de múltiples países).</p>
    <p><strong>Contribución Nobel 1980:</strong> Lawrence Klein fue el padre de los pronósticos macroeconométricos computarizados para la formulación de políticas públicas.</p>`
  },

  "1979_schultz_lewis": {
    title: "1979 · Economía del Desarrollo: Lewis (Dualismo) y Schultz (Capital Humano)",
    sidebar: `
    sliderInput("salario_subsistencia", "Salario agrícola de subsistencia (ws)", min = 5, max = 20, value = 10, step = 1),
    sliderInput("prima_urbana", "Prima salarial del sector industrial urbano (%)", min = 10, max = 60, value = 30, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Arthur Lewis (desarrollo con oferta ilimitada de mano de obra en economía dual) y Theodore Schultz (la inversión en capital humano agrícola erradica la pobreza).")`,
    resets: `updateSliderInput(session, "salario_subsistencia", value = 10)
    updateSliderInput(session, "prima_urbana", value = 30)`,
    serverLogic: `
    datos <- reactive({
      ws <- input$salario_subsistencia
      prima <- input$prima_urbana / 100
      
      wu <- ws * (1 + prima)
      
      # Empleo absorbido por la industria urbana
      empleo_urbano <- 100 * (1.5 / (1 + prima * 0.8))
      
      list(ws = ws, wu = wu, emp = empleo_urbano)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      salarios <- c(d$ws, d$wu)
      bp <- barplot(salarios, names.arg = c("Sector Tradicional / Rural (ws)", "Sector Moderno / Industrial (wu)"),
                    col = c("#bdc3c7", "#27ae60"),
                    ylab = "Salario real ($)",
                    ylim = c(0, max(salarios) * 1.3),
                    main = "El Modelo de Economía Dual de Arthur Lewis")
      text(bp, salarios + 1, sprintf("$%.1f", salarios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Dinámica de Lewis:"),
        tags$p(sprintf("El sector industrial atrae excedente de mano de obra rural ofreciendo una prima del %.0f%% (salario $%.1f). Mientras exista mano de obra ociosa en el campo, los beneficios industriales se reinvierten sin presiones alcistas de costos.",
                       input$prima_urbana, d$wu))
      )
    })`,
    explanation: `
    <p>Arthur Lewis explicó la industrialización de países en desarrollo mediante la transferencia de trabajadores del campo improductivo a las fábricas urbanas. Theodore Schultz demostró que los campesinos tradicionales no son irracionales, sino eficientes pero pobres por falta de acceso a educación, salud y tecnología (capital humano).</p>
    <p><strong>Contribución Nobel 1979:</strong> Theodore Schultz y Arthur Lewis establecieron el estudio económico riguroso de los problemas que enfrentan los países en desarrollo.</p>`
  },

  "1978_simon": {
    title: "1978 · Racionalidad Limitada y Conducta de Satisfacción (Simon)",
    sidebar: `
    sliderInput("umbral_aspiracion", "Nivel de exigencia / aspiración del decisor ($)", min = 60, max = 95, value = 80, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Herbert A. Simon: los humanos no optimizan globalmente porque la mente humana tiene capacidad de cómputo finita; toman decisiones de satisfacción (satisficing).")`,
    resets: `updateSliderInput(session, "umbral_aspiracion", value = 80)`,
    serverLogic: `
    datos <- reactive({
      set.seed(1978)
      alternativas <- round(runif(30, 40, 100))
      umbral <- input$umbral_aspiracion
      
      # Primer elemento que cumple el umbral
      idx <- which(alternativas >= umbral)[1]
      if (is.na(idx)) idx <- 30
      
      valor_elegido <- alternativas[idx]
      optimo_global <- max(alternativas)
      
      list(alt = alternativas, idx = idx, val = valor_elegido, opt = optimo_global, umb = umbral)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      plot(1:length(d$alt), d$alt, type = "b", pch = 19, col = "#bdc3c7",
           xlab = "Alternativas evaluadas secuencialmente", ylab = "Calidad de la opción ($)",
           ylim = c(35, 105), main = "Satisfacción (Satisficing) vs. Optimización Exhaustiva")
      abline(h = d$umb, col = "#e67e22", lwd = 2, lty = 2)
      abline(h = d$opt, col = "#27ae60", lwd = 1.5, lty = 3)
      
      # Marcamos la elegida
      points(d$idx, d$val, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$idx, d$val + 5, "Elegida por Satisfacción", col = "#e74c3c", font = 2)
      grid()
      legend("bottomright", legend = c("Umbral de Aspiración", "Óptimo Global Inalcanzable"),
             col = c("#e67e22", "#27ae60"), lwd = c(2, 1.5), lty = c(2, 3), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Heurística de Herbert Simon:"),
        tags$p(sprintf("El agente se detiene en la alternativa número %d tras encontrar una opción de valor %d que satisface su aspiración (%d), ahorrándose evaluar las 30 opciones del mercado.",
                       d$idx, d$val, d$umb))
      )
    })`,
    explanation: `
    <p>Herbert Simon fue un polímata pionero en inteligencia artificial y psicología organizacional que demostró la imposibilidad práctica de la optimización perfecta neoclásica: las personas y las empresas usan heurísticas de satisfacción satisfactoria dadas sus restricciones cognitivas y de tiempo.</p>
    <p><strong>Contribución Nobel 1978:</strong> Herbert Simon revolucionó la teoría de la toma de decisiones dentro de las organizaciones económicas.</p>`
  },

  "1977_ohlin_meade": {
    title: "1977 · Comercio Heckscher-Ohlin y Teoría del Segundo Mejor (Meade)",
    sidebar: `
    sliderInput("abundancia_capital", "Ratio Capital/Trabajo del País Doméstico", min = 0.5, max = 3.0, value = 2.0, step = 0.25),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Bertil Ohlin (el comercio surge de la dotación factorial de recursos) y James Meade (política comercial internacional y el Teorema del Segundo Mejor).")`,
    resets: `updateSliderInput(session, "abundancia_capital", value = 2.0)`,
    serverLogic: `
    datos <- reactive({
      k_l <- input$abundancia_capital
      
      # Si K/L > 1 exporta bienes intensivos en capital e importa intensivos en trabajo
      exp_capital <- 100 * (k_l / (1 + k_l))
      exp_trabajo <- 100 - exp_capital
      
      list(kl = k_l, ec = exp_capital, et = exp_trabajo)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      partes <- c(d$ec, d$et)
      bp <- barplot(partes, names.arg = c("Bienes Intensivos en Capital (Maquinaria)", "Bienes Intensivos en Trabajo (Textiles)"),
                    col = c("#2980b9", "#e67e22"),
                    ylab = "Composición de exportaciones (%)",
                    ylim = c(0, 100),
                    main = "Patrón de Comercio de Heckscher-Ohlin")
      text(bp, partes + 3, sprintf("%.1f%%", partes), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Teorema de Heckscher-Ohlin:"),
        tags$p(sprintf("Al ser abundante en capital (K/L = %.2f), el país tiene ventaja comparativa y exporta mayoritariamente bienes intensivos en capital (%.1f%% de sus ventas externas).",
                       d$kl, d$ec))
      )
    })`,
    explanation: `
    <p>Bertil Ohlin y Eli Heckscher formularon el modelo que explica por qué los países comercian: exportan aquellos bienes que utilizan intensivamente sus factores de producción abundantes. James Meade formuló la Teoría del Segundo Mejor: eliminar una sola distorsión arancelaria cuando persisten otras puede reducir el bienestar en vez de aumentarlo.</p>
    <p><strong>Contribución Nobel 1977:</strong> Bertil Ohlin y James Meade transformaron la teoría del comercio internacional y los movimientos mundiales de capital.</p>`
  },

  "1976_friedman": {
    title: "1976 · Ingreso Permanente, Monetarismo y Ecuación Cuantitativa (Friedman)",
    sidebar: `
    sliderInput("ingreso_transitorio", "Shock de ingreso temporal / lotería ($)", min = -5000, max = 15000, value = 8000, step = 1000),
    sliderInput("crecimiento_dinero", "Tasa de crecimiento monetario (M %)", min = 0, max = 15, value = 6, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Milton Friedman: el consumo responde al ingreso permanente, no al transitorio; 'la inflación es siempre y en todo lugar un fenómeno monetario'.")`,
    resets: `updateSliderInput(session, "ingreso_transitorio", value = 8000)
    updateSliderInput(session, "crecimiento_dinero", value = 6)`,
    serverLogic: `
    datos <- reactive({
      y_p <- 40000 # Ingreso permanente constante
      y_t <- input$ingreso_transitorio
      m_dot <- input$crecimiento_dinero
      
      # Hipotesis del ingreso permanente: propension marginal a consumir del ingreso transitorio es casi nula
      consumo <- 0.9 * y_p + 0.05 * y_t
      
      # Ecuacion cuantitativa MV = PY: a largo plazo pi = m_dot - y_dot
      crecimiento_pib_real <- 2.5
      inflacion_eq <- max(0, m_dot - crecimiento_pib_real)
      
      list(c = consumo, inf = inflacion_eq, yp = y_p, yt = y_t)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Ingreso total vs Consumo
      y_total <- d$yp + d$yt
      bp <- barplot(c(y_total, d$c), names.arg = c("Ingreso Total del Año", "Consumo Efectivo"),
                    col = c("#3498db", "#27ae60"),
                    ylab = "Dólares ($)", ylim = c(0, max(y_total, d$c) * 1.25),
                    main = "Hipótesis del Ingreso Permanente")
      text(bp, c(y_total, d$c) + 2000, sprintf("$%.0f", c(y_total, d$c)), font = 2)
      grid(nx = NA, ny = NULL)

      # Inflacion monetaria
      bp2 <- barplot(d$inf, names.arg = c("Inflación a Largo Plazo"),
                     col = "#c0392b", ylab = "Tasa de Inflación Anual (%)", ylim = c(0, 15),
                     main = "Monetarismo (MV = PY)")
      text(bp2, d$inf + 0.6, sprintf("%.1f%%", d$inf), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Conclusiones de Milton Friedman:"),
        tags$p(sprintf("Un bono transitorio de $%.0f apenas eleva el consumo en $%.0f porque casi todo se ahorra. Un crecimiento monetario del %.1f%% genera una inflación estructural a largo plazo del %.1f%%.",
                       d$yt, 0.05 * d$yt, input$crecimiento_dinero, d$inf))
      )
    })`,
    explanation: `
    <p>Milton Friedman demostró empíricamente que la Gran Depresión de 1929 fue provocada por una contracción devastadora de la oferta monetaria por parte de la Reserva Federal. También refutó la política de transferencias de estímulo puntual al probar que las familias ahorran los ingresos transitorios.</p>
    <p><strong>Contribución Nobel 1976:</strong> Milton Friedman fue el líder del monetarismo y de la reformulación del consumo intertemporal y la política de estabilización.</p>`
  },

  "1975_kantorovich_koopmans": {
    title: "1975 · Programación Lineal y Precios Sombra (Kantorovich & Koopmans)",
    sidebar: `
    sliderInput("recurso_horas", "Disponibilidad de horas de maquinaria disponible", min = 40, max = 150, value = 100, step = 10),
    sliderInput("precio_producto1", "Margen unitario Producto A ($)", min = 20, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Leonid Kantorovich y Tjalling Koopmans: formulación de la programación lineal y descubrimiento de los precios sombra como multiplicadores de escasez.")`,
    resets: `updateSliderInput(session, "recurso_horas", value = 100)
    updateSliderInput(session, "precio_producto1", value = 40)`,
    serverLogic: `
    datos <- reactive({
      H <- input$recurso_horas
      p1 <- input$precio_producto1
      
      # Max p1*x1 + 30*x2  s.a.  2*x1 + 1*x2 <= H
      # Si p1/2 > 30/1 => produce todo Producto A, precio sombra = p1/2
      if (p1 / 2 >= 30) {
        x1_opt <- H / 2
        x2_opt <- 0
        precio_sombra <- p1 / 2
      } else {
        x1_opt <- 0
        x2_opt <- H
        precio_sombra <- 30
      }
      beneficio_max <- p1 * x1_opt + 30 * x2_opt
      
      list(x1 = x1_opt, x2 = x2_opt, sombra = precio_sombra, ben = beneficio_max)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      cantidades <- c(d$x1, d$x2)
      bp <- barplot(cantidades, names.arg = c("Producto A Óptimo", "Producto B Óptimo"),
                    col = c("#2980b9", "#27ae60"),
                    ylab = "Unidades a fabricar",
                    ylim = c(0, max(cantidades) * 1.25),
                    main = "Asignación Óptima por Programación Lineal")
      text(bp, cantidades + 3, sprintf("%.0f uds", cantidades), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Valoración Marginal del Recurso Escaso:"),
        tags$p(sprintf("El precio sombra (shadow price) de una hora adicional de maquinaria es de $%.2f. El beneficio máximo obtenido asciende a $%.0f.",
                       d$sombra, d$ben))
      )
    })`,
    explanation: `
    <p>Leonid Kantorovich descubrió en la Unión Soviética en 1939 la programación lineal para optimizar la producción industrial, demostrando que los precios sombra son indispensables para la eficiencia incluso en una economía centralizada. Tjalling Koopmans desarrolló el análisis de actividades en Occidente.</p>
    <p><strong>Contribución Nobel 1975:</strong> Crearon la teoría de la asignación óptima de recursos y los métodos de optimización matemática lineal.</p>`
  },

  "1974_myrdal_hayek": {
    title: "1974 · El Sistema de Precios como Transmisor de Información (Hayek)",
    sidebar: `
    sliderInput("shock_escasez", "Magnitud de la escasez física local (pérdida de suministro %)", min = 10, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Friedrich von Hayek (1945, 'The Use of Knowledge in Society'): los precios comunican información dispersa sin que nadie conozca la causa.")`,
    resets: `updateSliderInput(session, "shock_escasez", value = 40)`,
    serverLogic: `
    datos <- reactive({
      shock <- input$shock_escasez
      # Senal de precios resultante
      precio_rel <- 100 * (1 + (shock / 100)^1.2 * 1.8)
      # Sustitucion voluntaria del consumidor
      consumo_reducido <- 100 * (1 - shock / 120)
      
      list(p = precio_rel, c = consumo_reducido)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      vals <- c(100, d$p)
      bp <- barplot(vals, names.arg = c("Precio Normal de Referencia", "Precio tras Shock de Escasez"),
                    col = c("#bdc3c7", "#e74c3c"),
                    ylab = "Índice de Precios",
                    ylim = c(0, max(vals) * 1.25),
                    main = "El Sistema de Precios como Mecanismo de Señales (Hayek)")
      text(bp, vals + 10, sprintf("%.0f", vals), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Coordinación Espontánea de Hayek:"),
        tags$p(sprintf("Al subir el precio a %.0f, millones de consumidores racionan su consumo en un %.1f%% de forma instantánea, sin que ningún ministerio central deba ordenarles qué hacer ni explicarles por qué se redujo la oferta.",
                       d$p, 100 - d$c))
      )
    })`,
    explanation: `
    <p>Friedrich Hayek demostró que el verdadero problema económico no es el cálculo matemático de recursos conocidos, sino cómo utilizar un conocimiento disperso que nadie posee en su totalidad: los precios de mercado actúan como telecomunicaciones que sintetizan información oculta.</p>
    <p><strong>Contribución Nobel 1974:</strong> Gunnar Myrdal y Friedrich Hayek fueron reconocidos por su trabajo pionero en la teoría del dinero y el análisis interdisciplinario de las instituciones económicas.</p>`
  },

  "1973_leontief": {
    title: "1973 · Tablas Insumo-Producto y Matriz de Leontief",
    sidebar: `
    sliderInput("demanda_final_ind", "Aumento en demanda final industrial ($ M)", min = 10, max = 100, value = 40, step = 10),
    sliderInput("interdependencia", "Coeficiente de interdependencia insumo-producto (a12)", min = 0.1, max = 0.5, value = 0.3, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Wassily Leontief: invención de las matrices de Insumo-Producto (Input-Output) para calcular la producción total directa e indirecta.")`,
    resets: `updateSliderInput(session, "demanda_final_ind", value = 40)
    updateSliderInput(session, "interdependencia", value = 0.3)`,
    serverLogic: `
    datos <- reactive({
      d2 <- input$demanda_final_ind
      a <- input$interdependencia
      
      # Matriz simplificada de 2 sectores (Agricultura e Industria)
      # X = (I - A)^(-1) * D
      # Multiplicador Leontief: 1 / (1 - a)
      mult <- 1 / (1 - a^2)
      produccion_total <- mult * d2
      produccion_indirecta <- produccion_total - d2
      
      list(d2 = d2, tot = produccion_total, ind = produccion_indirecta, mult = mult)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$d2, d$tot)
      bp <- barplot(valores, names.arg = c("Demanda Final Directa", "Producción Bruta Requerida Total"),
                    col = c("#3498db", "#27ae60"),
                    ylab = "Millones de Dólares ($ M)",
                    ylim = c(0, max(valores) * 1.25),
                    main = "Efecto Multiplicador Intersectorial de Leontief")
      text(bp, valores + 3, sprintf("$%.1f M", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Cálculo Inverso de Leontief (I - A)^(-1):"),
        tags$p(sprintf("Para satisfacer un pedido final de $%.0f M, la economía debe generar $%.1f M en producción total bruta debido a los $%.1f M necesarios en insumos intermedios intersectoriales.",
                       d$d2, d$tot, d$ind))
      )
    })`,
    explanation: `
    <p>Wassily Leontief transformó la economía aplicada al desarrollar las matrices de Insumo-Producto (Input-Output), que trazan matemáticamente cómo el carbón entra en el acero, el acero en la maquinaria y la maquinaria en los bienes de consumo final.</p>
    <p><strong>Contribución Nobel 1973:</strong> Wassily Leontief creó el método de insumo-producto utilizado hoy universalmente en matrices contables y análisis de huella de carbono.</p>`
  },

  "1972_hicks_arrow": {
    title: "1972 · Equilibrio General y Modelo IS-LM (Hicks & Arrow)",
    sidebar: `
    sliderInput("sensibilidad_i", "Sensibilidad de la inversión a la tasa de interés", min = 5, max = 30, value = 15, step = 2),
    sliderInput("demanda_dinero_k", "Sensibilidad de la demanda de dinero al ingreso (k)", min = 0.2, max = 0.8, value = 0.5, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("John Hicks (creador del modelo IS-LM y efecto sustitución/renta) y Kenneth Arrow (teoremas fundamentales del bienestar y teorema de imposibilidad).")`,
    resets: `updateSliderInput(session, "sensibilidad_i", value = 15)
    updateSliderInput(session, "demanda_dinero_k", value = 0.5)`,
    serverLogic: `
    datos <- reactive({
      b <- input$sensibilidad_i
      k <- input$demanda_dinero_k
      
      # Equilibrio IS-LM
      # Curva IS: r = 12 - 0.08 * Y
      # Curva LM: r = 2 + (k / 10) * Y
      y_seq <- seq(40, 140, length.out = 100)
      r_is <- 14 - (b / 100) * y_seq
      r_lm <- 1 + (k / 10) * (y_seq - 40)
      
      # Interseccion
      # 14 - (b/100)*Y = 1 + (k/10)*Y - 4*k  =>  Y*(b/100 + k/10) = 13 + 4*k
      y_eq <- (13 + 4 * k) / (b / 100 + k / 10)
      r_eq <- 14 - (b / 100) * y_eq
      
      list(y = y_seq, is = r_is, lm = r_lm, y_eq = y_eq, r_eq = r_eq)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$y, d$is, type = "l", col = "#c0392b", lwd = 3,
           xlab = "Ingreso / Producción Real (Y)", ylab = "Tasa de Interés Real (r %)",
           ylim = c(0, 15), main = "El Modelo IS-LM de John Hicks (1937)")
      lines(d$y, d$lm, col = "#2980b9", lwd = 3)
      points(d$y_eq, d$r_eq, pch = 21, bg = "#f1c40f", cex = 2.4, lwd = 2)
      text(d$y_eq + 3, d$r_eq + 0.8, "Equilibrio Macroeconómico", font = 2)
      grid()
      legend("topright", legend = c("Mercado de Bienes (IS)", "Mercado de Dinero (LM)"),
             col = c("#c0392b", "#2980b9"), lwd = 3, bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Equilibrio Conjunto IS-LM:"),
        tags$p(sprintf("El producto real de equilibrio se sitúa en Y = %.1f y la tasa de interés de equilibrio en r = %.2f%%, donde simultáneamente la inversión iguala al ahorro y la oferta monetaria iguala a la demanda de liquidez.",
                       d$y_eq, d$r_eq))
      )
    })`,
    explanation: `
    <p>John Hicks tradujo la densa 'Teoría General' de Keynes a la síntesis gráfica del modelo IS-LM en 1937. Kenneth Arrow demostró matemáticamente los Teoremas Fundamentales del Bienestar y formuló el Teorema de Imposibilidad de Arrow, probando que no existe ningún sistema democrático de votación perfecto.</p>
    <p><strong>Contribución Nobel 1972:</strong> John Hicks y Kenneth Arrow transformaron la teoría del equilibrio general y la economía del bienestar.</p>`
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
