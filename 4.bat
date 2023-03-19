@echo off

cd C:\scripts\repos_info

for /d %%i in (C:\*.git, D:\*.git) do (
   cd %%i\..
   git log > %%~ni-log.txt
)