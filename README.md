# aeneas-choco-installer
Provides a command line installer for Windows via Chocolatey

The Aeneas install process is well documented, but takes time. This method provides a simpler way to install.

* Download the Download ZIP file and extract to a folder.
* Open an Administrator command prompt at the folder that contains the install-aeneas.cmd file.
* Type in `install-aeneas` and press enter.

* The installer will check if Chocolatey is installed. https://chocolatey.org/
* It will install ffmpeg if it is not found in the path. [choco package]
* It will install espeak if it is not in the path. [tested: local nupkg]
* It will install Python 2.7 if it is not found in the path. If you have another Python installed you will need to manually remove that from the path. [Untested: local nupkg]
* It will add Microsoft Visual C++ Compiler for Python 2.7 [tested: local nupkg]
* Then it will install four Python packages. [2 remote pip packages and 2 local .whl packages]

If all goes will you should see no red text.

The installer can be re run as installed components are skipped but not all.

At the moment you have to approve the installations. This is still an alpha release.

To complete the set up change folder to your Aeneas folder and run the following tow commands

````
python setup.py build_ext --inplace
python check_dependencies.py
````