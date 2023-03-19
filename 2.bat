
@echo off

setlocal

echo ============================ Process start ======================================================================

echo ============= Define the folder to store the extracted repos information ========================================

set repos_info=C:\scripts\repos_info
echo =============== Create the info folder if it doesn't exist ======================================================

if not exist "%repos_info%" mkdir "%repos_info%"
echo ============ Define the folder to store the extracted structure information =====================================

set storage_info=C:\scripts\storage_info
echo =============== Create the info folder if it doesn't exist ======================================================

if not exist "%storage_info%" mkdir "%storage_info%"

echo =============== Searching for Git repositories in %USERPROFILE% =================================================

set "output_file=C:\scripts\repos_info\git_repositories.txt"

for /d /r "%USERPROFILE%" %%a in (*.git) do (
    echo %%~dpa >> "%output_file%"
)
set "log_file=C:\scripts\repos_info\report-script.log"
set "error_file=C:\scripts\repos_info\error-script.log"

for /f %%i in (git_repository.txt) do (
    for /d /r "%%i" %%a in (*.git) do (
        echo %%~dpa >> "%output_file%"
        set "repo_dir=%%~dpa"
        cd /d "%%~dpa"
        set "repo_name=!repo_dir:~0,-5!"
        set "repo_name=!repo_name:%USERPROFILE%\=!"
        set "zip_file=C:\scripts\storage_info\!repo_name:~1,-1!.zip"
        echo Checking repo !repo_dir!...
        git status >nul 2>nul
        if errorlevel 1 (
            echo Repo does not exist, zipping...
            git archive --format=zip -o "!zip_file!" HEAD
            echo ^<title^>: ^<tags^> ^<url^>:!repo_dir! ^<remote branches^>: Not