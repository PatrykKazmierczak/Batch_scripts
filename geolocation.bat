@echo off
echo ============================ Process start ============================================

set SEARCH_STRING="Jowisza%20Gliwice%2021"
set API_KEY="AIzaSyBpGK2jgjRaF2CDzhMlJzAIbD7ACGcSOxs"

curl "https://maps.googleapis.com/maps/api/geocode/json?address=%SEARCH_STRING%&key=%API_KEY%"

echo ========================== Return coordinates =========================================

echo Coordinates for %SEARCH_STRING% 
pause
