:: Windows prompt
:: Script to build a Customized Docked Fedora 27 for running Fluka 
:: ========================================================
:: dr.vittorio.boccone@ieee.org
:: vittorio.boccone@dectris.com
::
:: Windows version: andrea.fontana@pv.infn.it

set fluka_version=2011.2x
set fluka_respin=2

:: set fluka_rpm=fluka-%fluka_version%-%fluka_respin%.x86_64.rpm
:: set fluka_gfor63_tarball=fluka%fluka_version%-linux-gfor6.3-64bitAA.tar.gz
set fluka_tarball=fluka%fluka_version%-linux-gfor64bitAA.tar.gz

set fluka_package=%fluka_tarball%

echo %fluka_package%

if not exist %fluka_package% (
   echo Downloading Fluka
   echo Please specify your Fluka user identification ('fuid', i.e. fuid-1234 and password)
:: to use wget for windows (if installed)
::   set /p fuid=fuid: 
::   wget --user=%fuid% --ask-password https://www.fluka.org/packages/%fluka_package%
   powershell -command "$Credentials = Get-Credential; Invoke-WebRequest -Uri "https://www.fluka.org/packages/%fluka_package%" -OutFile %fluka_package% -Credential "$Credentials""
)

if not exist %fluka_package% (
   echo Errors downloading Fluka
   exit 1
)

docker build --build-arg fluka_package=%fluka_package% -t my_fedora_27-fluka .
