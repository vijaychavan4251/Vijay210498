@echo off
REM Скрипт для автоматизации работы с компилятором PellesC
REM Использование:
REM     make - скомпилировать
REM     make clean - удалить файлы, сгенерированные при сборке
REM     make tags - сгенерировать теги по включаемым файлам
REM     make run - запустить скомпилированный исполняемый файл
REM     make atl - альтернативные команды сборки

SET PROJECT=myproject
SET PellesCDir=C:\Program Files\PellesC
SET Output=output

REM сгенерируем команду для сборки, должно получиться что-то типа:
REM cc -Tx86-coff -Ot -W1 -Ze -std:C11 %
REM   /I"C:\Program Files\PellesC\Include\"
REM   /I"C:\Program Files\PellesC\Include\Win\"
REM   /libpath:"C:\Program Files\PellesC\Lib\"
REM   /libpath:"C:\Program Files\PellesC\Lib\Win\"
REM   kernel32.lib user32.lib gdi32.lib comctl32.lib comdlg32.lib
REM   advapi32.lib delayimp.lib

SET PellesCOptions=-Ot -W1 -Ze -std:C11
SET PellesCInclude=/I"%PellesCDir%\Include\" /I"%PellesCDir%\Include\Win\"
SET PellesCLibPath=/libpath:"%PellesCDir%\Lib\"
SET PellesCx86LibPath=%PellesCLibPath% /libpath:"%PellesCDir%\Lib\Win\"
SET PellesCx64LibPath=%PellesCLibPath% /libpath:"%PellesCDir%\Lib\Win64\"
SET PellesCLibraries= kernel32.lib user32.lib gdi32.lib comctl32.lib^
    comdlg32.lib advapi32.lib
SET PellesCx86Libraries=%PellesCLibraries% delayimp.lib
SET PellesCx64Libraries=%PellesCLibraries% delayimp64.lib
SET PellesCCompileX86=cc %PellesCInclude% -Tx86-coff %PellesCOptions%^
    %PROJECT%.c /Fe%Output%\%PROJECT%.exe /Fo%Output%\%PROJECT%.obj^
    %PellesCx86LibPath% %PellesCx86Libraries%
SET PellesCCompileX64=cc %PellesCInclude% -Tx64-coff %PellesCOptions%^
    %PROJECT%.c /Fe%Output%\%PROJECT%.exe /Fo%Output%\%PROJECT%.obj^
    %PellesCx64LibPath% %PellesCx64Libraries%

IF "%~1"=="" (
    call %%PellesCCompileX86%%
    REM call %%PellesCCompileX64%%
) ELSE IF "%~1"=="clean" (
    del %Output%\* include_tags tags /Q
) ELSE IF "%~1"=="tags" (
    ctags -f include_tags -R --fields=+iaS --extra=+q ^
        "%PellesCDir%\Include\Win\fci.h" ^
        "%PellesCDir%\Include\Win\windef.h" ^
        "%PellesCDir%\Include\Win\windows.h" ^
        "%PellesCDir%\Include\Win\winuser.h"
) ELSE IF "%~1"=="run" (
    %Output%\%PROJECT%.exe
) ELSE IF "%~1"=="alt" (
    REM альтернативные команды сборки
    pocc %PellesCInclude% -Tx64-coff %PellesCOptions% ^
         %PROJECT%.c -Fo %Output%\%PROJECT%.obj
    polink %PellesCx64LibPath% -machine:amd64 -subsystem:windows ^
           %PellesCx64Libraries% ^
           -out:%Output%\%PROJECT%.exe %Output%\%PROJECT%.obj
)
