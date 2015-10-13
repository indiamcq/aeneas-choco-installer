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
where espeak /q
if "%errorlevel%" GTR "0" (
  echo espeak installed
  ) else (
  echo download and install espeak
  choco install espeak -s "%cd%" -f
)

rem ============================== Python
rem from https://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi
rem from https://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi
  @echo Checking for Python 2.7  

where python /q
if "%errorlevel%" == "0" (
  @echo installing python
  choco install python2
  @echo.
  ) else (
  @echo Python is already installed
  @echo.
  )


if exist "C:\Users\mcquayi\AppData\Local\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" (
  echo Microsoft Visual C++ Compiler for Python 2.7 already installed
) else (
  echo Installing Microsoft Visual C++ Compiler for Python 2.7
  choco install vcpluspluspython27 -s "%cd%" -f
)
@echo.

set pip=C:\tools\python2\Scripts\pip.exe
if exist "%pip%"  (
  echo Pip in found
  echo starting pip Python package installs
  %pip% install BeautifulSoup
  %pip% install lxml
  %pip% numpy-1.9.3+mkl-cp27-none-win_amd64.whl
  %pip% install scikits.audiolab-0.11.0-cp27-none-win_amd64.whl

) else (
  echo Pip not found at %pip%
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
