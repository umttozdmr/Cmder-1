:: Init Script for cmd.exe
:: Sets some nice defaults
:: Created as part of cmder project

:: Setting prompt style
@for /f "tokens=2 delims=:." %%x in ('chcp') do @set cp=%%x

:: The slow part
:: World without Unicode is a sad world
@chcp 65001>nul

:: It has to be lambda, I already made a logo
@prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40mλ$S$E[0m
@chcp %cp%>nul

:: Pick right version of clink
@if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)

:: Used by the rest of the script
@set rootDir="%~dp0\.."

:: Run clink
@%rootDir%\vendor\clink\clink_x%architecture%.exe inject --quiet --profile %rootDir%\config

:: Prepare for msysgit
:: I do not even know, copy-pasted from their .bat
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=msys

:: Enhance Path
@set git_install_root=%rootDir%\vendor\msysgit
@set PATH=%PATH%;%rootDir%\vendor\putty;%rootDir%\bin;%git_install_root%\bin;%git_install_root%\cmd;%git_install_root%\share\vim\vim73;

:: Add aliases
:: These little thingies are life savers, believe me.
@doskey /macrofile="%rootDir%\config\aliases"

:: Set home path
@set HOME=%USERPROFILE%

:: Feel free to modify/remove
@echo [3;1mWelcome to cmder!
@echo customized by [31;2mdufferzafar
