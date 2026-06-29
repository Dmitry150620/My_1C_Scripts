rem Выгрузка информационной базы ЗУП в файл

@echo off
cls
chcp 1251

set user_1C=""
set psw_1C=""
rem Путь к каталогу информационной базы ЗУП:
set db_directory="D:\DATA\APPS\ZUP HS"
rem Путь к каталогу бэкапов ЗУП:
set backup_directory=D:\ARHIV-1C\ZUP XC
rem Файл выгрузки:
set backup_file="%backup_directory%\ZUP_XC_%DATE%_%TIME:~0,2%-%TIME:~3,2%.dt"
rem Файл журнала выгрузки:
set backup_log="D:\DATA\1cZUPUpload.log"
if exist "%programfiles%\1cv8\common\1cestart.exe" (
  set 1C_path="%programfiles%\1cv8\common\1cestart.exe"
) else (
  set 1C_path="%programfiles(x86)%\1cv8\common\1cestart.exe"
)

echo Начало выгрузки: %DATE% %TIME% >> %backup_log%

rem Завершаем процессы 1С:
taskkill /im 1cv8.exe /im 1cv8*.exe /f

echo Создание архива информационной базы %backup_file%: %DATE% %TIME% >> %backup_log%

rem Выгрузка информационной базы в файл:
%1C_path% DESIGNER /F%db_directory% /N%user_1C% /P%psw_1C% /DumpIB%backup_file%

echo Время завершения выгрузки: %DATE% %TIME%; код возврата: %ERRORLEVEL% >> %backup_log%