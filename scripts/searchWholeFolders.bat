@echo off
setlocal

set "output_file=C:\scripts\output\git_repositories.txt"

echo Searching for Git repositories in %USERPROFILE%...
for /d /r "%USERPROFILE%" %%a in (*.git) do (
    echo %%~dpa >> "%output_file%"
)

echo Done.
