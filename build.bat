@echo off
REM ============================================================
REM Campus SkillConnect - Maven Build Helper
REM ============================================================

set "JAVA_HOME=C:\Program Files\Java\jdk-21.0.12"
set "MAVEN_HOME=C:\Users\asus\maven\apache-maven-3.9.6"
set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

cd /d "%~dp0"
call "%MAVEN_HOME%\bin\mvn.cmd" clean package -DskipTests
exit /b %ERRORLEVEL%
