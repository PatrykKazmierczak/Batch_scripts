@echo off
echo ============================ Process start ===========================================================================================
set /A a=1
set /A b=2
set /A c=%a% + %b%
echo ========================= Sum of a and b is %c% ======================================================================================

set /A d=34
set /A e=12
set /A f=2

set /A g=%c% + %d% + %e% + %f%

echo ======================== Sum of c, d, e, f is %g% ====================================================================================

echo ============================ Process finish ==========================================================================================