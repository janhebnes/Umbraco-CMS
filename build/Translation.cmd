rem generate the input file
rem Should use Relative paths since the path is added to the pot files as comment reference - but we need to remove obj folders node_modules etc and package folders (anyone fresh for a fix ?)
rem @echo on>translation-inputfiles.txt
rem @echo off 
rem setlocal EnableDelayedExpansion
rem for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+1"
rem setlocal DisableDelayedExpansion
rem for /r . %%g in (*.js) do ( rem *.cs,*.cshtml,
  rem set "absPath=%%g"
  rem setlocal EnableDelayedExpansion
  rem set "relPath=!absPath:~%len%!"
  rem echo(!relPath! >> translation-inputfiles.txt
  rem endlocal
rem )

rem this should be more clever not taking obj folders into the mix... and with relative paths. 
dir ..\src\Umbraco.Web.UI\*.cs /S /B > translation-inputfiles.txt
dir ..\src\Umbraco.Web.UI\*.aspx /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.Web.UI\*.cshtml /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.Web\*.cs /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.Web\*.aspx /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.editorControls\*.cs /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.Core\*.cs /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.controls\*.cs /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.cms\*.cs /S /B >> translation-inputfiles.txt
dir ..\src\Umbraco.businesslogic\*.cs /S /B >> translation-inputfiles.txt


rem generate the po template file 
..\tools\Gettext.Tools.0.19.4\xgettext.exe -k -k_ -kText -kGetText --from-code=UTF-8 -L c# -o ..\src\Umbraco.Web.UI\Umbraco\config\lang\messages.pot -f translation-inputfiles.txt 

dir ..\src\Umbraco.Web.UI\*.js /S /B > translation-jsinputfiles.txt
rem -j for Join messages with existing file.

rem update with any backoffice javascript only gettext references
..\tools\Gettext.Tools.0.19.4\xgettext.exe -k -k_ -kgettext --from-code=UTF-8 -L JavaScript -j -o ..\src\Umbraco.Web.UI\Umbraco\config\lang\messages.pot -f translation-jsinputfiles.txt 


pause



rem Should use Relative paths since the path is added to the pot files as comment reference - but we need to remove obj folders node_modules etc and package folders (anyone fresh for a fix ?)
rem @echo on>translation-inputfiles.txt
rem @echo off 
rem setlocal EnableDelayedExpansion
rem for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+1"
rem setlocal DisableDelayedExpansion
rem for /r . %%g in (*.cs,*.cshtml,*.js) do ( 
  rem set "absPath=%%g"
  rem setlocal EnableDelayedExpansion
  rem set "relPath=!absPath:~%len%!"
  rem echo(!relPath! >> translation-inputfiles.txt
  rem endlocal
rem )
