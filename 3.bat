@echo off
setlocal enableextensions enabledelayedexpansion

REM define the folder to store the extracted information
set info_folder=C:\scripts\repos_info\git_info

REM create the info folder if it doesn't exist
if not exist "%info_folder%" mkdir "%info_folder%"

REM iterate over all local repositories
for /d %%i in (*) do (

    REM switch to the repository directory
    cd "%%i"

    REM check if the repository exists
    if exist ".git" (

        REM extract repository information and save it to a file
        set info_file="%info_folder%\%%i.txt"
        echo Repository: %%i > !info_file!
        echo. >> !info_file!
        git status >> !info_file!
        echo. >> !info_file!
        git branch >> !info_file!
        echo. >> !info_file!
        git remote -v >> !info_file!
        echo. >> !info_file!
        git log --oneline -n 10 >> !info_file!
        echo. >> !info_file!
        git diff >> !info_file!
        echo. >> !info_file!

    )

)

REM display message when the script finishes
echo Information extracted and saved to "%info_folder%" folder.
pause
