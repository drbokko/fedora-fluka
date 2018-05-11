# Windows powershell
# Script to build a Customized Docked Fedora 27 for running Fluka 
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
#
# Windows version: andrea.fontana@pv.infn.it

$fluka_version="2011.2x"
$fluka_respin="2"

$fluka_rpm="fluka-$fluka_version-$fluka_respin.x86_64.rpm"
$fluka_tarball="fluka$fluka_version-linux-gfor64bitAA.tar.gz"
$fluka_gfor63_tarball="fluka$fluka_version-linux-gfor6.3-64bitAA.tar.gz"

$fluka_package="$fluka_tarball"

echo $fluka_package

if(!(Test-Path $fluka_package))
{
	Write-Output "Downloading Fluka"
	Write-Output "Please specify your Fluka user identification ('fuid', i.e. fuid-1234 and password) in the dialog"
	
	$Credentials = Get-Credential
	Invoke-WebRequest -Uri https://www.fluka.org/packages/$fluka_package -OutFile $fluka_package -Credential $Credentials
}

docker build -t my_fedora_27-fluka .
