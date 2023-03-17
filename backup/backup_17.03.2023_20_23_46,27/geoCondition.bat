@echo off
echo ============================ Process start ===================================================================
echo ====================Please provide required geo-data =========================================================

set /p ADDRESS="Please provide address: "
set /p KEY="Please provide key: "
set DEFAULT_KEY="AIzaSyDV6J_lwZ8KtNQg_1DFdJLKQRPjrlxCm4E"

if not "%ADDRESS%"=="" if not "%KEY%"=="" (
   echo Google Geo API to localization %ADDRESS% and provided %KEY% is:
   curl "https://maps.googleapis.com/maps/api/geocode/json?address=%ADDRESS%&key=%KEY%"
) else if not "%ADDRESS%"=="" if "%KEY%"=="" (
   echo Google Geo API to localization %ADDRESS% and provided %DEFAULT_KEY% is:
   curl "https://maps.googleapis.com/maps/api/geocode/json?address=%ADDRESS%&key=%DEFAULT_KEY%"
) else (
   echo One or both variables are not set to their expected values
)

echo Provided address: %ADDRESS%
echo Provided key: %KEY%

echo ============================ Process end ======================================================================