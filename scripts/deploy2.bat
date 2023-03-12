@echo off
echo ============================ Process start ===========================================================================================
echo ============================ Previous version backup =================================================================================
echo ============================ Move to local artifacts repository ======================================================================
cd /D C:\artifacts
echo ============================ Rename sapp-0.0.1-SNAPSHOT.war sapp-0.0.1-SNAPSHOT.war.backup ===========================================
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%

set stamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%

copy "C:\artifacts\sapp-0.0.1-SNAPSHOT.war" "C:\artifacts\sapp-0.0.1-SNAPSHOT - %stamp%.war"
echo ============================ Artifact prepare ========================================================================================
cd /D C:\Users\patro\OneDrive\Pulpit\sapp\sapp
call mvn clean install
echo ============================ Copy to local artifacts repository C:\artifacts =========================================================
echo ============================ from C:\Users\patro\OneDrive\Pulpit\sapp\sapp\target ====================================================
copy C:\Users\patro\OneDrive\Pulpit\sapp\sapp\target\sapp-0.0.1-SNAPSHOT.war C:\artifacts
echo ============================ Move to local artifacts repository ======================================================================
cd /D C:\artifacts
echo ============================ Application deployment ==================================================================================
copy C:\artifacts\sapp-0.0.1-SNAPSHOT.war C:\apache-tomcat-10.0.27\webapps
echo ============================ Application run =========================================================================================
explorer "http://jenkins:8080/sapp-0.0.1-SNAPSHOT/web/app/password/list"
echo ============================ Process finish ==========================================================================================



