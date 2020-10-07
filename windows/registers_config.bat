REM ADDING "--remote-tab-silent to keep everything of gvim within same windows

set VERSION=vim82
:: (default) register name
reg add HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\edit\command /d "\"C:\Program Files (x86)\Vim\%VERSION%\gvim.exe\" --remote-tab-silent \"%%1\"" /t REG_SZ /f

:: reg add HKEY_LOCAL_MACHINE\SOFTWARE\Vim\Gvim /v path /d "\"C:\Program Files (x86)\Vim\%VERSION%\gvim.exe\"" /f

REM CUSTOM Vim context menu handler
reg add HKEY_CLASSES_ROOT\*\shell\Vim /d "Unleash Vim" /t REG_SZ /f
reg add HKEY_CLASSES_ROOT\*\shell\Vim /v Icon /d "\"C:\Program Files (x86)\Vim\%VERSION%\gvim.exe\"" /t REG_SZ /f
reg add HKEY_CLASSES_ROOT\*\shell\Vim\command /d "\"C:\Program Files (x86)\Vim\%VERSION%\gvim.exe\" --remote-tab-silent \"%%1\"" /t REG_SZ /f

REM removes auto-generated gvim menu handler
reg del /f HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\gvim 

ftype txtfile="C:\Program Files (x86)\Vim\%VERSION%\gvim.exe" --remote-tab-silent "%%1"

:: :: allows gvim to use User's vim folder
if exist %USERPROFILE%\.vim (
    echo linking GVIM with local Vim config...
    del "C:\Program Files (x86)\Vim\%VERSION%\_vimrc"
    mklink /d %USERPROFILE%\vimfiles %USERPROFILE%\.vim
)
