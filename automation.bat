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

echo =============== Searching for Git repositories in C:\ ===========================================================

set "output_file=C:\scripts\repos_info\git_repositories.txt"

for /d /r "C:\" %%a in (*.git) do (
    echo %%~dpa >> "%output_file%"
    pushd "%%a\.." > nul
    git status > nul 2>&1
    if %errorlevel% EQU 0 (
        REM Repo exists
        REM Log remote branches
        git branch -r > "%repos_info%\remote_branches.txt"
    
        REM Checkout main branch
        git checkout main > nul 2>&1
        if %errorlevel% EQU 1 (
            REM Main branch doesn't exist, fall back to default branch specified in repos.info file
            set /p default_branch=<"%repos_info%\repos.info"
            git checkout %default_branch% > nul 2>&1
        )
    
        REM Fetch and pull changes
        git fetch > nul 2>&1
        git pull > nul 2>&1
    
        REM Zip repo and move to storage folder
        set zip_name=%%~na.zip
        set zip_location=%storage_info%\%zip_name%
        git archive -o "%zip_location%" HEAD
        echo Moving "%zip_location%" to "%storage_info%\"
        move "%zip_location%" "%storage_info%\" > nul 2>&1
    
        REM Update log file
        set /p title=<"%repos_info%\title.txt"
        set /p tags=<"%repos_info%\tags.txt"
        set /p url=<"%repos_info%\url.txt"
        set remote_branches=
        for /f "usebackq delims=" %%r in ("%repos_info%\remote_branches.txt") do (
            set remote_branches=!remote_branches!; %%r
        )
        set /p current_branch=<"%repos_info%\current_branch.txt"
        set last_operation_existing_repo="fetch and pull"
        set last_operation_new_repo=""
        echo "%title%: %tags%" >> "%repos_info%\log.txt"
        echo %url% >> "%repos_info%\log.txt"
        echo %remote_branches% >> "%repos_info%\log.txt"
        echo %current_branch% >> "%repos_info%\log.txt"
        echo %zip_location% >> "%repos_info%\log.txt"
        echo %last_operation_existing_repo% >> "%repos_info%\log.txt"
        echo %last_operation_new_repo% >> "%repos_info%\log.txt"
      
    ) else (
        REM Repo doesn't exist
        set last_operation_existing_repo=""
        set last_operation_new_repo="create repo"
        echo "%title%: %tags%" >> "%repos_info%\log.txt"
        echo %url% >> "%repos_info%\log.txt"
        echo %last_operation_existing_repo% >> "%repos_info%\log.txt"
        echo %last_operation_new_repo% >> "%repos_info%\log.txt"
    )
)

