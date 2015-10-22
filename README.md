# aeneas-choco-installer
Provides a command line installer for Windows via Chocolatey (works for Win 7 & 8.1, flakky for Win 10)

The Aeneas install process is well documented, but takes time. This method provides a simpler way to install.

* Download the Download ZIP file and extract to a folder.
* Open an Administrator command prompt at the folder that contains the install-aeneas.cmd file.
* Type in `raw-install` and press enter. (not found to work on Win 10)

* The installer will check if Chocolatey is installed. https://chocolatey.org/
* It will install ffmpeg if not already installed. [tested: local choco package]
* It will install espeak if not already installed. [tested: local choco package]
* It will install Miniconda Python 2.7 if not already installed. [tested: local choco package]
* It will add Microsoft Visual C++ Compiler for Python 2.7 [tested: local choco package]
* Then it will install three Python packages. [2 remote pip packages and 1 remote conda package]

If all goes will you should see no red text.

The installer can be re run as installed components are skipped (except Visual C++ Compiler for Python 2.7).

This is an alpha release. 

It is an unattended install, but you need to be there to see if it works as it goes along. There is no log file.

To complete the set up change folder to your Aeneas folder and run the following tow commands

````
python setup.py build_ext --inplace
python check_dependencies.py
````
