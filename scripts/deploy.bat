@echo off
echo ============================ Process start ===========================================================================================
echo ============================ Previous version backup =================================================================================
 
cd /D C:\artifacts
echo ============================ Rename sapp-0.0.1-SNAPSHOT.war sapp-0.0.1-SNAPSHOT.war.backup ===========================================
set curr_date=%date%.txt
set curr_time=%time%
set timestamp=%curr_date%-%curr_time%
echo %timestamp%
set file_name=sapp-0.0.1-SNAPSHOT-%timestamp%.war.backup
echo %file_name%
ren "sapp-0.0.1-SNAPSHOT.war" "%file_name%"
echo ============================ Artifact prepare ========================================================================================
cd /D C:\Users\patro\OneDrive\Pulpit\sapp\sapp
call mvn clean install
echo ============================ Copy to local artifacts repository C:\artifacts =========================================================
echo ============================ from C:\Users\patro\OneDrive\Pulpit\sapp\sapp\target ====================================================
copy C:\Users\patro\OneDrive\Pulpit\sapp\sapp\target\sapp-0.0.1-SNAPSHOT.war C:\artifacts
echo ============================ Move to local artifacts repository ======================================================================
cd /D C:\artifacts
echo ============================ Application deployment ==================================================================================
copy C:\artifacts\sapp-0.0.1-SNAPSHOT.war C:\apache-tomcat-9.0.69\webapps
echo ============================ Application run =========================================================================================
explorer "http://localhost:8080/sapp-0.0.1-SNAPSHOT/web/app/password/list"
echo ============================ Process finish ==========================================================================================