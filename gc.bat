@echo off
REM Get current timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set minute=%datetime:~10,2%
set second=%datetime:~12,2%

REM Format timestamp
set timestamp=%day%-%month%-%year% %hour%:%minute%:%second% %ampm%

REM Perform git operations
git add .
git commit -m "%timestamp%"
git push -u origin master

REM Open GitHub repository in default browser
start https://github.com/venu-webdev/songsDb