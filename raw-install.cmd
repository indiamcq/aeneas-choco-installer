:: Windows batch installer for aeneas audio sync tool found at
:: https://github.com/readbeyond/aeneas
@echo off
call :check_Permissions

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
call where /Q conda.exe
if "%errorlevel%" == "0" (
  @echo Miniconda is already installed
  ) else (
  @echo   installing Miniconda
  choco install miniconda
  set errorlevel=0
  )
  @echo.
choco install ffmpeg  -y
choco install espeak -s "%cd%" -y
choco install miniconda -y
conda install pip -y --no-deps
choco install vcpluspluspython27 -s "%cd%" -y
pip install BeautifulSoup
pip install lxml
conda install numpy -y --no-deps

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