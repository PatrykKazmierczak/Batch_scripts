@echo off

set "repos_info=C:\scripts\repository"
set "repos_storage=C:\scripts\storage"
set "report_file=report-repos-storage.log"
set "error_file=error-repos-storage.log"

echo Repository Storage Batch Script

if not exist "%repos_info%" (
  echo Error: Repos info file "%repos_info%" does not exist
  exit /b 1
)

if not exist "%repos_storage%" (
  echo Error: Repos storage directory "%repos_storage%" does not exist
  exit /b 1
)

echo === Starting at %date% %time% ===

rem iterate over repositories
for /f "usebackq tokens=1,* delims=: " %%a in ("%repos_info%") do (
  if "%%a" equ "#" (
    rem comment, skip
    continue
  )

  set "repo_title=%%a"
  set "repo_tags=%%b"

  echo Processing repository "%repo_title%"

  for /f "tokens=* delims=" %%r in ('dir /b /ad "%repo_title%"') do (
    set "repo_dir=%repo_title%\%%r"
    set "repo_url=unknown"
    set "repo_remote_branches="
    set "repo_current_branch=unknown"
    set "zip_location=unknown"
    set "last_op_when_repo_exists=unknown"
    set "last_op_when_repo_not_exists=unknown"
    set "crc=unknown"
    set "zip_needed=0"

    echo Checking repository "%repo_dir%"

    cd "%repo_dir%"

    rem check if repo exists
    if not exist ".git" (
      echo Repository does not exist, zipping it...
      set "last_op_when_repo_not_exists=zip and move"

      rem TODO: calculate crc or check if any files were modified
      set "zip_needed=1"
    ) else (
      echo Repository exists, updating it...
      set "last_op_when_repo_exists=fetch and pull"

      rem list remote branches
      setlocal enabledelayedexpansion
      set "repo_remote_branches="
      for /f "delims=" %%b in ('git branch -r') do (
        set "line=%%b"
        set "line=!line: -> origin/!"
        set "repo_remote_branches=!repo_remote_branches!, !line!"
      )
      set "repo_remote_branches=!repo_remote_branches:~2!"
      endlocal

      rem checkout main branch or default branch from repos.info
      if exist "%repos_info%" (
        setlocal enabledelayedexpansion
        for /f "tokens=1,* delims=: " %%i in ('type "%repos_info%" ^| findstr /i /c:"%repo_title%"') do (
          if "%%i" neq "#" (
            set "default_branch=%%j"
          )
        )
        if defined default_branch (
          echo Checking out default branch "%default_branch%"
          git checkout "%default_branch%"
        ) else (
          echo Checking out main branch
          git checkout main
        )
        endlocal
      ) else (
        echo Warning: Repos info file not found, using main branch as default
        git checkout main
      )

      rem fetch and pull
      git fetch
      git pull

      rem check if any files were modified
      rem TODO: calculate crc or check if any files were modified
      set "zip_needed=1"
    )

    if %zip_needed% equ 1 (
      rem zip repo and move to repos storage
      set "zip
