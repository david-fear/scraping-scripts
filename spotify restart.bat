REM = kill existing spotify task =
taskkill /IM "spotify.exe" /T /F

REM = fix shit quality sound
taskkill /IM "audiodg.exe" /T /F

REM = start new spotify =
start %AppData%\Spotify\Spotify.exe

ping 127.0.0.1 -n 5 > nul

powershell -Command "(New-Object -ComObject WScript.Shell).SendKeys([char]176)"

exit
exit /B