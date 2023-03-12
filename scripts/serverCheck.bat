@echo off
set MyServer=www.google.pl
%SystemRoot%\system32\ping.exe -n 1 %MyServer% >nul
if errorlevel 1 goto NoServer

echo %MyServer% is available.
rem Insert commands here, for example one or more net use to connect network drives.
goto :EOF

:NoServer
echo %MyServer% is not available yet.
pause
goto :EOF