@echo off
setlocal EnableDelayedExpansion

set "SCRIPT_DIR=%~dp0"
set "PATH_DIR=%SCRIPT_DIR%Splashs"
set "SPLASH_IMG=%SCRIPT_DIR%Splash.png"
set "cnt=0"

for %%F in ("%PATH_DIR%\*.jpg") do (
    set "file[!cnt!]=%%~fF"
    set /a cnt+=1
)
for %%F in ("%PATH_DIR%\*.png") do (
    set "file[!cnt!]=%%~fF"
    set /a cnt+=1
)

if %cnt%==0 goto :error

set /a randIdx=%RANDOM% %% %cnt%
set "selected=!file[%randIdx%]!"

copy /Y "!selected!" "!SPLASH_IMG!" >nul
if errorlevel 1 goto :error

timeout /t 1 /nobreak >nul

if "%~1"=="" (
    cd /d "%~dp0..\..\.."
    start "" "SB.exe"
) else (
    start "" %*
)

exit

:error
for %%F in ("%SCRIPT_DIR%\*.jpg") do del /f /q "%%~fF"
for %%F in ("%SCRIPT_DIR%\*.png") do del /f /q "%%~fF"
if "%~1"=="" (
    cd /d "%~dp0..\..\.."
    start "" "SB.exe"
) else (
    start "" %*
)
exit