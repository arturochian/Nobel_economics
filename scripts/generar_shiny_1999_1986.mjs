// scripts/generar_shiny_1999_1986.mjs
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const rootDir = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

const apps = {
  "1999_mundell": {
    title: "1999 · El Trilema Macroeconómico de Mundell-Fleming",
    sidebar: `
    selectInput("regimen", "Régimen cambiario:", choices = c("Tipo de cambio flotante", "Tipo de cambio fijo")),
    sliderInput("gasto_gob", "Estímulo de gasto público (G)", min = 0, max = 50, value = 20, step = 5),
    sliderInput("expansion_m", "Expansión monetaria (M)", min = 0, max = 50, value = 0, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Mundell: el trilema monetario demuestra que es imposible tener simultáneamente libre movilidad de capitales, tipo de cambio fijo y política monetaria autónoma.")`,
    resets: `updateSelectInput(session, "regimen", selected = "Tipo de cambio flotante")
    updateSliderInput(session, "gasto_gob", value = 20)
    updateSliderInput(session, "expansion_m", value = 0)`,
    serverLogic: `
    datos <- reactive({
      es_fijo <- input$regimen == "Tipo de cambio fijo"
      g <- input$gasto_gob
      m <- input$expansion_m
      
      # Bajo capital perfecto:
      # En cambio flotante: fiscal crowding-out total por apreciacion (efecto pib fiscal = 0), monetaria hiper-efectiva
      # En cambio fijo: monetaria inefectiva (pierde reservas), fiscal maxima efectividad
      if (es_fijo) {
        efecto_fiscal <- g * 1.5
        efecto_monetario <- 0.0 # Neutralizado por intervencion cambiaria
      } else {
        efecto_fiscal <- 0.0 # Crowding out cambiario
        efecto_monetario <- m * 1.8
      }
      pib_total <- 100 + efecto_fiscal + efecto_monetario
      
      list(es_fijo = es_fijo, ef_fisc = efecto_fiscal, ef_mon = efecto_monetario, pib = pib_total)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      efectos <- c(d$ef_fisc, d$ef_mon)
      bp <- barplot(efectos, names.arg = c("Impacto Política Fiscal (G)", "Impacto Política Monetaria (M)"),
                    col = c("#3498db", "#e67e22"),
                    ylab = "Efecto neto en el PIB real ($)",
                    ylim = c(0, max(50, efectos + 10)),
                    main = paste("Efectividad de Políticas bajo", input$regimen))
      text(bp, efectos + 2, sprintf("+%.1f", efectos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Lección del Modelo Mundell-Fleming:"),
        tags$p(sprintf("Bajo %s: %s",
                       tolower(input$regimen),
                       ifelse(d$es_fijo,
                              "La política fiscal es sumamente potente porque el banco central debe acomodar la oferta monetaria para sostener la paridad cambiaria. La política monetaria pierde toda autonomía.",
                              "La política fiscal es completamente ineficaz debido a la apreciación del tipo de cambio que expulsa exportaciones netas. La política monetaria es la herramienta más potente para expandir el producto.")))
      )
    })`,
    explanation: `
    <p>Robert Mundell integró el comercio internacional y los flujos financieros en el modelo IS-LM keynesiano, dando origen al modelo Mundell-Fleming y a la teoría de las áreas monetarias óptimas que inspiró la creación del Euro.</p>
    <p><strong>Contribución Nobel 1999:</strong> Robert Mundell sentó los fundamentos teóricos del trilema de la economía abierta que guía la arquitectura financiera global actual.</p>`
  },

  "1998_sen": {
    title: "1998 · Bienestar, Hambrunas y Enfoque de Capacidades (Sen)",
    sidebar: `
    sliderInput("gini", "Desigualdad en la distribución del ingreso (Gini)", min = 0.20, max = 0.65, value = 0.40, step = 0.05),
    sliderInput("ingreso_medio", "Ingreso per cápita medio ($)", min = 500, max = 5000, value = 2000, step = 100),
    sliderInput("linea_pobreza", "Línea de pobreza extrema ($)", min = 400, max = 1500, value = 800, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Amartya Sen: la pobreza no es solo falta de dinero sino privación de capacidades básicas; las hambrunas ocurren por colapso de titularidades, no por falta de alimentos.")`,
    resets: `updateSliderInput(session, "gini", value = 0.40)
    updateSliderInput(session, "ingreso_medio", value = 2000)
    updateSliderInput(session, "linea_pobreza", value = 800)`,
    serverLogic: `
    datos <- reactive({
      y_bar <- input$ingreso_medio
      g <- input$gini
      z <- input$linea_pobreza
      
      # Indice de bienestar de Sen: W = y_bar * (1 - Gini)
      w_sen <- y_bar * (1 - g)
      
      # Simulacion lognormal de distribucion del ingreso
      sigma <- sqrt(2) * qnorm((g + 1) / 2)
      mu <- log(y_bar) - 0.5 * sigma^2
      
      # Tasa de pobreza (Headcount H)
      H <- pnorm((log(z) - mu) / sigma)
      
      list(w = w_sen, H = H, y_bar = y_bar, g = g, z = z)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mfrow = c(1, 2), mar = c(4.5, 4.5, 2.5, 1.5))
      
      # Comparacion Ingreso vs Bienestar Sen
      bp <- barplot(c(d$y_bar, d$w), names.arg = c("PIB per cápita medio", "Índice de Bienestar de Sen"),
                    col = c("#bdc3c7", "#27ae60"),
                    ylab = "Dólares ($)", ylim = c(0, d$y_bar * 1.25),
                    main = "Bienestar Corregido por Desigualdad")
      text(bp, c(d$y_bar, d$w) + 100, sprintf("$%.0f", c(d$y_bar, d$w)), font = 2)
      grid(nx = NA, ny = NULL)

      # Tasa de pobreza headcount
      bp2 <- barplot(d$H * 100, names.arg = c("Población bajo Línea de Pobreza"),
                     col = "#c0392b", ylab = "% de la población", ylim = c(0, 100),
                     main = "Tasa de Incidencia (H)")
      text(bp2, d$H * 100 + 4, sprintf("%.1f%%", d$H * 100), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Evaluación de Bienestar Social:"),
        tags$p(sprintf("El ingreso medio de $%.0f se reduce a un bienestar social efectivo de $%.0f tras descontar la penalización por desigualdad (Gini = %.2f). La tasa de pobreza extrema alcanza el %.1f%%.",
                       d$y_bar, d$w, d$g, d$H * 100))
      )
    })`,
    explanation: `
    <p>Amartya Sen demostró que medir el desarrollo exclusivamente por el PIB per cápita es ciego ante la equidad y la libertad real de las personas. En su célebre estudio sobre la Gran Hambruna de Bengala de 1943, demostró que la comida no había escaseado: la gente murió porque sus 'titularidades de intercambio' colapsaron frente a la inflación salarial.</p>
    <p><strong>Contribución Nobel 1998:</strong> Amartya Sen fundó la economía del desarrollo moderna, el Índice de Desarrollo Humano (IDH) del PNUD y el enfoque ético de capacidades.</p>`
  },

  "1997_merton_scholes": {
    title: "1997 · Valoración de Opciones Financieras (Black-Scholes-Merton)",
    sidebar: `
    sliderInput("S0", "Precio del activo subyacente ($)", min = 50, max = 150, value = 100, step = 5),
    sliderInput("K", "Precio de ejercicio / strike ($)", min = 50, max = 150, value = 100, step = 5),
    sliderInput("vol", "Volatilidad anual implícita (sigma %)", min = 10, max = 80, value = 25, step = 5),
    sliderInput("t_meses", "Tiempo hasta vencimiento (meses)", min = 1, max = 24, value = 6, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Fischer Black, Myron Scholes y Robert C. Merton: valoración exacta mediante cartera de réplica libre de arbitraje.")`,
    resets: `updateSliderInput(session, "S0", value = 100)
    updateSliderInput(session, "K", value = 100)
    updateSliderInput(session, "vol", value = 25)
    updateSliderInput(session, "t_meses", value = 6)`,
    serverLogic: `
    datos <- reactive({
      S <- input$S0
      K <- input$K
      sigma <- input$vol / 100
      T_anios <- input$t_meses / 12
      r <- 0.05 # Tasa libre de riesgo
      
      d1 <- (log(S / K) + (r + 0.5 * sigma^2) * T_anios) / (sigma * sqrt(T_anios))
      d2 <- d1 - sigma * sqrt(T_anios)
      
      # Precios Black-Scholes
      call <- S * pnorm(d1) - K * exp(-r * T_anios) * pnorm(d2)
      put <- K * exp(-r * T_anios) * pnorm(-d2) - S * pnorm(-d1)
      delta_call <- pnorm(d1)
      
      list(call = call, put = put, delta = delta_call, d1 = d1, d2 = d2)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      precios <- c(d$call, d$put)
      bp <- barplot(precios, names.arg = c("Opción de Compra (Call)", "Opción de Venta (Put)"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Precio teórico de la opción ($)",
                    ylim = c(0, max(precios) * 1.3),
                    main = "Precio Black-Scholes-Merton y Paridad Put-Call")
      text(bp, precios + 0.5, sprintf("$%.2f", precios), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Griegas y cobertura del derivado:"),
        tags$p(sprintf("Precio Call: $%.2f | Precio Put: $%.2f | Delta de cobertura (Delta-Hedging): %.2f. Para inmunizar una opción vendida contra el riesgo de mercado, el operador debe comprar exactamente %.2f acciones subyacentes.",
                       d$call, d$put, d$delta, d$delta))
      )
    })`,
    explanation: `
    <p>Black, Scholes y Merton descubrieron que combinando una opción con una cantidad calculada de la acción subyacente (cobertura delta continua), el riesgo de la inversión se elimina por completo, permitiendo valorar el contrato sin conocer las preferencias de riesgo de los inversores.</p>
    <p><strong>Contribución Nobel 1997:</strong> Robert C. Merton y Myron Scholes posibilitaron el nacimiento de los mercados modernos de derivados financieros y la gestión cuantitativa de riesgos.</p>`
  },

  "1996_mirrlees_vickrey": {
    title: "1996 · Tributación óptima (Mirrlees) y Subastas Vickrey",
    sidebar: `
    sliderInput("elasticidad_trabajo", "Elasticidad de oferta laboral (desincentivo al esfuerzo)", min = 0.1, max = 0.8, value = 0.3, step = 0.05),
    sliderInput("preferencia_social", "Preferencia social por la redistribución (aversion a la desigualdad)", min = 0.5, max = 3.0, value = 1.5, step = 0.25),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James Mirrlees (impuesto sobre la renta óptimo con información oculta) y William Vickrey (subasta de segundo precio compatible con incentivos).")`,
    resets: `updateSliderInput(session, "elasticidad_trabajo", value = 0.3)
    updateSliderInput(session, "preferencia_social", value = 1.5)`,
    serverLogic: `
    datos <- reactive({
      el <- input$elasticidad_trabajo
      g_soc <- input$preferencia_social
      
      # Estructura de tasas marginales optimas de Mirrlees en forma de U invertida:
      # Cero en el tope superior (para no destruir incentivos al maximo talento) y moderada en el centro
      ingresos <- seq(10, 200, length.out = 100)
      tasa_marginal <- (g_soc / (1 + el * 2)) * (ingresos / 100) * exp(-ingresos / 120) * 1.8
      tasa_marginal <- pmax(5, pmin(70, tasa_marginal * 100))
      
      list(ing = ingresos, t_mg = tasa_marginal)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$ing, d$t_mg, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Nivel de ingreso del contribuyente (miles de $)",
           ylab = "Tasa impositiva marginal óptima (%)",
           ylim = c(0, 75), main = "Curva Impositiva Óptima de Mirrlees (1971)")
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Resultado central de Mirrlees:"),
        tags$p(sprintf("La tasa impositiva marginal alcanza un pico máximo del %.1f%% en tramos medios y desciende para ingresos extremadamente altos, resolviendo la compatibilidad de incentivos entre recaudación fiscal y motivación productiva.",
                       max(d$t_mg)))
      )
    })`,
    explanation: `
    <p>James Mirrlees resolvió el dilema de cómo diseñar un sistema fiscal redistributivo cuando el gobierno puede observar los ingresos pero no el talento innato o el esfuerzo de los ciudadanos. William Vickrey demostró que en una subasta a sobre cerrado de segundo precio, la estrategia dominante de cada postor es revelar con absoluta sinceridad su verdadera valoración.</p>
    <p><strong>Contribución Nobel 1996:</strong> William Vickrey y James Mirrlees sentaron los cimientos de la economía de incentivos bajo información asimétrica.</p>`
  },

  "1995_lucas": {
    title: "1995 · Expectativas racionales y la Crítica de Lucas",
    sidebar: `
    sliderInput("sorpresa_politica", "Magnitud de la sorpresa monetaria no anticipada (%)", min = 0, max = 10, value = 4, step = 0.5),
    checkboxInput("politica_anunciada", "¿La política fue anunciada y anticipada por el público?", value = FALSE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert E. Lucas Jr.: las relaciones econométricas del pasado colapsan cuando el gobierno cambia su regla de política económica.")`,
    resets: `updateSliderInput(session, "sorpresa_politica", value = 4)
    updateCheckboxInput(session, "politica_anunciada", value = FALSE)`,
    serverLogic: `
    datos <- reactive({
      shock <- input$sorpresa_politica
      anticipada <- input$politica_anunciada
      
      # Curva de oferta de Lucas (modelo de islas):
      # y = y_n + alfa * (pi - pi^e)
      # Si es anticipada, pi^e = pi => y = y_n (neutralidad del dinero)
      if (anticipada) {
        efecto_pib <- 0.0
        inflacion <- shock
      } else {
        efecto_pib <- shock * 0.75 # Expansion transitoria
        inflacion <- shock * 0.5
      }
      
      list(pib = efecto_pib, inf = inflacion, ant = anticipada)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      resultados <- c(d$pib, d$inf)
      bp <- barplot(resultados, names.arg = c("Efecto en el PIB Real (pp)", "Aumento de Inflación (pp)"),
                    col = c("#2980b9", "#c0392b"),
                    ylab = "Desviación del equilibrio base",
                    ylim = c(0, max(8, resultados + 2)),
                    main = ifelse(d$ant, "Política Anunciada: Neutralidad Monetaria Total", "Política Sorpresa: Expansión Transitoria"))
      text(bp, resultados + 0.3, sprintf("+%.2f pp", resultados), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$ant) {
        tags$div(
          class = "alert alert-warning mt-3",
          tags$strong("Crítica de Lucas comprobada:"),
          " Cuando la política es anticipada, los agentes racionales ajustan sus precios y contratos inmediatamente. El dinero es neutral: el estímulo no genera ningún empleo adicional y solo crea inflación pura."
        )
      } else {
        tags$div(
          class = "alert alert-info mt-3",
          tags$strong("Efecto sorpresa transitorio:"),
          sprintf(" Al no haber sido prevista, la sorpresa monetaria engaña temporalmente a las empresas (confunden inflación general con demanda sectorial), elevando el PIB en +%.2f pp.", d$pib)
        )
      }
    })`,
    explanation: `
    <p>La célebre 'Crítica de Lucas' (1976) advirtió que usar parámetros históricos para predecir el impacto de nuevas políticas conduce al desastre: cuando las reglas del juego cambian, las expectativas y conductas de los ciudadanos cambian con ellas.</p>
    <p><strong>Contribución Nobel 1995:</strong> Robert Lucas Jr. transformó por completo el análisis macroeconómico, exigiendo que todos los modelos modernos posean microfundamentos y expectativas racionales.</p>`
  },

  "1994_nash_harsanyi_selten": {
    title: "1994 · Equilibrio de Nash y Juegos no cooperativos",
    sidebar: `
    sliderInput("beneficio_coop", "Premio por cooperación mutua (R)", min = 2, max = 8, value = 3, step = 1),
    sliderInput("tentacion_traic", "Tentación de traicionar / defeccionar (T)", min = 4, max = 10, value = 5, step = 1),
    sliderInput("castigo_mutuo", "Castigo por deserción mutua (P)", min = 0, max = 3, value = 1, step = 1),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("John Nash (equilibrio no cooperativo), John Harsanyi (juegos bayesianos) y Reinhard Selten (perfección en subjuegos).")`,
    resets: `updateSliderInput(session, "beneficio_coop", value = 3)
    updateSliderInput(session, "tentacion_traic", value = 5)
    updateSliderInput(session, "castigo_mutuo", value = 1)`,
    serverLogic: `
    datos <- reactive({
      R <- input$beneficio_coop
      T_val <- input$tentacion_traic
      P <- input$castigo_mutuo
      S <- 0 # Pago del estafado
      
      # Matriz de pagos del Dilema del Prisionero
      # Estrategia dominante de ambos: Traicionar
      list(R = R, T = T_val, P = P, S = S)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      pagos <- c(d$R, d$P)
      bp <- barplot(pagos, names.arg = c("Cooperación Mutua (Óptimo Social)", "Equilibrio de Nash (Ambos Traicionan)"),
                    col = c("#27ae60", "#c0392b"),
                    ylab = "Pago individual obtenido",
                    ylim = c(0, max(d$T, d$R) + 2),
                    main = "El Dilema del Prisionero: Nash vs. Pareto")
      text(bp, pagos + 0.3, sprintf("%.0f pts", pagos), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-danger mt-3",
        tags$strong("Equilibrio de Nash estricto:"),
        tags$p(sprintf("Dado que traicionar ofrece un pago de %d frente a %d al cooperar unilateralmente, la estrategia dominante conduce al equilibrio (Traicionar, Traicionar) con solo %d puntos, destruyendo el óptimo cooperativo de %d puntos.",
                       d$T, d$S, d$P, d$R))
      )
    })`,
    explanation: `
    <p>John Forbes Nash demostró que en cualquier juego con un número finito de jugadores y estrategias existe al menos un punto de equilibrio estable donde ningún jugador tiene incentivos unilaterales para cambiar de estrategia.</p>
    <p><strong>Contribución Nobel 1994:</strong> John Nash, John Harsanyi y Reinhard Selten convirtieron la teoría de juegos en el lenguaje unificado de la economía, la ciencia política y la biología evolutiva.</p>`
  },

  "1993_fogel_north": {
    title: "1993 · Historia económica, Cliometría e Instituciones (North & Fogel)",
    sidebar: `
    sliderInput("costo_transaccion", "Nivel de costos de transacción institucionales (%)", min = 5, max = 50, value = 25, step = 5),
    sliderInput("seguridad_juridica", "Seguridad contractual y derechos de propiedad", min = 0, max = 1, value = 0.7, step = 0.05),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert Fogel (revolución cliométrica de contrafactuales) y Douglass North (instituciones como reglas del juego en la historia).")`,
    resets: `updateSliderInput(session, "costo_transaccion", value = 25)
    updateSliderInput(session, "seguridad_juridica", value = 0.7)`,
    serverLogic: `
    datos <- reactive({
      ct <- input$costo_transaccion / 100
      sj <- input$seguridad_juridica
      
      # Crecimiento economico de largo plazo segun North
      pib_crecimiento <- 3.5 * sj * (1 - ct * 0.8)
      eficiencia_mercado <- 100 * (1 - ct) * sj
      
      list(g = pib_crecimiento, ef = eficiencia_mercado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      costos <- seq(5, 50, by = 5)
      crec_curva <- 3.5 * input$seguridad_juridica * (1 - (costos / 100) * 0.8)
      
      plot(costos, crec_curva, type = "b", pch = 19, col = "#2980b9", lwd = 2.5,
           xlab = "Costos de transacción en la economía (%)",
           ylab = "Tasa de crecimiento económico anual (%)",
           ylim = c(0, 4), main = "Instituciones y Crecimiento Histórico (North)")
      points(input$costo_transaccion, d$g, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Tesis institucional de Douglass North:"),
        tags$p(sprintf("Con costos de transacción al %.0f%% y solidez jurídica al %.0f%%, la tasa de crecimiento económico sostenido alcanza %.2f%% anual. Las instituciones deficientes son la causa primaria del estancamiento histórico.",
                       input$costo_transaccion, input$seguridad_juridica * 100, d$g))
      )
    })`,
    explanation: `
    <p>Douglass North demostró que las instituciones son las 'reglas del juego' formales e informales que reducen la incertidumbre en el intercambio humano. Robert Fogel empleó contrafactuales matemáticos para calcular que la economía estadounidense hubiese crecido casi igual sin ferrocarriles gracias a la red de canales fluviales.</p>
    <p><strong>Contribución Nobel 1993:</strong> Renovaron la historia económica mediante la aplicación de teoría económica y métodos cuantitativos rigurosos (cliometría).</p>`
  },

  "1992_becker": {
    title: "1992 · Economía de la conducta humana y del crimen (Gary Becker)",
    sidebar: `
    sliderInput("prob_captura", "Probabilidad de aprehensión y condena (p %)", min = 5, max = 80, value = 25, step = 5),
    sliderInput("severidad_pena", "Severidad de la pena monetaria o carcelaria (f $)", min = 200, max = 2000, value = 800, step = 100),
    sliderInput("botin_ilegal", "Ganancia económica del delito ($)", min = 100, max = 1500, value = 500, step = 50),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Gary Becker (1968): el delito es una decisión racional donde los individuos comparan la ganancia con el costo esperado de ser castigados.")`,
    resets: `updateSliderInput(session, "prob_captura", value = 25)
    updateSliderInput(session, "severidad_pena", value = 800)
    updateSliderInput(session, "botin_ilegal", value = 500)`,
    serverLogic: `
    datos <- reactive({
      p <- input$prob_captura / 100
      f <- input$severidad_pena
      g <- input$botin_ilegal
      
      # Costo esperado del delito: E[C] = p * f
      costo_esperado <- p * f
      beneficio_neto <- g - costo_esperado
      
      # Tasa agregada de criminalidad resultante
      crimen_indice <- max(5, 100 * exp(-costo_esperado / g * 0.8))
      
      list(p = p, f = f, g = g, ce = costo_esperado, bn = beneficio_neto, cr = crimen_indice)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      valores <- c(d$g, d$ce)
      bp <- barplot(valores, names.arg = c("Ganancia del Delito", "Costo Esperado del Castigo (p * f)"),
                    col = c("#e67e22", ifelse(d$bn > 0, "#c0392b", "#27ae60")),
                    ylab = "Valoración económica ($)",
                    ylim = c(0, max(valores) * 1.3),
                    main = "Ecuación Racional del Delito de Gary Becker")
      text(bp, valores + 25, sprintf("$%.0f", valores), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$bn > 0) {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Disuasión insuficiente:"),
          sprintf(" El beneficio ilícito ($%.0f) supera el costo penal esperado ($%.0f). El crimen es económicamente rentable con una ganancia neta esperada de +$%.0f.", d$g, d$ce, d$bn)
        )
      } else {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Disuasión efectiva:"),
          sprintf(" El costo esperado del castigo ($%.0f) excede el botín ($%.0f), logrando disuadir la conducta delictiva racional.", d$ce, d$g)
        )
      }
    })`,
    explanation: `
    <p>Gary Becker expandió el dominio del análisis microeconómico hacia áreas tradicionalmente reservadas a la sociología o el derecho: la discriminación racial, la natalidad, el matrimonio, la asignación del tiempo en el hogar y el delito.</p>
    <p><strong>Contribución Nobel 1992:</strong> Gary Becker demostró que el principio del comportamiento optimizador y los incentivos explican facetas cruciales de la interacción humana fuera del mercado formal.</p>`
  },

  "1991_coase": {
    title: "1991 · Teorema de Coase y Costos de Transacción",
    sidebar: `
    sliderInput("costos_transaccion", "Magnitud de los costos de negociación ($)", min = 0, max = 80, value = 15, step = 5),
    sliderInput("dano_externalidad", "Daño social causado por la fábrica contaminante ($)", min = 30, max = 120, value = 70, step = 10),
    sliderInput("costo_filtro", "Costo de instalar un filtro descontaminante ($)", min = 20, max = 80, value = 40, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Ronald Coase (1960): sin costos de transacción, las partes negocian la solución socialmente eficiente sin importar a quién pertenezca el derecho legal.")`,
    resets: `updateSliderInput(session, "costos_transaccion", value = 15)
    updateSliderInput(session, "dano_externalidad", value = 70)
    updateSliderInput(session, "costo_filtro", value = 40)`,
    serverLogic: `
    datos <- reactive({
      ct <- input$costos_transaccion
      dano <- input$dano_externalidad
      filtro <- input$costo_filtro
      
      # Ganancia social de instalar el filtro: dano - filtro
      excedente <- dano - filtro
      
      # Si el costo de transaccion supera el excedente, la negociacion privada fracasa
      negociacion_exitosa <- ct < excedente
      
      list(ct = ct, dano = dano, filtro = filtro, exc = excedente, exito = negociacion_exitosa)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      barras <- c(d$exc, d$ct)
      bp <- barplot(barras, names.arg = c("Ganancia Social Potencial", "Costos de Transacción"),
                    col = c("#27ae60", ifelse(d$exito, "#f39c12", "#c0392b")),
                    ylab = "Dólares ($)",
                    ylim = c(0, max(barras) + 15),
                    main = "El Teorema de Coase en Acción")
      text(bp, barras + 2, sprintf("$%.0f", barras), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      if (d$exito) {
        tags$div(
          class = "alert alert-success mt-3",
          tags$strong("Negociación Coaseana exitosa:"),
          sprintf(" Como los costos de transacción ($%.0f) son menores al beneficio neto ($%.0f), las partes llegan a un acuerdo privado eficiente y se instala el filtro sin necesidad de intervención judicial o impuestos pigouvianos.", d$ct, d$exc)
        )
      } else {
        tags$div(
          class = "alert alert-danger mt-3",
          tags$strong("Fallo de negociación por fricciones:"),
          sprintf(" Los costos de transacción ($%.0f) impiden el acuerdo. Aquí la asignación legal de los derechos de propiedad y la regulación pública sí determinan el resultado económico final.", d$ct)
        )
      }
    })`,
    explanation: `
    <p>Ronald Coase revolucionó el derecho y la economía con dos ideas maestras: en 1937 explicó por qué existen las empresas (para evitar los costos de negociar en el mercado abierto) y en 1960 formuló el Teorema de Coase sobre externalidades y derechos de propiedad.</p>
    <p><strong>Contribución Nobel 1991:</strong> Ronald Coase descubrió e integró el significado de los costos de transacción y los derechos de propiedad en la estructura institucional de la economía.</p>`
  },

  "1990_markowitz_miller_sharpe": {
    title: "1990 · Teoría de Portafolios y Modelo CAPM (Markowitz & Sharpe)",
    sidebar: `
    sliderInput("correlacion", "Correlación entre dos activos (rho)", min = -0.9, max = 0.9, value = 0.2, step = 0.1),
    sliderInput("peso_a", "Proporción invertida en Activo A (%)", min = 0, max = 100, value = 50, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Markowitz (frontera eficiente de varianza mínima), William Sharpe (CAPM y beta de mercado) y Merton Miller (finanzas corporativas).")`,
    resets: `updateSliderInput(session, "correlacion", value = 0.2)
    updateSliderInput(session, "peso_a", value = 50)`,
    serverLogic: `
    datos <- reactive({
      rho <- input$correlacion
      w_a <- input$peso_a / 100
      w_b <- 1 - w_a
      
      # Retornos esperados y desvíos estándar
      r_a <- 12.0; sd_a <- 20.0
      r_b <- 6.0;  sd_b <- 10.0
      
      # Portafolio
      r_p <- w_a * r_a + w_b * r_b
      var_p <- (w_a * sd_a)^2 + (w_b * sd_b)^2 + 2 * w_a * w_b * sd_a * sd_b * rho
      sd_p <- sqrt(var_p)
      
      # Frontera completa para graficar
      w_seq <- seq(0, 1, length.out = 100)
      r_curve <- w_seq * r_a + (1 - w_seq) * r_b
      sd_curve <- sqrt((w_seq * sd_a)^2 + ((1 - w_seq) * sd_b)^2 + 2 * w_seq * (1 - w_seq) * sd_a * sd_b * rho)
      
      list(r_p = r_p, sd_p = sd_p, r_c = r_curve, sd_c = sd_curve)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$sd_c, d$r_c, type = "l", col = "#2980b9", lwd = 3,
           xlab = "Riesgo de la cartera (Desviación Estándar %)",
           ylab = "Retorno Esperado (%)",
           xlim = c(5, 22), ylim = c(5, 13),
           main = "Frontera Eficiente de Markowitz")
      points(d$sd_p, d$r_p, pch = 21, bg = "#e74c3c", cex = 2.4, lwd = 2)
      text(d$sd_p + 0.8, d$r_p, "Portafolio Actual", col = "#e74c3c", font = 2)
      grid()
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Poder de la Diversificación de Markowitz:"),
        tags$p(sprintf("Con una correlación rho = %.1f y ponderación del %.0f%% en el activo A, el portafolio alcanza un retorno esperado del %.2f%% con un riesgo total de solo %.2f%%, demostrando que diversificar activos no correlacionados reduce el riesgo sin sacrificar rendimiento.",
                       input$correlacion, input$peso_a, d$r_p, d$sd_p))
      )
    })`,
    explanation: `
    <p>Harry Markowitz demostró matemáticamente en 1952 que un inversor no debe juzgar un activo por su riesgo individual aislado, sino por cómo aporta al riesgo del conjunto del portafolio. William Sharpe derivó el Capital Asset Pricing Model (CAPM) mostrando que el único riesgo recompensado es el riesgo sistemático no diversificable (Beta).</p>
    <p><strong>Contribución Nobel 1990:</strong> Harry Markowitz, Merton Miller y William Sharpe crearon las finanzas modernas como una disciplina científica cuantitativa.</p>`
  },

  "1989_haavelmo": {
    title: "1989 · El enfoque probabilístico en econometría (Haavelmo)",
    sidebar: `
    sliderInput("simultaneidad", "Fuerza de la retroalimentación simultánea de oferta y demanda", min = 0.1, max = 0.9, value = 0.5, step = 0.05),
    checkboxInput("corregir_iv", "Estimar con Variables Instrumentales (2SLS)", value = TRUE),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Trygve Haavelmo (1944): la econometría requiere modelos probabilísticos de ecuaciones simultáneas para no incurrir en sesgos graves.")`,
    resets: `updateSliderInput(session, "simultaneidad", value = 0.5)
    updateCheckboxInput(session, "corregir_iv", value = TRUE)`,
    serverLogic: `
    datos <- reactive({
      rho <- input$simultaneidad
      # Elasticidad real verdadera = -1.0
      beta_verdadero <- -1.0
      # Sesgo de ecuaciones simultaneas de MCO
      beta_ols <- beta_verdadero + rho * 0.85
      beta_estimado <- if (input$corregir_iv) beta_verdadero else beta_ols
      
      list(beta_v = beta_verdadero, beta_ols = beta_ols, beta_est = beta_estimado)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      betas <- c(abs(d$beta_v), abs(d$beta_ols), abs(d$beta_est))
      bp <- barplot(betas, names.arg = c("Valor Real Causal", "MCO Sesgado (Simultaneidad)", "Estimador Haavelmo (IV / 2SLS)"),
                    col = c("#7f8c8d", "#c0392b", "#27ae60"),
                    ylab = "Magnitud de la pendiente estimada |beta|",
                    ylim = c(0, 1.5),
                    main = "Sesgo de Ecuaciones Simultáneas de Haavelmo")
      text(bp, betas + 0.05, sprintf("%.2f", betas), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Lección metodológica de Haavelmo:"),
        tags$p(sprintf("Dado que el precio y la cantidad se determinan simultáneamente en el mercado, el estimador simple MCO produce un parámetro sesgado de %.2f. El enfoque probabilístico de Haavelmo restaura el parámetro verdadero (-1.00).",
                       d$beta_ols))
      )
    })`,
    explanation: `
    <p>Trygve Haavelmo publicó en 1944 el manifiesto fundacional que transformó la econometría de un simple ajuste de curvas deterministas a una disciplina rigurosa basada en la teoría de la probabilidad y la identificación de sistemas simultáneos.</p>
    <p><strong>Contribución Nobel 1989:</strong> Trygve Haavelmo estableció los cimientos probabilísticos de la econometría moderna.</p>`
  },

  "1988_allais": {
    title: "1988 · La Paradoja de Allais y la Utilidad Esperada",
    sidebar: `
    sliderInput("certeza_bonus", "Ponderación psicológica de la certeza absoluta (%)", min = 0, max = 50, value = 25, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Maurice Allais (1953): demostró mediante experimentos que las personas violan sistemáticamente el axioma de independencia de Von Neumann-Morgenstern.")`,
    resets: `updateSliderInput(session, "certeza_bonus", value = 25)`,
    serverLogic: `
    datos <- reactive({
      bonus <- input$certeza_bonus
      # Opcion A: $1 millon seguro (100%)
      # Opcion B: 10% de $5M, 89% de $1M, 1% de $0
      pref_a <- 50 + bonus
      pref_b <- 100 - pref_a
      
      list(a = pref_a, b = pref_b)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      
      porcs <- c(d$a, d$b)
      bp <- barplot(porcs, names.arg = c("Eligen $1M con 100% Certeza", "Eligen Lotería con mayor valor esperado"),
                    col = c("#2980b9", "#bdc3c7"),
                    ylab = "% de individuos que eligen cada opción",
                    ylim = c(0, 100),
                    main = "El Efecto Certeza de la Paradoja de Allais")
      text(bp, porcs + 3, sprintf("%.0f%%", porcs), font = 2)
      grid(nx = NA, ny = NULL)
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-warning mt-3",
        tags$strong("Violación del axioma de independencia:"),
        tags$p(sprintf("El %.0f%% de las personas prefiere la opción segura de $1 millón aun cuando la lotería tiene un valor esperado superior, debido a la aversión desproporcionada al arrepentimiento.",
                       d$a))
      )
    })`,
    explanation: `
    <p>Maurice Allais diseñó un famoso dilema que dejó perplejos a los mejores economistas de su época en un congreso en París: demostró que las personas no calculan probabilidades lineales, anticipando en décadas la teoría prospectiva.</p>
    <p><strong>Contribución Nobel 1988:</strong> Maurice Allais fue pionero en la teoría de mercados, equilibrio general y utilización eficiente de recursos económicos.</p>`
  },

  "1987_solow": {
    title: "1987 · El Modelo de Crecimiento Neoclásico de Solow",
    sidebar: `
    sliderInput("tasa_ahorro", "Tasa de ahorro e inversión (s %)", min = 5, max = 40, value = 20, step = 1),
    sliderInput("depreciacion", "Tasa de depreciación del capital (delta %)", min = 2, max = 10, value = 5, step = 0.5),
    sliderInput("crec_poblacion", "Crecimiento de la población (n %)", min = 0.5, max = 4.0, value = 1.5, step = 0.5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("Robert M. Solow (1956): a largo plazo el ahorro determina el nivel de capital de estado estacionario, pero solo el progreso tecnológico explica el crecimiento continuo per cápita.")`,
    resets: `updateSliderInput(session, "tasa_ahorro", value = 20)
    updateSliderInput(session, "depreciacion", value = 5)
    updateSliderInput(session, "crec_poblacion", value = 1.5)`,
    serverLogic: `
    datos <- reactive({
      s <- input$tasa_ahorro / 100
      delta <- input$depreciacion / 100
      n <- input$crec_poblacion / 100
      alpha <- 0.35 # Participacion del capital
      
      # Capital de estado estacionario k* = (s / (n + delta))^(1 / (1 - alpha))
      k_star <- (s / (n + delta))^(1 / (1 - alpha))
      y_star <- k_star^alpha
      c_star <- (1 - s) * y_star
      
      # Curvas de produccion e inversion
      k_seq <- seq(0.1, max(k_star * 1.6, 15), length.out = 150)
      inv_seq <- s * (k_seq^alpha)
      dep_seq <- (n + delta) * k_seq
      
      list(k_star = k_star, y_star = y_star, c_star = c_star,
           k_seq = k_seq, inv = inv_seq, dep = dep_seq)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$k_seq, d$inv, type = "l", col = "#27ae60", lwd = 3,
           xlab = "Capital por trabajador (k)", ylab = "Inversión y Depreciación per cápita",
           ylim = c(0, max(d$inv, d$dep) * 1.1),
           main = "Estado Estacionario en el Modelo de Solow")
      lines(d$k_seq, d$dep, col = "#c0392b", lwd = 2.5, lty = 2)
      abline(v = d$k_star, col = "#2980b9", lwd = 2, lty = 3)
      points(d$k_star, (input$tasa_ahorro/100) * (d$k_star^0.35), pch = 21, bg = "#f1c40f", cex = 2.2, lwd = 2)
      grid()
      legend("topleft", legend = c("Inversión s * f(k)", "Depreciación de reposición (n + delta) * k"),
             col = c("#27ae60", "#c0392b"), lwd = c(3, 2.5), lty = c(1, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Estado Estacionario Alcanzado:"),
        tags$p(sprintf("Capital por trabajador k* = %.2f | PIB por trabajador y* = %.2f | Consumo per cápita c* = %.2f. La acumulación de capital cesa cuando la inversión iguala exactamente la depreciación y el crecimiento poblacional.",
                       d$k_star, d$y_star, d$c_star))
      )
    })`,
    explanation: `
    <p>Robert Solow demostró que aumentar la tasa de ahorro eleva el nivel de vida temporalmente pero no la tasa de crecimiento tendencial a largo plazo: el crecimiento sostenido del PIB per cápita sólo puede explicarse por el residuo de Solow (avance tecnológico y productividad total de los factores).</p>
    <p><strong>Contribución Nobel 1987:</strong> Robert Solow construyó el modelo canónico del crecimiento económico sobre el que se apoya toda la macroeconomía moderna.</p>`
  },

  "1986_buchanan": {
    title: "1986 · Elección Pública y Costos de Votación (Buchanan)",
    sidebar: `
    sliderInput("regla_mayoria", "Regla de votación requerida (% del congreso)", min = 50, max = 100, value = 51, step = 5),
    actionButton("reset", "Restablecer valores", class = "btn-outline-primary"),
    helpText("James M. Buchanan (El Cálculo del Consenso, 1962): los políticos y burócratas actúan como agentes maximizadores de su propio interés, no del bienestar colectivo abstracto.")`,
    resets: `updateSliderInput(session, "regla_mayoria", value = 51)`,
    serverLogic: `
    datos <- reactive({
      K <- input$regla_mayoria
      
      # Buchanan & Tullock (1962):
      # Costos externos de decision D(K) (tirania de la mayoria sobre la minoria) disminuyen con K
      # Costos de decision C(K) (tiempo y dificultad para lograr acuerdo) aumentan con K
      k_grid <- 1:100
      costos_externos <- 100 * exp(-k_grid / 25)
      costos_acuerdo <- 2 * exp(k_grid / 25)
      costo_total <- costos_externos + costos_acuerdo
      
      opt_k <- which.min(costo_total)
      
      ce_actual <- 100 * exp(-K / 25)
      ca_actual <- 2 * exp(K / 25)
      ct_actual <- ce_actual + ca_actual
      
      list(k = k_grid, ce = costos_externos, ca = costos_acuerdo, ct = costo_total,
           K = K, ct_act = ct_actual, opt_k = opt_k)
    })

    output$grafico <- renderPlot({
      d <- datos()
      par(mar = c(4.5, 4.5, 3, 2))
      plot(d$k, d$ct, type = "l", col = "#8e44ad", lwd = 3,
           xlab = "Regla de votación (% de votos requeridos)",
           ylab = "Costos constitucionales",
           ylim = c(0, 110), main = "Regla de Decisión Óptima de Buchanan & Tullock")
      lines(d$k, d$ce, col = "#c0392b", lwd = 2, lty = 2)
      lines(d$k, d$ca, col = "#2980b9", lwd = 2, lty = 2)
      abline(v = d$K, col = "#f39c12", lwd = 2, lty = 3)
      grid()
      legend("topright", legend = c("Costo Total Constitucional", "Costos Externos (Tiranía)", "Costos de Negociación"),
             col = c("#8e44ad", "#c0392b", "#2980b9"), lwd = c(3, 2, 2), lty = c(1, 2, 2), bty = "n")
    })

    output$lectura <- renderUI({
      d <- datos()
      tags$div(
        class = "alert alert-info mt-3",
        tags$strong("Diseño Constitucional:"),
        tags$p(sprintf("Para la regla del %d%%, el costo constitucional total es de %.1f unidades. La regla teórica que minimiza el costo total se sitúa en torno al %d%% de los votos.",
                       d$K, d$ct_act, d$opt_k))
      )
    })`,
    explanation: `
    <p>James Buchanan fundó la Teoría de la Elección Pública (Public Choice) al aplicar el rigor analítico de la microeconomía al proceso político: los gobernantes y grupos de presión no persiguen desinteresadamente el 'bien común', sino rentas electorales y presupuestarias.</p>
    <p><strong>Contribución Nobel 1986:</strong> James M. Buchanan desarrolló las bases contractuales y constitucionales de la toma de decisiones políticas y económicas.</p>`
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
