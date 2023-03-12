@echo off

set "source_folder=C:\scripts\scripts"
set "backup_parent_folder=C:\scripts\backup"

rem Get the current date and time in a format suitable for use in a filename
set "curr_date=%date%"
set "curr_time=%time%"
rem Replace colons with underscores in the time to make it suitable for use in a filename
set "curr_time=%curr_time::=_%"
set "timestamp=%curr_date%_%curr_time%"

rem Replace any forward slashes in the date with dashes
set "timestamp=%timestamp:/=-%"

rem Create the backup folder with the current date and time as its name
set "backup_folder=%backup_parent_folder%\backup_%timestamp%"
mkdir "%backup_folder%"

rem Copy the contents of the source folder to the backup folder
xcopy "%source_folder%" "%backup_folder%" /E /C /I /Q /H /R /Y

if %errorlevel%==0 (
    echo Backup created successfully.
) else (
    echo Backup creation failed. Error code: %errorlevel%.
)

pause


