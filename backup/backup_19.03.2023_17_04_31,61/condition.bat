@echo off
echo ============================ Process start ===================================================================

set /p number1="Please write a number: "

if %number1%==1 (
	echo your number is one 
) else (
	echo your number is different than 1
)
	