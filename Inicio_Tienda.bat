@echo off
echo =========================================
echo   Verificando la Existencia de Python y Git
echo =========================================
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Winget no esta instalado o no esta en el PATH.
    echo Winget es el gestor de paquetes de Windows 10/11.
    echo Por favor, asegurate de tener la ultima version de Windows 10/11.
    echo.
    pause
    exit /b 1
)
echo.
echo -------------------------
echo   Verificando Git...
echo -------------------------
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo Git ya esta instalado. Version:
    git --version
) else (
    echo Git no detectado. Instalando Git...
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
    if %errorlevel% neq 0 (
        echo ERROR al instalar Git. Por favor, revisa el mensaje de error.
        pause
        exit /b 1
    )
    echo Git instalado correctamente.
)
echo.
echo -------------------------
echo   Verificando Python...
echo -------------------------
where python >nul 2>&1
if %errorlevel% equ 0 (
    echo Python ya esta instalado. Version:
    python --version
) else (
    echo Python no detectado. Instalando la ultima version de Python...
    winget install --id Python.Python -e --source winget --accept-package-agreements --accept-source-agreements
    if %errorlevel% neq 0 (
        echo ERROR al instalar Python. Por favor, revisa el mensaje de error.
        pause
        exit /b 1
    )
    echo Python instalado correctamente.
)
echo =========================================
echo   Iniciando clonacion y configuracion de ramas...
echo =========================================
set "REPO_URL=https://github.com/Gaborend/Tienda-proyecto.git"
set "FRONT_DIR=Tienda-proyecto-front"
set "BACK_DIR=Tienda-proyecto-back"
set "FRONT_BRANCH=frontend"
set "BACK_BRANCH=backend"
echo.

echo ---
echo   Gestionando el repositorio '%FRONT_DIR%' (rama '%FRONT_BRANCH%')...
echo ---

if exist "%FRONT_DIR%" (
    echo El directorio '%FRONT_DIR%' ya existe. Actualizando y cambiando a la rama '%FRONT_BRANCH%'...
    cd /d "%FRONT_DIR%"
    if %errorlevel% neq 0 (
        echo ERROR: No se pudo cambiar al directorio '%FRONT_DIR%'.
        pause
        exit /b 1
    )
    git pull origin "%FRONT_BRANCH%"
    if %errorlevel% neq 0 (
        echo ADVERTENCIA: Fallo al actualizar la rama '%FRONT_BRANCH%' en '%FRONT_DIR%'. Podria haber problemas de red o permisos.
    )
    git checkout "%FRONT_BRANCH%"
    if %errorlevel% neq 0 (
        echo ERROR: Fallo al cambiar a la rama '%FRONT_BRANCH%' en '%FRONT_DIR%'.
        echo Asegurate de que la rama '%FRONT_BRANCH%' exista en el repositorio.
        pause
        exit /b 1
    ) else (
        echo Rama '%FRONT_BRANCH%' activada exitosamente en '%FRONT_DIR%'.
    )
    cd ..
) else (
    echo Clonando '%REPO_URL%' en '%FRONT_DIR%'...
    git clone "%REPO_URL%" "%FRONT_DIR%"
    if %errorlevel% neq 0 (
        echo.
        echo ERROR: Fallo al clonar el repositorio para '%FRONT_DIR%'.
        echo Asegurate de que la URL sea correcta y tengas permisos.
        pause
        exit /b 1
    ) else (
        echo.
        echo Repositorio clonado exitosamente en '%FRONT_DIR%'.
        cd /d "%FRONT_DIR%"
        if %errorlevel% neq 0 (
            echo ERROR: No se pudo cambiar al directorio '%FRONT_DIR%'.
            pause
            exit /b 1
        )
        echo Cambiando a la rama '%FRONT_BRANCH%'...
        git checkout "%FRONT_BRANCH%"
        if %errorlevel% neq 0 (
            echo ERROR: Fallo al cambiar a la rama '%FRONT_BRANCH%' en '%FRONT_DIR%'.
            echo Asegurate de que la rama '%FRONT_BRANCH%' exista en el repositorio.
            pause
            exit /b 1
        ) else (
            echo Rama '%FRONT_BRANCH%' activada exitosamente en '%FRONT_DIR%'.
        )
        cd ..
    )
)
echo.

echo ---
echo   Gestionando el repositorio '%BACK_DIR%' (rama '%BACK_BRANCH%')...
echo ---

if exist "%BACK_DIR%" (
    echo El directorio '%BACK_DIR%' ya existe. Actualizando y cambiando a la rama '%BACK_BRANCH%'...
    cd /d "%BACK_DIR%"
    if %errorlevel% neq 0 (
        echo ERROR: No se pudo cambiar al directorio '%BACK_DIR%'.
        pause
        exit /b 1
    )
    git pull origin "%BACK_BRANCH%"
    if %errorlevel% neq 0 (
        echo ADVERTENCIA: Fallo al actualizar la rama '%BACK_BRANCH%' en '%BACK_DIR%'. Podria haber problemas de red o permisos.
    )
    git checkout "%BACK_BRANCH%"
    if %errorlevel% neq 0 (
        echo ERROR: Fallo al cambiar a la rama '%BACK_BRANCH%' en '%BACK_DIR%'.
        echo Asegurate de que la rama '%BACK_BRANCH%' exista en el repositorio.
        pause
        exit /b 1
    ) else (
        echo Rama '%BACK_BRANCH%' activada exitosamente en '%BACK_DIR%'.
    )
    cd ..
) else (
    echo Clonando '%REPO_URL%' en '%BACK_DIR%'...
    git clone "%REPO_URL%" "%BACK_DIR%"
    if %errorlevel% neq 0 (
        echo.
        echo ERROR: Fallo al clonar el repositorio para '%BACK_DIR%'.
        echo Asegurate de que la URL sea correcta y tengas permisos.
        pause
        exit /b 1
    ) else (
        echo.
        echo Repositorio clonado exitosamente en '%BACK_DIR%'.
        cd /d "%BACK_DIR%"
        if %errorlevel% neq 0 (
            echo ERROR: No se pudo cambiar al directorio '%BACK_DIR%'.
            pause
            exit /b 1
        )
        echo Cambiando a la rama '%BACK_BRANCH%'...
        git checkout "%BACK_BRANCH%"
        if %errorlevel% neq 0 (
            echo ERROR: Fallo al cambiar a la rama '%BACK_BRANCH%' en '%BACK_DIR%'.
            echo Asegurate de que la rama '%BACK_BRANCH%' exista en el repositorio.
            pause
            exit /b 1
        ) else (
            echo Rama '%BACK_BRANCH%' activada exitosamente en '%BACK_DIR%'.
        )
        cd ..
    )
)
echo.
echo =========================================
echo   Proceso de clonacion y configuracion de ramas completado.
echo =========================================

setlocal

set BACKEND_DIR=Tienda-proyecto-back
set FRONTEND_DIR=Tienda-proyecto-front
set VENV_DIR=%BACKEND_DIR%\venv
set REQ_FILE=%BACKEND_DIR%\requirements.txt
set BACKEND_ENTRY=store_inventory.app.main:app

echo Activando entorno virtual...

if not exist "%VENV_DIR%\Scripts\activate.bat" (
    echo   Creando entorno virtual...
    where python >nul 2>&1 && (
        python -m venv "%VENV_DIR%"
    ) || (
        echo No se encontro Python en el sistema. Abortando.
        exit /b 1
    )
)

call "%VENV_DIR%\Scripts\activate.bat"

if not exist "%REQ_FILE%" (
    echo No se encontro el archivo %REQ_FILE%. Abortando.
    exit /b 1
)

echo Instalando dependencias...
python -m pip install --upgrade pip
pip install -r "%REQ_FILE%"

echo Iniciando backend...
cd /d "%BACKEND_DIR%"
set PYTHONPATH=store_inventory
start "FastAPI" cmd /c "uvicorn %BACKEND_ENTRY% --reload > backend.log 2>&1"
cd ..

echo Iniciando frontend...
cd /d "%FRONTEND_DIR%"
REM Añadir verificacion de Node.js y npm aqui si aun no lo has hecho
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js no esta instalado o no esta en el PATH. Es necesario para el frontend.
    echo Por favor, instala Node.js desde https://nodejs.org/es/download/
    pause
    exit /b 1
)

echo Verificando si las dependencias de npm ya estan instaladas...
if not exist "node_modules" (
    echo Instalando dependencias de npm...
    call npm install
    if %errorlevel% neq 0 (
        echo ERROR: Fallo al instalar las dependencias de npm. Revisa el mensaje de error anterior.
        pause
        exit /b 1
    )
) else (
    echo Las dependencias de npm ya estan instaladas.
)

echo Verificando Yarn...
where yarn >nul 2>&1
if %errorlevel% neq 0 (
    echo Yarn no detectado. Instalando Yarn globalmente...
    call npm install -g yarn
    if %errorlevel% neq 0 (
        echo ERROR: Fallo al instalar Yarn globalmente.
        pause
        exit /b 1
    )
) else (
    echo Yarn ya esta instalado.
)

echo Verificando si las dependencias de Yarn ya estan instaladas...
REM Aunque node_modules ya fue verificado, Yarn puede tener su propio cache o estructura de dependencias
if not exist "node_modules" ( REM Re-check en caso de que npm install fallara o Yarn tenga requisitos adicionales
    echo Instalando dependencias de Yarn...
    call yarn install
    if %errorlevel% neq 0 (
        echo ERROR: Fallo al instalar las dependencias de Yarn. Revisa el mensaje de error anterior.
        pause
        exit /b 1
    )
) else (
    echo Las dependencias de Yarn ya estan instaladas.
)

start "Vite" cmd /c "npm run dev > frontend.log 2>&1"
cd ..

echo 🧭 Abriendo URLs en el navegador...
start http://localhost:5173/login
echo.
echo ✅ Aplicacion lanzada correctamente en segundo plano.
echo.
echo 📎 URL para acceder: http://localhost:5173/login
echo.
echo ℹ️   Para detener la aplicacion, debes cerrar las ventanas de la consola de FastAPI y Vite que se abrieron.
echo     Esta ventana del script puede cerrarse sin problemas.

endlocal
pause