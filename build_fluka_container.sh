#!/bin/bash
# Script to build a Customized Docked Fedora 27 for running Fluka 
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com

fluka_version="2011.2c"
fluka_respin="6"

fluka_rpm="fluka-${fluka_version}-${fluka_respin}.x86_64.rpm"
fluka_tarball="fluka${fluka_version}-linux-gfor64bitAA.tar.gz"
fluka_gfor63_tarball="fluka${fluka_version}-linux-gfor6.3-64bitAA.tar.gz"


fluka_package=$fluka_tarball

if [ ! -e ${fluka_package} ]; then 
   echo "Downloading Fluka"
   echo "Please specify your Fluka user identification ('fuid', i.e. fuid-1234)"
   echo -n "fuid: "
   read fuid

   wget --user=$fuid --ask-password  https://www.fluka.org/packages/${fluka_package}
fi

docker build -t my_fedora_27-fluka .
