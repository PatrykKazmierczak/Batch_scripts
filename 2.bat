@echo off

setlocal

rem Set the path to the repos.info file
set "repos_info=<path-to-repos.info>"

rem Set the path to the <repo_storage> location
set "repo_storage=<path-to-repo-storage>"

rem Set the default branch name
set "default_branch=main"

rem Initialize variables for report generation
set "unique_tags="
set "new_repos="

rem Iterate over repositories in the repos.info file
for /f "usebackq tokens=1,* delims=: " %%a in ("%repos_info%") do (
    rem Get the repository title and tags
    set "title=%%a"
    set "tags=%%b"

    rem Get the repository directory path
    set "repo_dir=<path-to-root-directory>\%%b"

    rem Check if the repository exists
    if exist "%repo_dir%" (
        rem If the repository exists, go to the repository directory
        cd /d "%repo_dir%"

        rem Log the remote branches
        git branch -r > "%title%_remote_branches.log"

        rem Checkout the main branch (or the default branch from the repos.info file)
        git checkout %default_branch%

        rem Fetch and pull changes from the remote repository
        git fetch
        git pull

        rem Zip the repository and move it to the <repo_storage> location
        set "zip_filename=%title%_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.zip"
        git archive -o "%zip_filename%" HEAD
        move "%zip_filename%" "%repo_storage%"

        rem Update the log with repository information
        echo.>>"%title%_log.txt"
        echo Title: %title%>>"%title%_log.txt"
        echo Tags: %tags%>>"%title%_log.txt"
        echo URL: <repo-url>>"%title%_log.txt"
        echo Remote branches:>>"%title%_log.txt"
        type "%title%_remote_branches.log">>"%title%_log.txt"
        echo Current branch: %default_branch%>>"%title%_log.txt"
        echo Zip location: %repo_storage%\%zip_filename%>>"%title%_log.txt"
        echo Last operation when repo exists: updated at %date% %time%>>"%title%_log.txt"
        echo Last operation when not repo exists: N/A>>"%title%_log.txt"

        rem Add the tags to the unique tags list for report generation
        for %%t in (%tags%) do (
            set "unique_tags=!unique_tags:%%t=!"
            if "!unique_tags!"=="%unique_tags%" set "unique_tags=!unique_tags! %%t"
        )
    ) else (
        rem If the repository doesn't exist, zip the repository and move it to the <repo_storage> location (if there was any change)
        rem The CRC (checksum) is an optional feature, depending on your needs
        set "zip_filename=%title%_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.zip"
        git archive -o "%zip_filename%" HEAD || (
            rem If there was no change, skip the repository
            echo Repository %title% has no changes.
            del "%zip_filename%"
            goto :skip_repo
