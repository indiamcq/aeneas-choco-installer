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
rem ============================== ffmpeg

call where /Q ffmpeg.exe
if "%errorlevel%" == "0" (
  @echo ffmpeg is already installed
) else (
  @echo installing ffmpeg
  choco install ffmpeg
)
@echo.
rem ============================== eSpeak
call where /Q espeak.exe
if "%errorlevel%" == "0" (
  @echo eSpeak already installed
) else (
  @echo download and install eSpeak
  choco install espeak -s "%cd%" -f
)
@echo.

rem ============================== Python
rem from https://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi
@echo Checking for Python 2.7  
call where /Q python.exe
if "%errorlevel%" == "0" (
  @echo   Python is already installed. 
  @echo   Check that next line reports "Python 2.7.xx"
  python --version
  @echo.
  ) else (
  @echo   installing python
  choco install python2-7 -s "%cd%" -f
  )

rem ============================== Visual C++ for Python
if exist "C:\%userprofile%\AppData\Local\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" (
  echo Microsoft Visual C++ Compiler for Python 2.7 already installed
) else (
  echo Installing Microsoft Visual C++ Compiler for Python 2.7
  choco install vcpluspluspython27 -s "%cd%" -f
)
@echo.
rem ============================== Python packages
set pip=C:\tools\python2\Scripts\pip.exe
if exist "%pip%"  (
  echo Checking if required Python packages are installed
  if not exist "C:\tools\python2\Lib\site-packages\BeautifulSoup*" %pip% install BeautifulSoup
  if exist "C:\tools\python2\Lib\site-packages\BeautifulSoup*dist-info" echo   BeautifulSoup installed
  if not exist "C:\tools\python2\Lib\site-packages\lxml" %pip% install lxml
  if exist "C:\tools\python2\Lib\site-packages\lxml" echo   lxml installed
  if not exist "C:\tools\python2\Lib\site-packages\numpy" %pip% numpy-1.9.3+mkl-cp27-none-win_amd64.whl
  if exist "C:\tools\python2\Lib\site-packages\numpy" echo   numpy installed
  if not exist "C:\tools\python2\Lib\site-packages\scikits.audiolab*dist-info" %pip% install scikits.audiolab-0.11.0-cp27-none-win_amd64.whl
  if exist "C:\tools\python2\Lib\site-packages\scikits.audiolab*dist-info" echo   scikits.audiolab installed

) else (
  echo Pip not found at %pip%
)


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

:checkpath
where %~1 > temp.txt
call :getline 1 temp.txt
set apppath="%getline%"
echo Testing: %apppath%
goto :eof

:getline
:: Description: Get a specific line from a file
:: Class: command - internal
:: Required parameters:
:: linetoget
:: file
if defined echogetline echo on
set /A count=%~1-1
if "%count%" == "0" (
    for /f "delims=" %%i in (%~2) do (
        set getline=%%i
        goto :eof
    )
) else (
    for /f "skip=%count% delims=" %%i in (%~2) do (
        set getline=%%i
        goto :eof
    )
)
goto :eof