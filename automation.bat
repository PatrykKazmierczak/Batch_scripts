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

runas /user:Administrator "for /d /r C:\ %%a in (*.git) do (
    echo %%~dpa >> "%output_file%"
    pushd "%%a\.." > nul
    git status >> "%output_file%"
    git branch -r >> "%output_file%"
    git checkout main
    git fetch
    git pull
    set "zip_file=%repos_info%\%%~nxa.zip"
    powershell Compress-Archive -Path "%%~nxa" -DestinationPath "%zip_file%"
    move /y "%zip_file%" "%storage_info%\"
    popd > nul
)"







































