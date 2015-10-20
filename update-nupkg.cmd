cd choco
for /F %%d in ('dir /b /a:d') do call :pack %%d
cd ..
pause
goto :eof

:pack
cd %~1
choco pack
move /y *.nupkg ..\..
cd ..
goto :eof

