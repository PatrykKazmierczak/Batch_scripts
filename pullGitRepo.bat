@echo off
echo ============================ Process start ===========================================================================================
echo ==========================Check status of git ========================================================================================
git status
echo ===================Pull file contents from repo on GitHub ============================================================================
git pull https://github.com/PatrykKazmierczak/Batch_scripts.git
echo ====================Check status of git after pull request ===========================================================================
git status
echo ============================ Process finish ==========================================================================================
echo =====================Repo has been successfully updated ==============================================================================