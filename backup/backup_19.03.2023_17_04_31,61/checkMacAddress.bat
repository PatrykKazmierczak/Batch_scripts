@echo off
setlocal enabledelayedexpansion

set output_file=users_mac_addresses.csv

echo Retrieving MAC addresses and usernames of logged-in users...

echo User, MAC Address > %output_file%

for /f "skip=1 tokens=1-3" %%a in ('query user') do (
   set user=%%a
   set session=%%b
   set idle_time=%%c

   if !session! neq "0" (
      for /f "tokens=2 delims=:" %%d in ('ipconfig /all ^| find "Physical Address"') do (
         echo !user!,%%d >> %output_file%
      )
   )
)

echo Results saved to %output_file%.
