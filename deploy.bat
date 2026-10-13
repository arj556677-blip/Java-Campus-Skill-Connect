@echo off
REM Campus SkillConnect - CMD Wrapper for deploy.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1"
