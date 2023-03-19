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

for /f "delims=" %%r in ('dir /b /s "%USERPROFILE%\*.git"') do (
  set "repo_dir=%%~dr%%~pr"
  cd /d "%%~dpnr"

echo ========================= Check git status =======================================================================
  git status >> "%output_file%"

echo ====================== Get current git branch ====================================================================
  git branch -r >> "%output_file%"

echo ======================= Checkout main branch =====================================================================
  git checkout main

echo ===================== Fetch latest git changes ===================================================================
  git fetch

echo ===================== Pull latest git changes ====================================================================
  git pull

echo ======================== Zip the repository ======================================================================
  set "zip_name=%%~nxr.zip"
  7z a -tzip "%USERPROFILE%\Downloads\%zip_name%" "*"

echo ================ Move the repository to specific location=========================================================
  move /Y "%%r" "C:\scripts\storage_info\"

  cd /d "%USERPROFILE%"
)




































