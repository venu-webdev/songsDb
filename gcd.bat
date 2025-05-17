@echo off
setlocal enabledelayedexpansion

rem Get current datetime in consistent format using WMIC
for /f "tokens=2 delims==." %%a in ('wmic os get LocalDateTime /VALUE ^| findstr /r "^LocalDateTime"') do set "datetime=%%a"

rem Extract date components
set "year=%datetime:~0,4%"
set "month=%datetime:~4,2%"
set "day=%datetime:~6,2%"

rem Extract time components and convert to 12-hour format
set "hour=%datetime:~8,2%"
set "minute=%datetime:~10,2%"
set "second=%datetime:~12,2%"

rem Remove leading zero from hour for arithmetic operations
if "%hour:~0,1%"=="0" set "hour=%hour:~1%"

set /a hour_num=%hour%
set "ampm=AM"

if %hour_num% geq 12 (
    set "ampm=PM"
    if %hour_num% gtr 12 (
        set /a hour_num-=12
    )
)
if %hour_num% equ 0 set /a hour_num=12

rem Format hour with leading zero if needed
if %hour_num% lss 10 (
    set "hour_str=0%hour_num%"
) else (
    set "hour_str=%hour_num%"
)

rem Create timestamp string
set "timestamp=%day%-%month%-%year% %hour_str%:%minute%:%second% %ampm%"

rem Execute Git commands
git add .
git commit -m "%timestamp%"
git push -u origin master

rem Open GitHub repository in default browser
start "" "https://github.com/venu-webdev/songsDb"

endlocal