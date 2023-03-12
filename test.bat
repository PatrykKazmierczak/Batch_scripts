@echo off
echo ============================ Process start ===================================================================

set /p ADDRESS="Please write address: "
set    DEFAULT-KEY=AIzaSyDV6J_lwZ8KtNQg_1DFdJLKQRPjrlxCm4E
set	   KEY=AIzaSyBpGK2jgjRaF2CDzhMlJzAIbD7ACGcSOxs

if %ADDRESS%=="" (echo Provided address: %ADDRESS% and Provided key: %KEY%) else (echo Provided address: %ADDRESS% and Provided key: %KEY%)

