// scripts/generar_shiny_2014_2000.mjs
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

const apps = {
  "2014_tirole": {
    title: "2014 · Plataformas bilaterales y regulación de mercados",
    sidebar: `
    sliderInput("red_externa", "Intensidad del efecto de red cruzado", min = 0.1, max = 0.9, value = 0.6, step = 0.05),
    sliderInput("costo_marg", "Costo marginal por transacción", min = 0.0, max = 2.0, value = 0.5, step = 0.1),
    sliderInput("elasticidad_usuario", "Sensibilidad al precio de los usuarios", min = 0.5, max = 3.0, value = 1.8, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Rochet & Tirole (2003, 2006): en plataformas de dos lados (tarjetas, apps), un lado suele ser subsidiado para atraer al otro.")`,
    resets: `updateSliderInput(session, "red_externa", value = 0.6)
    updateSliderInput(session, "costo_marg", value = 0.5)
    updateSliderInput(session, "elasticidad_usuario", value = 1.8)`,
    serverLogic: `
    datos <- reactive({
      d_red <- input$red_externa
      c_m <- input$costo_marg
      el_u <- input$elasticidad_usuario
      
      # Precios optimos bilaterales (comercio vs usuario)
      p_usuario <- max(-0.2, (c_m / 2) - d_red * 1.2) # Puede ser negativo o cero (subsidio)
      p_comercio <- (c_m / 2) + d_red * 1.5 + (1 / el_u)
      
      # Volumen de transacciones resultante
      volumen <- max(10, 100 * (1 - p_comercio * 0.25) * (1 - p_usuario * 0.4 + d_red * 0.8))
      beneficio <- volumen * (p_usuario + p_comercio - c_m)
      
      list(p_u = p_usuario, p_c = p_comercio, vol = volumen, ben = beneficio)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      precios <- c(d$p_u, d$p_c)
      bp <- barplot(precios, names.arg = c("Lado Usuario (Consumidor)", "Lado Comercio (Vendedor)"),
                    col = c("#3498db", "#e67e22"),
                    ylab = "Precio cobrado por transacción ($)",
                    ylim = c(min(-0.5, d$p_u - 0.2), max(2.5, d$p_c + 0.5)),
                    main = "Estructura Asimétrica de Precios (Rochet-Tirole)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      text(bp, precios + ifelse(precios >= 0, 0.15, -0.15), sprintf("$%.2f", precios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diagnóstico de la plataforma bilateral:"),
        tags$p(sprintf("Precio al usuario: $%.2f | Precio al comercio: $%.2f. %s Volumen proyectado: %.0f mil transacciones.",
                       d$p_u, d$p_c,
                       ifelse(d$p_u <= 0, "El lado del consumidor opera subsidiado para resolver el dilema del huevo y la gallina.", "Ambos lados pagan tarifas positivas."),
                       d$vol))
      )
    })`,
    explanation: `
    <p>Jean Tirole demostró que las reglas antimonopolio tradicionales fallan en mercados bilaterales (como tarjetas de pago, motores de búsqueda o sistemas operativos): cobrar precios por debajo del costo en un lado no es práctica predatoria, sino el mecanismo óptimo para maximizar las externalidades cruzadas.</p>
    <p><strong>Contribución Nobel 2014:</strong> Jean Tirole aclaró cómo regular industrias dominadas por pocas empresas gigantes con información asimétrica y plataformas multifacéticas.</p>`
  },

  "2013_fama_hansen_shiller": {
    title: "2013 · Precios de activos: Eficiencia (Fama) vs. Volatilidad (Shiller)",
    sidebar: `
    sliderInput("tasa_descuento", "Tasa de descuento esperada (r)", min = 0.03, max = 0.10, value = 0.06, step = 0.01),
    sliderInput("psicologia_mercado", "Amplificación por exceso de optimismo/pánico", min = 0.5, max = 3.0, value = 1.8, step = 0.1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Fama (mercados eficientes), Hansen (método GMM) y Shiller (exceso de volatilidad y predictibilidad a largo plazo).")`,
    resets: `updateSliderInput(session, "tasa_descuento", value = 0.06)
    updateSliderInput(session, "psicologia_mercado", value = 1.8)`,
    serverLogic: `
    datos <- reactive({
      set.seed(2013)
      t_anios <- 1:40
      
      # Serie de dividendos (camino aleatorio con crecimiento)
      divs <- 2.0 * exp(0.02 * t_anios + cumsum(rnorm(40, 0, 0.03)))
      
      # Precio fundamental segun Fama (valor presente descontado perfecto p*)
      r <- input$tasa_descuento
      g <- 0.02
      p_fundamental <- divs / (r - g)
      
      # Precio observado de mercado segun Shiller (con olas de euforia/panico)
      ruido_shiller <- sin(t_anios / 3.5) * input$psicologia_mercado * 15
      p_mercado <- p_fundamental + ruido_shiller + rnorm(40, 0, 4)
      
      list(t = t_anios, p_fund = p_fundamental, p_mkt = p_mercado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$t, d$p_mkt, type = "l", col = "#c0392b", lwd = 2.5,
           ylim = c(min(d$p_mkt, d$p_fund) * 0.8, max(d$p_mkt, d$p_fund) * 1.2),
           xlab = "Horizonte temporal (años)", ylab = "Índice de precios accionarios ($)",
           main = "Prueba de Exceso de Volatilidad de Shiller (1981)")
      lines(d$t, d$p_fund, col = "#2980b9", lwd = 3, lty = 2)
      grid()
      legend("topleft", legend = c("Precio de Mercado Observado (Shiller)", "Valor Presente Fundamental (Fama p*)"),
             col = c("#c0392b", "#2980b9"), lwd = c(2.5, 3), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      vol_mkt <- sd(diff(log(d$p_mkt)))
      vol_fund <- sd(diff(log(d$p_fund)))
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Contraste empírico del mercado:"),
        tags$p(sprintf("Volatilidad de precios bursátiles: %.2f%% anual vs. Volatilidad de fundamentales de dividendos: %.2f%% anual. La volatilidad observada supera en %.1fx al fundamento económico, confirmando la tesis de Shiller.",
                       vol_mkt * 100, vol_fund * 100, vol_mkt / vol_fund))
      )
    })`,
    explanation: `
    <p>Eugene Fama demostró que a corto plazo los precios bursátiles son casi imposibles de predecir porque incorporan inmediatamente la información disponible. Robert Shiller demostró que a plazos largos (5-10 años) los precios sufren de exceso de volatilidad y pueden predecirse mediante métricas como el ratio CAPE.</p>
    <p><strong>Contribución Nobel 2013:</strong> Eugene Fama, Lars Peter Hansen y Robert Shiller construyeron la base moderna de la valoración empírica de activos financieros.</p>`
  },

  "2012_roth_shapley": {
    title: "2012 · Emparejamiento estable y diseño de mercados (Gale-Shapley)",
    sidebar: `
    sliderInput("n_agentes", "Número de participantes por lado (médicos / hospitales)", min = 3, max = 8, value = 4, step = 1),
    selectInput("proponente", "Lado que propone emparejamiento:", choices = c("Médicos / Postulantes", "Hospitales / Colegios")),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gale & Shapley (1962) y Alvin Roth: algoritmo de aceptación diferida para crear mercados estables sin dinero.")`,
    resets: `updateSliderInput(session, "n_agentes", value = 4)
    updateSelectInput(session, "proponente", selected = "Médicos / Postulantes")`,
    serverLogic: `
    datos <- reactive({
      n <- input$n_agentes
      # Calidad de emparejamiento (ranking promedio obtenido)
      # Quien propone obtiene su emparejamiento optimo estable
      if (input$proponente == "Médicos / Postulantes") {
        rank_medicos <- 1.2 + 0.1 * n
        rank_hospitales <- 2.2 + 0.2 * n
      } else {
        rank_medicos <- 2.3 + 0.2 * n
        rank_hospitales <- 1.2 + 0.1 * n
      }
      
      list(n = n, rm = rank_medicos, rh = rank_hospitales)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      ranks <- c(d$rm, d$rh)
      bp <- barplot(ranks, names.arg = c("Preferencia Médicos", "Preferencia Hospitales"),
                    col = c("#27ae60", "#2980b9"),
                    ylab = "Posición promedio asignada en ranking (1 = preferido)",
                    ylim = c(0, d$n + 1),
                    main = "Propiedad Óptima del Proponente en Gale-Shapley")
      text(bp, ranks + 0.3, sprintf("%.2f", ranks), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estabilidad del emparejamiento:"),
        tags$p(sprintf("El algoritmo garantiza que no exista ningún par bloqueador (ningún médico y hospital preferirían estar juntos antes que con sus asignaciones actuales). El lado proponente ('%s') alcanza su mejor emparejamiento estable posible.",
                       input$proponente))
      )
    })`,
    explanation: `
    <p>Lloyd Shapley desarrolló el algoritmo teórico de aceptación diferida que garantiza la existencia de asignaciones estables. Alvin Roth aplicó esta teoría para rediseñar la asignación de médicos residentes en EE. UU., el sistema de colegios públicos de Nueva York y el programa de intercambio de donantes de riñón.</p>
    <p><strong>Contribución Nobel 2012:</strong> Alvin Roth y Lloyd Shapley resolvieron fallos graves de mercado en asignaciones bilaterales donde no es ético o viable utilizar precios monetarios.</p>`
  },

  "2011_sargent_sims": {
    title: "2011 · Causa y efecto en macroeconomía (SVAR y Expectativas)",
    sidebar: `
    sliderInput("shock_tasa", "Magnitud del shock en tasa de interés (pb)", min = 25, max = 300, value = 100, step = 25),
    sliderInput("persistencia", "Inercia de la política monetaria", min = 0.3, max = 0.9, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Christopher Sims (vectores autorregresivos SVAR) y Thomas Sargent (expectativas racionales y política económica).")`,
    resets: `updateSliderInput(session, "shock_tasa", value = 100)
    updateSliderInput(session, "persistencia", value = 0.7)`,
    serverLogic: `
    datos <- reactive({
      h <- 0:20 # Trimestres tras el shock
      shock <- input$shock_tasa / 100
      rho <- input$persistencia
      
      # Trayectoria tasa de interes
      irf_tasa <- shock * (rho^h)
      # Respuesta del PIB (cae y se recupera con joroba)
      irf_pib <- -0.45 * shock * (h * exp(-h / 3.0))
      # Respuesta de inflacion
      irf_inf <- -0.25 * shock * (h * exp(-h / 4.0))
      
      list(h = h, tasa = irf_tasa, pib = irf_pib, inf = irf_inf)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Panel 1: Tasa
      plot(d$h, d$tasa, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Trimestres tras el shock", ylab = "Variación de tasa de interés (pp)",
           main = "Shock de Política Monetaria")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()

      # Panel 2: Respuesta PIB e Inflacion
      plot(d$h, d$pib, type = "l", col = "#c0392b", lwd = 3,
           ylim = c(min(d$pib, d$inf) * 1.2, 0.2),
           xlab = "Trimestres tras el shock", ylab = "Variación porcentual (%)",
           main = "Función Impulso-Respuesta (IRF)")
      lines(d$h, d$inf, col = "#e67e22", lwd = 2.5, lty = 2)
      abline(h = 0, lty = 2, col = "#7f8c8d")
      grid()
      legend("bottomright", legend = c("Brecha de PIB", "Inflación"),
             col = c("#c0392b", "#e67e22"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Transmisión del shock monetario:"),
        tags$p(sprintf("Una subida sorpresiva de %d pb enfría la actividad económica alcanzando una caída máxima de %.2f%% en el PIB hacia el trimestre %d, con moderación gradual de la inflación.",
                       input$shock_tasa, abs(min(d$pib)), which.min(d$pib) - 1))
      )
    })`,
    explanation: `
    <p>Christopher Sims introdujo los modelos de Vectores Autorregresivos (VAR) para analizar la causalidad macroeconómica sin imponer restricciones teóricas arbitrarias. Thomas Sargent exploró cómo las expectativas racionales condicionan el éxito de las políticas fiscales y monetarias.</p>
    <p><strong>Contribución Nobel 2011:</strong> Thomas Sargent y Christopher Sims diseñaron las herramientas estándar con las que todos los bancos centrales del mundo evalúan hoy el impacto de sus decisiones.</p>`
  },

  "2010_diamond_mortensen_pissarides": {
    title: "2010 · Fricciones de búsqueda y desempleo (Modelo DMP)",
    sidebar: `
    sliderInput("costo_vacante", "Costo de mantener una vacante abierta (c)", min = 0.1, max = 0.8, value = 0.35, step = 0.05),
    sliderInput("productividad", "Productividad del trabajador (p)", min = 0.8, max = 2.0, value = 1.2, step = 0.1),
    sliderInput("tasa_destruccion", "Tasa de separación laboral (s)", min = 0.01, max = 0.08, value = 0.03, step = 0.005),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Diamond, Mortensen & Pissarides: en presencia de costos de emparejamiento coexisten desempleo y vacantes desiertas.")`,
    resets: `updateSliderInput(session, "costo_vacante", value = 0.35)
    updateSliderInput(session, "productividad", value = 1.2)
    updateSliderInput(session, "tasa_destruccion", value = 0.03)`,
    serverLogic: `
    datos <- reactive({
      c <- input$costo_vacante
      p <- input$productividad
      s <- input$tasa_destruccion
      
      # Tensión del mercado laboral theta = v / u
      # Ecuacion de creacion de empleo (JC): c / q(theta) = (p - w) / (r + s)
      # Con q(theta) = theta^(-0.5), w = 0.5 * p
      theta <- ((0.5 * p) / (c * (0.05 + s)))^2
      theta <- max(0.1, min(5.0, theta))
      
      # Tasa de desempleo de equilibrio Beveridge: u* = s / (s + f(theta))
      # con f(theta) = theta^0.5
      tasa_encuentro <- theta^0.5
      u_star <- s / (s + tasa_encuentro)
      v_star <- theta * u_star
      
      # Curva de Beveridge
      u_grid <- seq(0.02, 0.18, length.out = 100)
      v_beveridge <- (s * (1 - u_grid) / u_grid)^2 * 0.05
      
      list(theta = theta, u = u_star, v = v_star, u_grid = u_grid, v_bev = v_beveridge)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$u_grid * 100, d$v_bev * 100, type = "l", col = "#2980b9", lwd = 3,
           xlim = c(2, 18), ylim = c(0, 15),
           xlab = "Tasa de Desempleo (%)", ylab = "Tasa de Vacantes (%)",
           main = "Curva de Beveridge y Equilibrio DMP")
      points(d$u * 100, d$v * 100, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$u * 100 + 0.6, d$v * 100 + 0.6, "Equilibrio u*", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Equilibrio del Mercado de Trabajo:"),
        tags$p(sprintf("Tasa natural de desempleo de fricción: %.1f%% | Tasa de vacantes: %.1f%% | Tensión del mercado (vacantes/desempleados): %.2f.",
                       d$u * 100, d$v * 100, d$theta))
      )
    })`,
    explanation: `
    <p>El modelo Diamond-Mortensen-Pissarides (DMP) explica por qué incluso en una economía próspera persisten trabajadores sin empleo y empresas con vacantes vacías: emparejar personas con puestos adecuados toma tiempo y consume recursos reales.</p>
    <p><strong>Contribución Nobel 2010:</strong> Peter Diamond, Dale Mortensen y Christopher Pissarides crearon el marco analítico líder para evaluar seguros de desempleo y políticas activas de empleo.</p>`
  },

  "2009_ostrom_williamson": {
    title: "2009 · Gobernanza económica: Bienes comunes y límites de la empresa",
    sidebar: `
    sliderInput("usuarios", "Número de usuarios del recurso común", min = 10, max = 100, value = 30, step = 5),
    sliderInput("monitoreo", "Efectividad del monitoreo y sanciones comunitarias", min = 0, max = 1, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Elinor Ostrom (gobernanza de bienes comunes sin Estado ni privatización) y Oliver Williamson (costos de transacción).")`,
    resets: `updateSliderInput(session, "usuarios", value = 30)
    updateSliderInput(session, "monitoreo", value = 0.7)`,
    serverLogic: `
    datos <- reactive({
      n <- input$usuarios
      m <- input$monitoreo
      
      # Tragedia de los comunes clasica de Hardin vs cooperacion de Ostrom
      # Extraccion individual
      extraccion_hardin <- 100 / (1 + 0.02 * n)
      extraccion_ostrom <- 100 / (1 + 0.02 * n * (1 - m * 0.85))
      
      biomasa_hardin <- max(5, 1000 - n * extraccion_hardin * 0.4)
      biomasa_ostrom <- max(5, 1000 - n * extraccion_ostrom * 0.4)
      
      list(n = n, eh = extraccion_hardin, eo = extraccion_ostrom,
           bh = biomasa_hardin, bo = biomasa_ostrom)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      biomasas <- c(d$bh, d$bo)
      bp <- barplot(biomasas, names.arg = c("Tragedia de Comunes (Hardin)", "Gobernanza Comunitaria (Ostrom)"),
                    col = c("#c0392b", "#27ae60"),
                    ylab = "Stock sostenible del recurso biológico",
                    ylim = c(0, 1100),
                    main = "Sostenibilidad de Recursos de Uso Común")
      text(bp, biomasas + 40, sprintf("%.0f uds", biomasas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultados de la Gobernanza de Ostrom:"),
        tags$p(sprintf("Con monitoreo comunitario (efectividad = %.0f%%), el stock del recurso protegido es de %.0f unidades frente a solo %.0f bajo la tragedia clásica de sobreexplotación.",
                       input$monitoreo * 100, d$bo, d$bh))
      )
    })`,
    explanation: `
    <p>Elinor Ostrom desafió la creencia arraigada de que los recursos comunes (pesquerías, bosques, cuencas de agua) solo podían salvarse mediante privatización o estatización, demostrando con cientos de casos de campo que las comunidades locales crean reglas de autogobierno estables y duraderas.</p>
    <p><strong>Contribución Nobel 2009:</strong> Elinor Ostrom y Oliver Williamson demostraron que la gobernanza económica institucional trasciende la dicotomía simplista entre mercados anónimos y jerarquías estatales.</p>`
  },

  "2008_krugman": {
    title: "2008 · Nueva geografía económica y aglomeración industrial",
    sidebar: `
    sliderInput("costo_transporte", "Costo de transporte de comercio (tau)", min = 1.05, max = 2.50, value = 1.40, step = 0.05),
    sliderInput("rendimientos_escala", "Economías de escala industriales (sigma)", min = 2.0, max = 7.0, value = 4.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Paul Krugman (1991): la interacción entre rendimientos crecientes y costos de transporte genera aglomeración centro-periferia.")`,
    resets: `updateSliderInput(session, "costo_transporte", value = 1.40)
    updateSliderInput(session, "rendimientos_escala", value = 4.0)`,
    serverLogic: `
    datos <- reactive({
      tau <- input$costo_transporte
      sig <- input$rendimientos_escala
      
      # Indice de concentracion geografica (proporcion industrial en el Centro)
      # Con costos de transporte muy altos -> dispersion; con costos moderados -> aglomeracion
      concentracion <- ifelse(tau > 2.0, 0.5,
                              0.5 + 0.45 * (1 - (tau - 1.05) / 0.95)^(sig / 3.0))
      concentracion <- max(0.5, min(0.95, concentracion))
      
      list(c_centro = concentracion, c_periferia = 1 - concentracion)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      partes <- c(d$c_centro, d$c_periferia) * 100
      bp <- barplot(partes, names.arg = c("Región Central (Aglomeración)", "Región Periférica"),
                    col = c("#2980b9", "#bdc3c7"),
                    ylab = "Participación de la industria manufacturera (%)",
                    ylim = c(0, 100),
                    main = "Distribución Geográfica Centro-Periferia (Krugman)")
      text(bp, partes + 3, sprintf("%.1f%%", partes), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Patrón espacial emergente:"),
        tags$p(sprintf("Con costos de transporte tau = %.2f, la región centro concentra el %.1f%% de las fábricas. %s",
                       input$costo_transporte, d$c_centro * 100,
                       ifelse(d$c_centro > 0.65, "Se consolida un equilibrio centro-periferia con fuerte aglomeración industrial.", "La industria permanece dispersa regionalmente.")))
      )
    })`,
    explanation: `
    <p>Paul Krugman formuló la Nueva Teoría del Comercio y la Nueva Geografía Económica, explicando por qué países con dotaciones similares comercian masivamente entre sí (comercio intraindustrial) y cómo surgen núcleos urbanos gigantes como Silicon Valley.</p>
    <p><strong>Contribución Nobel 2008:</strong> Paul Krugman integró la competencia monopolística de Dixit-Stiglitz con los costos de transporte para modelar la localización de la actividad económica en el espacio.</p>`
  },

  "2007_hurwicz_maskin_myerson": {
    title: "2007 · Diseño de mecanismos y subastas óptimas (Myerson)",
    sidebar: `
    sliderInput("valor_esperado", "Valor promedio esperado del postor ($)", min = 40, max = 150, value = 100, step = 5),
    sliderInput("dispersion", "Dispersión de valoraciones privadas ($)", min = 10, max = 50, value = 30, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Hurwicz, Maskin y Myerson: teoría de diseño de mecanismos y principio de revelación para diseñar reglas óptimas.")`,
    resets: `updateSliderInput(session, "valor_esperado", value = 100)
    updateSliderInput(session, "dispersion", value = 30)`,
    serverLogic: `
    datos <- reactive({
      v_bar <- input$valor_esperado
      sigma <- input$dispersion
      
      # Ingreso virtual de Myerson: J(v) = v - (1 - F(v))/f(v)
      # Para distribucion uniforme U[v_min, v_max]:
      v_min <- max(0, v_bar - sigma)
      v_max <- v_bar + sigma
      
      # J(v) = 2*v - v_max
      # Precio de reserva optimo donde J(r*) = 0  => r* = v_max / 2
      r_star <- v_max / 2
      
      v_grid <- seq(v_min, v_max, length.out = 100)
      J_grid <- 2 * v_grid - v_max
      
      list(v_min = v_min, v_max = v_max, r = r_star, vg = v_grid, Jg = J_grid)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$vg, d$Jg, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Valoración privada del comprador (v)", ylab = "Ingreso virtual de Myerson J(v)",
           main = "Ingreso Virtual y Precio de Reserva Óptimo")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = d$r, lty = 3, col = "#e74c3c", lwd = 2)
      text(d$r + 1, -10, sprintf("Precio Reserva r* = $%.1f", d$r), col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diseño óptimo de la subasta:"),
        tags$p(sprintf("Para compradores con valoraciones entre $%d y $%d, el vendedor maximiza su recaudación fijando un precio de reserva estricto de $%.1f, aunque eso implique el riesgo de que el bien quede sin vender.",
                       d$v_min, d$v_max, d$r))
      )
    })`,
    explanation: `
    <p>Leonid Hurwicz concibió la teoría de diseño de mecanismos preguntándose qué reglas e incentivos permiten alcanzar objetivos sociales cuando la información está dispersa. Eric Maskin desarrolló la teoría de implementación y Roger Myerson derivó la forma de la subasta óptima con información privada.</p>
    <p><strong>Contribución Nobel 2007:</strong> Sentaron las bases de la ingeniería económica para subastas de telecomunicaciones, asignación de emisiones y regulación pública.</p>`
  },

  "2006_phelps": {
    title: "2006 · Curva de Phillips con expectativas y Regla de Oro",
    sidebar: `
    sliderInput("inflacion_esperada", "Inflación esperada por trabajadores (pi^e %)", min = 1, max = 10, value = 3, step = 0.5),
    sliderInput("u_natural", "Tasa natural de desempleo NAIRU (%)", min = 3.5, max = 8.0, value = 5.0, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Edmund Phelps (1968): a largo plazo no existe compensación entre inflación y desempleo; las expectativas anulan el trade-off.")`,
    resets: `updateSliderInput(session, "inflacion_esperada", value = 3)
    updateSliderInput(session, "u_natural", value = 5.0)`,
    serverLogic: `
    datos <- reactive({
      pie <- input$inflacion_esperada
      un <- input$u_natural
      
      u_seq <- seq(2.5, 9.5, length.out = 100)
      # Curva de Phillips de corto plazo: pi = pi^e - beta * (u - u_n)
      pi_cp <- pie - 1.2 * (u_seq - un)
      
      list(u = u_seq, pi = pi_cp, un = un, pie = pie)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$u, d$pi, type = "l", col = "#2980b9", lwd = 3,
           xlim = c(2.5, 9.5), ylim = c(-1, 12),
           xlab = "Tasa de Desempleo (%)", ylab = "Tasa de Inflación (%)",
           main = "Curva de Phillips Aumentada por Expectativas (Phelps)")
      # Curva de largo plazo vertical en u_natural
      abline(v = d$un, col = "#c0392b", lwd = 2.5, lty = 2)
      points(d$un, d$pie, pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
      legend("topright", legend = c("Corto plazo (Expectativa fija)", "Largo plazo vertical (NAIRU)"),
             col = c("#2980b9", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Postulado de Phelps:"),
        tags$p(sprintf("Cualquier intento de reducir el desempleo por debajo de su tasa natural (%.1f%%) sólo produce inflación no anticipada temporalmente. Cuando las expectativas se ajustan a %.1f%%, el desempleo regresa íntegramente a su equilibrio estructural.",
                       d$un, d$pie))
      )
    })`,
    explanation: `
    <p>Antes de Phelps y Friedman, la macroeconomía creía erróneamente que los gobiernos podían comprar menos desempleo tolerando permanentemente un poco más de inflación.</p>
    <p><strong>Contribución Nobel 2006:</strong> Edmund Phelps demostró que las expectativas intertemporales anulan la curva de Phillips a largo plazo y formuló la célebre Regla de Oro de acumulación de capital para el consumo intergeneracional óptimo.</p>`
  },

  "2005_aumann_schelling": {
    title: "2005 · Segregación emergente (Schelling) y cooperación (Aumann)",
    sidebar: `
    sliderInput("tolerancia", "Tolerancia mínima de vecinos del mismo grupo (%)", min = 20, max = 80, value = 33, step = 5),
    sliderInput("densidad", "Ocupación del vecindario (%)", min = 60, max = 95, value = 80, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Thomas Schelling (1971): micromotivos con tolerancias moderadas generan macroniveles extremos de segregación espacial.")`,
    resets: `updateSliderInput(session, "tolerancia", value = 33)
    updateSliderInput(session, "densidad", value = 80)`,
    serverLogic: `
    datos <- reactive({
      tol <- input$tolerancia
      # Indice de segregacion final alcanzado en equilibrio
      seg_final <- min(98, tol * 1.5 + 20)
      list(tol = tol, seg = seg_final)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      tolerancias <- seq(20, 80, by = 5)
      seg_curva <- pmin(98, tolerancias * 1.5 + 20)
      
      plot(tolerancias, seg_curva, type = "b", pch = 19, col = "#8e44ad", lwd = 2.5,
           xlab = "Preferencia individual de similitud mínima (%)",
           ylab = "Segregación resultante a nivel de vecindario (%)",
           ylim = c(30, 100), main = "Efecto Macro de Micromotivos (Modelo de Schelling)")
      points(d$tol, d$seg, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Paradoja de Schelling:"),
        tags$p(sprintf("Aun cuando las personas toleran tener hasta un %.0f%% de vecinos distintos, las reubicaciones individuales encadenadas producen un vecindario segregado al %.0f%%, sin que ningún agente lo haya deseado explícitamente.",
                       100 - d$tol, d$seg))
      )
    })`,
    explanation: `
    <p>Thomas Schelling modeló cómo pequeñas preferencias individuales pueden coordinar dinámicas colectivas dramáticas (segregación urbana o desarme nuclear). Robert Aumann amplió la teoría de juegos con el concepto de equilibrios correlacionados y juegos repetidos infinitos.</p>
    <p><strong>Contribución Nobel 2005:</strong> Robert Aumann y Thomas Schelling profundizaron el entendimiento del conflicto y la cooperación mediante la teoría de juegos interactiva.</p>`
  },

  "2004_kydland_prescott": {
    title: "2004 · Inconsistencia temporal (Reglas vs. Discreción) y RBC",
    sidebar: `
    sliderInput("peso_inflacion", "Preocupación del Banco Central por la inflación (gamma)", min = 0.5, max = 4.0, value = 1.5, step = 0.25),
    sliderInput("meta_empleo", "Meta de empleo por encima del nivel natural (k)", min = 0.0, max = 2.0, value = 0.8, step = 0.1),
    checkboxInput("politica_reglas", "Adoptar Regla Creíble (Compromiso vinculante)", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Kydland & Prescott (1977): los bancos centrales discrecionales sufren de sesgo inflacionario sin ganar empleo adicional.")`,
    resets: `updateSliderInput(session, "peso_inflacion", value = 1.5)
    updateSliderInput(session, "meta_empleo", value = 0.8)
    updateCheckboxInput(session, "politica_reglas", value = FALSE)`,
    serverLogic: `
    datos <- reactive({
      gamma <- input$peso_inflacion
      k <- input$meta_empleo
      
      if (input$politica_reglas) {
        # Regla creible: inflacion cero o meta exacta
        pi_eq <- 0.0
      } else {
        # Politica discrecional de Barro-Gordon / Kydland-Prescott: sesgo inflacionario
        pi_eq <- k / gamma
      }
      
      list(pi = pi_eq, k = k, gamma = gamma)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      inflaciones <- c(0.0, d$k / d$gamma)
      bp <- barplot(inflaciones, names.arg = c("Bajo Reglas con Compromiso", "Bajo Discrecionalidad Libre"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Tasa de Inflación de Equilibrio (%)",
                    ylim = c(0, max(2.5, d$pi + 0.8)),
                    main = "El Sesgo Inflacionario de Kydland-Prescott")
      text(bp, inflaciones + 0.1, sprintf("%.2f%%", inflaciones), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (input$politica_reglas) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Compromiso y credibilidad institucional:"),
          " Al atarse las manos con una regla clara o un banco central independiente, se elimina por completo el sesgo inflacionario sin perder empleo real."
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Inconsistencia temporal en acción:"),
          sprintf(" La discrecionalidad genera una inflación innecesaria del %.2f%%. El público anticipa el incentivo a devaluar, neutralizando cualquier ganancia sobre el empleo.", d$pi)
        )
      }
    })`,
    explanation: `
    <p>Finn Kydland y Edward Prescott demostraron que las políticas óptimas planificadas para hoy dejan de serlo mañana: si un banco central tiene discreción, siempre tendrá incentivos para generar inflación sorpresa para reactivar la economía, pero el público lo anticipa y la inflación se vuelve endémica.</p>
    <p><strong>Contribución Nobel 2004:</strong> Transformaron la macroeconomía al fundamentar la independencia de los bancos centrales y la teoría de los ciclos económicos reales (RBC) impulsados por productividad.</p>`
  },

  "2003_engle_granger": {
    title: "2003 · Volatilidad financiera (ARCH) y Cointegración",
    sidebar: `
    sliderInput("alpha_arch", "Persistencia de choques de volatilidad (alfa ARCH)", min = 0.1, max = 0.9, value = 0.65, step = 0.05),
    sliderInput("omega", "Varianza base incondicional (omega)", min = 0.05, max = 0.50, value = 0.15, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Engle (modelos ARCH de volatilidad cambiante en finanzas) y Clive Granger (análisis de cointegración).")`,
    resets: `updateSliderInput(session, "alpha_arch", value = 0.65)
    updateSliderInput(session, "omega", value = 0.15)`,
    serverLogic: `
    datos <- reactive({
      set.seed(2003)
      n <- 200
      omega <- input$omega
      alpha <- input$alpha_arch
      
      eps <- numeric(n)
      sigma2 <- numeric(n)
      sigma2[1] <- omega / (1 - alpha)
      eps[1] <- rnorm(1, 0, sqrt(sigma2[1]))
      
      for (t in 2:n) {
        sigma2[t] <- omega + alpha * (eps[t - 1]^2)
        eps[t] <- rnorm(1, 0, sqrt(sigma2[t]))
      }
      
      list(t = 1:n, ret = eps, sig = sqrt(sigma2))
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Retornos con agrupamiento de volatilidad
      plot(d$t, d$ret, type = "l", col = "#2c3e50", lwd = 1.2,
           xlab = "Días de negociación", ylab = "Rendimiento bursátil diario (%)",
           main = "Rendimientos Financieros con Clústeres")
      grid()

      # Volatilidad condicional estimada
      plot(d$t, d$sig, type = "l", col = "#c0392b", lwd = 2,
           xlab = "Días de negociación", ylab = "Volatilidad condicional (sigma_t)",
           main = "Proceso ARCH(1) de Engle")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Detección de heterocedasticidad condicional:"),
        tags$p(sprintf("Con alfa = %.2f, los periodos de turbulencia bursátil se retroalimentan y agrupan en el tiempo, permitiendo medir el riesgo financiero y calcular métricas como el Value at Risk (VaR).",
                       input$alpha_arch))
      )
    })`,
    explanation: `
    <p>Robert Engle descubrió que en los mercados financieros la volatilidad no es constante: días de grandes oscilaciones son seguidos por más oscilaciones (volatility clustering). Clive Granger resolvió la trampa de la regresión espuria demostrando cómo analizar series no estacionarias que comparten tendencias comunes (cointegración).</p>
    <p><strong>Contribución Nobel 2003:</strong> Robert Engle y Clive Granger revolucionaron la econometría de series temporales y la gestión moderna del riesgo financiero.</p>`
  },

  "2002_kahneman_smith": {
    title: "2002 · Teoría prospectiva y aversión a pérdidas (Kahneman & Tversky)",
    sidebar: `
    sliderInput("lambda", "Coeficiente de aversión a las pérdidas (lambda)", min = 1.0, max = 3.5, value = 2.25, step = 0.25),
    sliderInput("alfa", "Sensibilidad decreciente al valor (alfa)", min = 0.5, max = 0.95, value = 0.88, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Daniel Kahneman (psicología del juicio y teoría prospectiva) y Vernon Smith (experimentos de laboratorio en economía).")`,
    resets: `updateSliderInput(session, "lambda", value = 2.25)
    updateSliderInput(session, "alfa", value = 0.88)`,
    serverLogic: `
    datos <- reactive({
      lam <- input$lambda
      a <- input$alfa
      
      x <- seq(-100, 100, length.out = 200)
      # Funcion de valor en forma de S de Kahneman-Tversky:
      # v(x) = x^alfa si x >= 0;  -lambda * (-x)^alfa si x < 0
      v <- ifelse(x >= 0, x^a, -lam * ((-x)^a))
      
      list(x = x, v = v, lam = lam)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$x, d$v, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Ganancias o Pérdidas relativas al punto de referencia ($)",
           ylab = "Valor subjetivo / Utilidad psicológica v(x)",
           main = "Función de Valor Asimétrica (Teoría Prospectiva)")
      abline(h = 0, lty = 2, col = "#7f8c8d")
      abline(v = 0, lty = 2, col = "#7f8c8d")
      text(-50, -40, sprintf("Pendiente en pérdidas: %.2fx más empinada", d$lam), col = "#c0392b", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Psicología de la decisión económica:"),
        tags$p(sprintf("Con lambda = %.2f, el dolor psicológico de perder $100 es más del doble de intenso que la satisfacción de ganar esos mismos $100, explicando por qué las personas rechazan sistemáticamente apuestas justas.",
                       d$lam))
      )
    })`,
    explanation: `
    <p>Daniel Kahneman y Amos Tversky sustituyeron la teoría de la utilidad esperada por la Teoría Prospectiva: las decisiones se evalúan respecto a puntos de referencia subjetivos, con concavidad en las ganancias (aversión al riesgo) y convexidad pronunciada en las pérdidas (búsqueda de riesgo para evitar perder).</p>
    <p><strong>Contribución Nobel 2002:</strong> Daniel Kahneman integró la psicología cognitiva en la ciencia económica, mientras que Vernon Smith validó empíricamente el funcionamiento de los mercados en el laboratorio.</p>`
  },

  "2001_akerlof_spence_stiglitz": {
    title: "2001 · Información asimétrica y el mercado de 'limones' (Akerlof)",
    sidebar: `
    sliderInput("prop_buenos", "Proporción inicial de autos de buena calidad (%)", min = 20, max = 80, value = 50, step = 5),
    sliderInput("valor_bueno", "Valoración de un auto bueno ($)", min = 1500, max = 3500, value = 2500, step = 100),
    sliderInput("valor_malo", "Valoración de un 'limón' / chatarra ($)", min = 500, max = 1500, value = 1000, step = 100),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Akerlof (selección adversa y colapso de mercado), Spence (señalización) y Stiglitz (screening y crédito).")`,
    resets: `updateSliderInput(session, "prop_buenos", value = 50)
    updateSliderInput(session, "valor_bueno", value = 2500)
    updateSliderInput(session, "valor_malo", value = 1000)`,
    serverLogic: `
    datos <- reactive({
      q <- input$prop_buenos / 100
      v_b <- input$valor_bueno
      v_m <- input$valor_malo
      
      # Precio maximo que un comprador desinformado esta dispuesto a pagar
      p_esperado <- q * v_b + (1 - q) * v_m
      
      # Si el precio esperado es menor que el valor de reserva del vendedor de autos buenos (v_b * 0.9)
      # los vendedores de autos buenos se retiran del mercado (seleccion adversa extrema)
      reserva_buenos <- v_b * 0.95
      colapso <- p_esperado < reserva_buenos
      
      list(p_esp = p_esperado, res_b = reserva_buenos, colapso = colapso)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$p_esp, d$res_b)
      bp <- barplot(valores, names.arg = c("Precio de Oferta Promedio", "Precio Mínimo Vendedor Auto Bueno"),
                    col = c("#3498db", ifelse(d$colapso, "#c0392b", "#27ae60")),
                    ylab = "Dólares ($)",
                    ylim = c(0, max(valores) * 1.25),
                    main = "Selección Adversa en el Mercado de Autos Usados")
      text(bp, valores + 100, sprintf("$%.0f", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$colapso) {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Colapso del mercado por selección adversa:"),
          " El precio promedio ofrecido ($", sprintf("%.0f", d$p_esp), ") es inferior al precio exigido por los dueños de autos buenos ($", sprintf("%.0f", d$res_b), "). Los autos buenos abandonan el mercado, quedando únicamente autos defectuosos ('limones')."
        )
      } else {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Mercado viable:"),
          " La proporción de autos buenos es suficientemente alta para sostener el comercio voluntario."
        )
      }
    })`,
    explanation: `
    <p>George Akerlof demostró en 1970 que cuando los vendedores conocen la calidad del producto mejor que los compradores, los bienes de baja calidad expulsan a los de alta calidad hasta destruir el mercado por completo.</p>
    <p><strong>Contribución Nobel 2001:</strong> George Akerlof, Michael Spence y Joseph Stiglitz explicaron el papel crucial de la información asimétrica en mercados laborales, bancarios y de seguros.</p>`
  },

  "2000_heckman_mcfadden": {
    title: "2000 · Microeconometría: Corrección de Heckman y McFadden Logit",
    sidebar: `
    sliderInput("rho_seleccion", "Correlación de factores no observados (rho de Heckman)", min = -0.8, max = 0.8, value = 0.5, step = 0.1),
    sliderInput("tasa_participacion", "Tasa de participación laboral femenina (%)", min = 30, max = 80, value = 55, step = 5),
    checkboxInput("corregir_sesgo", "Aplicar Corrección en Dos Etapas de Heckman", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Heckman (sesgo de selección y razón inversa de Mills) y Daniel McFadden (modelos de elección discreta).")`,
    resets: `updateSliderInput(session, "rho_seleccion", value = 0.5)
    updateSliderInput(session, "tasa_participacion", value = 55)
    updateCheckboxInput(session, "corregir_sesgo", value = TRUE)`,
    serverLogic: `
    datos <- reactive({
      rho <- input$rho_seleccion
      part <- input$tasa_participacion / 100
      
      # Retorno real a la educacion (beta verdadero = 8.0%)
      beta_verdadero <- 8.0
      
      # Razon inversa de Mills promedio (lambda)
      z <- qnorm(part)
      lambda_mills <- dnorm(z) / part
      
      # Sesgo en estimacion MCO sin corregir: beta_ols = beta + sesgo
      sesgo_ols <- rho * 3.5 * lambda_mills * 0.4
      beta_ols <- beta_verdadero + sesgo_ols
      
      beta_estimado <- if (input$corregir_sesgo) beta_verdadero else beta_ols
      
      list(beta_v = beta_verdadero, beta_ols = beta_ols, beta_est = beta_estimado,
           lambda = lambda_mills, sesgo = sesgo_ols)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      betas <- c(d$beta_v, d$beta_ols, d$beta_est)
      bp <- barplot(betas, names.arg = c("Efecto Real Causal", "MCO Sesgado (Sin Corrección)", "Estimador Heckit (2 Etapas)"),
                    col = c("#7f8c8d", "#c0392b", "#27ae60"),
                    ylab = "Retorno salarial por año de educación (%)",
                    ylim = c(0, max(betas) * 1.3),
                    main = "Corrección de Sesgo de Selección de Heckman (1979)")
      text(bp, betas + 0.5, sprintf("%.2f%%", betas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Impacto del sesgo de selección muestral:"),
        tags$p(sprintf("Dado que solo observamos salarios de quienes deciden trabajar, el estimador tradicional de MCO se desvía en %+.2f puntos porcentuales (retorno aparente de %.2f%%). El método Heckit elimina este sesgo utilizando la razón inversa de Mills (lambda = %.2f).",
                       d$sesgo, d$beta_ols, d$lambda))
      )
    })`,
    explanation: `
    <p>James Heckman descubrió que analizar muestras no aleatorias (como los salarios de mujeres que optan por trabajar) equivale a un problema de variable omitida, diseñando el procedimiento bietápico de corrección 'Heckit'. Daniel McFadden formuló el modelo logit condicional que permite predecir elecciones discretas entre alternativas de transporte o consumo.</p>
    <p><strong>Contribución Nobel 2000:</strong> Desarrollaron las herramientas metodológicas fundamentales para el análisis cuantitativo de microdatos de individuos y empresas.</p>`
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
