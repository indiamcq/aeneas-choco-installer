:: Windows batch installer for aeneas audio sync tool found at
:: https://github.com/readbeyond/aeneas
@echo off
call :check_Permissions

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


where /Q pip.exe 
if "%errorlevel%" == "0" (
  echo Pip in path
) else (
  path "%path%;C:\tools\python2\Scripts"
  set path=%path:"=%
)
where /Q pip.exe 
if "%errorlevel%" == "0" (
  echo starting pip installs
  call pip install BeautifulSoup
  call pip install lxml
  pip install numpy-1.9.2 + mkl-cp27-none-win_amd64.whl
  pip install scikits.audiolab-0.11.0-cp27-none-win_amd64.whl
)
where python /q
if "%errorlevel%" GTR "0" (
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