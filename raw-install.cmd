:: Windows batch installer for aeneas audio sync tool found at
:: https://github.com/readbeyond/aeneas
@echo off
call :check_Permissions
ver | find /i "version 10." > nul
if %errorlevel%==0 set VERSIONWINDOWS=Windows 10
if %errorlevel%==0 echo Using Win 10 instal. ExecutionPolicy set to Bypass
@echo.

echo This installer method uses Chocolatey package manager for Windows
call where /Q choco.exe
if "%errorlevel%" == "0" (
  @echo Chocolatey is already installed
  ) else (
  @echo   installing Chocolatey
  @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && PATH "%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
  set errorlevel=0
  )
  @echo.
if "%VERSIONWINDOWS%" == "Windows 10" (
  choco install ffmpeg-w10 -s "%cd%" -y
  choco install espeak-w10 -s "%cd%" -y
  choco install miniconda-w10 -s "%cd%" -y
  choco install vcpluspluspython27-w10 -s "%cd%" -y
) else (
  choco install ffmpeg  -y
  choco install espeak -s "%cd%" -y
  choco install miniconda -y
  choco install vcpluspluspython27 -s "%cd%" -y
)
rem conda install pip -y --no-deps
C:\tools\Miniconda\Scripts\pip install BeautifulSoup
C:\tools\Miniconda\Scripts\pip install lxml
C:\tools\Miniconda\Scripts\conda install numpy -y --no-deps

echo all done installing prerequesites
goto :eof

:check_Permissions
    rem from Ben Hooper on http://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
    echo Administrative permissions required. 
    echo   Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        @echo.
    ) else (
        echo Failure: Current permissions inadequate.
        pause >nul
        exit /b
    )
goto :eof