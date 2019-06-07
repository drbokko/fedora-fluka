#!/bin/bash
# Script to build a Customized Docked Fedora 30 for running Fluka
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com

fluka_version="2011.2x"
fluka_respin="6"

fluka_tarball="fluka${fluka_version}-linux-gfor64bitAA.tar.gz"

fluka_package=$fluka_tarball
USER_NAME=$(whoami)

if [ -z "$1" ]; then
  echo "No argument supplied"
  fedora_for_fluka_repo="drbokko/fedora_for_fluka"
else
  if [ "$1" == "local" ]; then
    fedora_for_fluka_repo="fedora_for_fluka"
  else
    exit 1
  fi
fi

if [ ! -e ${fluka_package} ]; then 
   echo "Downloading Fluka"
   echo "Please specify your Fluka user identification ('fuid', i.e. fuid-1234)"
   echo -n "fuid: "
   read fuid

   wget --user=$fuid --ask-password  https://www.fluka.org/packages/${fluka_package}
fi

if [ ! -e ${fluka_package} ]; then
  echo "Error downloading Fluka package [${fluka_package}]"
  exit 1
fi

docker build --build-arg fedora_for_fluka_repo=$fedora_for_fluka_repo --build-arg fluka_package=$fluka_package -t fedora_with_fluka_for_${USER_NAME}:$fluka_version.$fluka_respin -t fedora_with_fluka_for_${USER_NAME} .
