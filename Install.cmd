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

echo This will install "Lock Drive..." shell context menu for unlocked BitLocker Drive.
timeout 10 2>NUL || pause

copy /y "%~dp0bdelock.cmd" "%systemroot%\system32\"
reg import "%~dp0bdelock.reg"

echo All Done.
pause