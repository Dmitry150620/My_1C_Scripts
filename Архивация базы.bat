@echo off
cls
chcp 1251

rem -- Данные пользователя
set user_1C=""
set pswd_1C=""
rem -- Каталог сохранения бэкапов
set name_foulder_backup=d:\ARHIV-1C\Buh
rem -- Название базы
set name_base="%name_foulder_backup%\БелТАПАЗ_%date%_%time:~0,2%-%time:~3,2%-%time:~6,2%.dt"
rem -- путь базы бэкапа
set name_base_backup="d:\DATA\APPS\1C"
rem -- путь к файлу логов
set name_base_log="d:\DATA\1cUpload.log"

echo "Начало выгрузки %date% %time%" >> %name_base_log% 

rem -- удаляем файлы старше 61 дня
FORFILES /p %name_foulder_backup% /s /m *.dt /d -61 /c "CMD /c del /q /f @path"

rem -- Убивам процесс 1С если он такой есть
taskkill /im 1cv8.exe /im 1cv8s.exe /im 1cv8c.exe /f

rem -- определяем какая платформа 1С стоит х86 или х64,
rem -- пути у них разные

IF EXIST "%programfiles%\1cv8\common\1cestart.exe" (
set path_1C="%programfiles%\1cv8\common\1cestart.exe"
) ELSE (
set path_1C="%programfiles(x86)%\1cv8\common\1cestart.exe"
)
rem -----------------------------------------------

echo "Создание архива базы %date% %time%: %name_base%" >> %name_base_log% 

rem -- выгрузка базы данных
%path_1C% CONFIG /F%name_base_backup% /N%user_1C% /P%pswd_1C% /Out%name_base_log% -NoTruncate /DumpIB%name_base%


