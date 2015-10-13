:: Windows batch installer for aeneas audio sync tool found at
:: https://github.com/readbeyond/aeneas
@echo off
call :check_Permissions
if "%1" == "setupncheck" call :setupncheck

echo this installer uses Chocolatey package manager for Windows
echo first check if it is installed
call where /Q choco.exe
if "%errorlevel%" GTR "0" (
  @echo installing Chocolatey
  @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && PATH "%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
  set errorlevel=0
  ) else (
  @echo Chocolatey is already installed
  )
  @echo.

where /Q ffmpeg
if "%errorlevel%" GTR "0" (
  @echo installing ffmpeg
  choco install ffmpeg
  ) else (
  @echo ffmpeg is already installed
  )
  @echo.
  @echo Checking for Python 2.7
  
:: RM I changed this to install the package you specified.
where python /q
if "%errorlevel%" GTR "0" (
  @echo installing python
  choco install python2
  @echo.
  ) else (
  @echo Python is already installed
  @echo.
  )

where espeak /q
if "%errorlevel%" GTR "0" (
  echo espeak installed
  ) else (
  echo download and install espeak
  choco install espeak -s "%cd%" -f
)
where python /q
if "%errorlevel%" == "0" (
  echo Installing Microsoft Visual C++ Compiler for Python 2.7
  choco install vcpluspluspython27 -s "%cd%" -f
)
where /Q pip.exe 
if "%errorlevel%" == "0" (
  echo Pip in path
  echo starting pip installs
  call pip install BeautifulSoup
  call pip install lxml
  pip install numpy-1.9.2 + mkl-cp27-none-win_amd64.whl
  pip install scikits.audiolab-0.11.0-cp27-none-win_amd64.whl
) else (
  echo pip not found in path
  echo add pip manually to path
)

goto :eof

:setupncheck
echo this chek assumes aeneas is a sibling folder to the starting folder
echo if not press CTRL Break
pause
cd ..
cd aeneas
where python /q
if "%errorlevel%" == "0" (
  echo running setup
  python setup.py build_ext --inplace
  echo running checks
  python check_dependencies.py
)
goto :eof



:check_Permissions
    rem from Ben Hooper on http://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate.
        pause >nul
        exit /b
    )

goto :eof
