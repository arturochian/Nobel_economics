@echo off
setlocal
cd /d "%~dp0"

where node >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERROR: Node.js no esta instalado o no aparece en PATH.
  echo Descargalo desde https://nodejs.org/ y vuelve a ejecutar este archivo.
  echo.
  pause
  exit /b 1
)

if not exist "node_modules" (
  echo Instalando dependencias de la web...
  call npm ci
  if errorlevel 1 goto :error
)

echo Generando el sitio con el contenido disponible...
call npm run build
if errorlevel 1 goto :error

echo.
echo La web se abrira en http://localhost:4173/
echo Para detenerla, vuelve a esta ventana y pulsa Ctrl+C.
echo.
set "NOBEL_OPEN_BROWSER=1"
call npm run serve
exit /b %errorlevel%

:error
echo.
echo No se pudo preparar la web. Revisa el mensaje anterior.
echo.
pause
exit /b 1
