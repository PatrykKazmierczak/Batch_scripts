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
for /f "delims=" %%a in ('dir /b /s /a:d "%USERPROFILE%\*.git"') do (
  pushd "%%a\.." > nul
  set "project_name=%%~nxa"
  
  echo Processing: !project_name!
  
  if exist ".git" (
    echo Checking git status...
    git status >nul 2>&1
    if %errorlevel% equ 0 (
      echo Listing remote branches...
      git branch -r
      echo Checking out main branch...
      git checkout main >nul 2>&1 || git checkout master >nul 2>&1
      echo Fetching and pulling changes...
      git fetch >nul 2>&1 && git pull >nul 2>&1
      echo Zipping repo and moving to storage...
      set "zip_file=%storage_info%\!project_name!.zip"
      git archive -o "!zip_file!" HEAD
      echo Updating log...
      echo Title: !project_name! >> "%repos_info%\repos.log"
      echo URL: %%~dpa >> "%repos_info%\repos.log"
      echo Remote branches:
      git branch -r >> "%repos_info%\repos.log"
      echo Current branch: >nul
      git branch --show-current >> "%repos_info%\repos.log"
      echo Zip location: !zip_file! >> "%repos_info%\repos.log"
      echo Last operation when repo exists: updated >> "%repos_info%\repos.log"
      echo Last operation when not repo exists: not applicable >> "%repos_info%\repos.log"
    ) else (
      echo Repository is not clean. Skipping...
    )
  ) else (
    echo Zipping repo and moving to storage...
    set "zip_file=%storage_info%\!project_name!.zip"
    git archive -o "!zip_file!" HEAD
    echo Updating log...
    echo Title: !project_name! >> "%repos_info%\repos.log"
    echo URL: %%~dpa >> "%repos_info%\repos.log"
    echo Remote branches: not applicable >> "%repos_info%\repos.log"
    echo Current branch: not applicable >> "%repos_info%\repos.log"
    echo Zip location: !zip_file! >> "%repos_info%\repos.log"
    echo Last operation when repo exists: not applicable >> "%repos_info%\repos.log"
    echo Last operation when not repo exists: created >> "%repos_info%\repos.log"
  )
  
  popd > nul
)

echo Preparing report...
set "report_file=%repos_info%\report-%~n0.log"
echo ==================== Unique tags ==================== > "!report_file!"
for /f "tokens=2 delims=: " %%t in ('findstr /i /c:"title:" "%repos_info%\repos.log" ^| sort /unique') do (
  echo %%t >> "!report_file!"
 
