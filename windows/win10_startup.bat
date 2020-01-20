@echo off
mode con: cols=80 lines=20

REM run after login
REM located in shell:startup

REM start xserver to share clipboard with bash
echo Starting VcXsrv...
start "" /b "C:\Program Files\VcXsrv\vcxsrv.exe" -multiwindow -clipboard

exit
