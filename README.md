# aeneas-choco-installer
Provides a command line installer for Windows via Chocolatey

The Aeneas install process is well documented, but takes time. This method provides a simpler way to install.

* Download the Download ZIP file and extract to a folder.
* Open an Administrator command prompt at the folder that contains the install-aeneas.cmd file.
* Type in `install-aeneas` and press enter.

* The installer will check if Chocolatey is installed. https://chocolatey.org/
* It will install ffmpeg if it is not found in the path. 
* It will install Python 2.7 if it is not found in the path. If you have another Python installed you will need to manually remove that from the path.
* It will install espeak if it is not in the path. [tested]
* It will add pip.exe to the path as the Python installation does not seem to do that.
* It will add Microsoft Visual C++ Compiler for Python 2.7 [Untested]
* Then it will install four Python packages. 
* Then it will run the Python setup [ wrong folder fix this or remove]
* Then it will run the checking script. [ wrong folder fix this or remove]

The installer can be re run as installed components are skipped but not all.

At the moment you have to approve the installations. This is still an alpha release.


