@echo off
setlocal enabledelayedexpansion

:: relaunch self elevated
ver|find /i "XP">nul||whoami /all|find "S-1-16-12288">nul
IF %ERRORLEVEL% NEQ 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

if "%~1" equ "" (
  echo Usage: %~n1 DRIVE_LETTER [OPTIONS]
  goto :eof
)

echo This will lock Drive %~d1.
timeout 10 2>NUL || pause

manage-bde.exe -lock %~d1 %2 %3 %4 %5 %6 %7 %8 %9 >NUL || (
  echo.
  set /p yn=Lock failed. Do you want to force dismount? 
  if /i "!yn!" equ "y" (
    manage-bde.exe -lock %~d1 -ForceDismount %2 %3 %4 %5 %6 %7 %8 %9 >NUL
  )
)
