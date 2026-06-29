@echo off
:start
if exist D:\DATA\APPS\1C\ GOTO archivation
else GOTO :EOF

:archivation
cd /D D:\DATA
if exist 1C*.rar del 1C*.rar
taskkill /FI "IMAGENAME eq 1cv8.exe" /F
cd /D D:\DATA\APPS\1C
"C:\Program Files\WinRAR\Rar.exe" a -r -ag_YYYY-MM-DD_hh-mm D:\DATA\1C.rar
:END