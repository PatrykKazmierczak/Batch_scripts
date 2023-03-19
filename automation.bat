@echo off
setlocal enableextensions enabledelayedexpansion

echo ============================ Process start ====================================================================

echo =========== Define the folder to store the extracted information ==============================================

set repos_info=C:\scripts\repos_info


echo =============== Create the info folder if it doesn't exist ====================================================

if not exist "%repos_info%" mkdir "%repos_info%"

echo ================== Iterate over all local repositories ========================================================


for /d %%i in (C:\*.git, D:\*.git) do (
   cd %%i\..
   git log > %%~ni-log.txt
)

echo ========== Information extracted and saved to "%repos_info%" folder. =========================================
echo ============================ Process end ======================================================================
echo ============= Extract repository information and save it to a file ============================================
echo ==================== Check if the repository exists ===========================================================
echo =================  Switch to the repository directory =========================================================
pause

