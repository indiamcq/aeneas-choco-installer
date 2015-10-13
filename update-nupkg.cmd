cd choco
for /F %%d in ('dir /b /a:d') do call :pack %%d
cd ..
pause
goto :eof

:pack
cd %~1
choco pack
copy /y *.nupkg ..\..\*.nupkg
cd ..
goto :eof

