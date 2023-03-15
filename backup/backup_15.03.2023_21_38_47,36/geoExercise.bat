@echo off
echo ============================ Process start ===================================================================

set /p ADDRESS="Please provide address: "
set /p KEY="Please provide key: "
set    DEFAULT_KEY="AIzaSyDV6J_lwZ8KtNQg_1DFdJLKQRPjrlxCm4E"

if %ADDRESS% == help (
	echo ==============================================================================================================
	echo geo script is calling Google Geo API to get the localization data based on address search string
	echo -- Usage:
	echo address - first parameter is required
	echo key - second parameter is optional, if not provided, script is using default key
	echo -- Examples:
	echo geo Jowisza%20Gliwice%2021 AIzaSyBpGK2jgjRaF2CDzhMlJzAIbD7ACGcSOxs - runs with both address and key
	echo geo Jowisza%20Gliwice%2021 - runs only with address, using default key
	echo ==============================================================================================================
)

echo Provided address: %ADDRESS%
echo Provided key: %KEY%

Rem curl "https://maps.googleapis.com/maps/api/geocode/json?address=Hermisza%20Zabrze%202&key=AIzaSyBpGK2jgjRaF2CDzhMlJzAIbD7ACGcSOxs"


	
	
