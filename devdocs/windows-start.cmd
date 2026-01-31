@echo off
title devdocs starter
echo Checking for http-server...

REM Check if http-server is installed globally
where http-server >nul 2>nul
if %errorlevel% equ 0 (
    echo http-server found globally
    goto :start_server
)

REM Check if http-server is installed locally
if exist "node_modules\.bin\http-server.cmd" (
    echo http-server found locally
    goto :start_server
)

REM If not found, install it
echo http-server not found. Installing...
echo.
call npm install -g http-server
if %errorlevel% neq 0 (
    echo Failed to install http-server globally. Trying local install...
    call npm install http-server
    if %errorlevel% neq 0 (
        echo Failed to install http-server. Please check your npm installation.
        pause
        exit /b 1
    )
)

echo Installation complete!
echo.

:start_server
echo Starting HTTP server...
npx http-server . -p 3000 -c-1 -o /devdocs.html                                               
pause
