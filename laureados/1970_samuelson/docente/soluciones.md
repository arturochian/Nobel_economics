# Soluciones y rúbrica — Samuelson 1970

## Básico (6 puntos)

La ecuación es lineal: multiplicar el shock por cuatro multiplica por cuatro la desviación respecto del equilibrio, salvo redondeo. El equilibrio de largo plazo y las raíces características no cambian porque dependen de `A`, `c` y `v`, no del tamaño del impulso. Otorgar 2 puntos por la comparación, 2 por distinguir nivel y estabilidad y 2 por interpretar la convergencia.

## Intermedio (8 puntos)

Un ejemplo válido toma $x^A=(3,1)$ y $x^B=(1,3)$. Con $p^A=(2,1)$, A cuesta 7 y B cuesta 5: al escoger A cuando B era asequible, A queda directamente revelada preferida a B. Con $p^B=(1,2)$, B cuesta 7 y A cuesta 5: se elige B aunque A es estrictamente más barata. `comprobar_warp()` devuelve el par conflictivo. Se aceptan otros pares si el estudiante muestra las cuatro comparaciones de gasto. Rúbrica: construcción 4, comprobación 2, explicación 2.

## Reto (10 puntos)

Para cada $v$, las raíces satisfacen $\lambda^2-(c+v)\lambda+v=0$. El umbral debe determinarse numéricamente con la app y justificarse con `max(Mod(raices_dinamica(0.8, v)))`. La respuesta exacta depende del paso del control; se califica el procedimiento, no una cifra memorizada. Rúbrica: barrido documentado 3, identificación 2, cálculo de raíces 3, interpretación 2.

## Discusión

- Pasar WARP es evidencia de consistencia en las observaciones disponibles, no una prueba universal sobre decisiones no observadas.
- Sí: raíces complejas con módulo menor que uno generan oscilaciones amortiguadas.
- Harían falta series temporales, una estrategia de identificación, tratamiento de expectativas y diagnóstico de cambios estructurales.
