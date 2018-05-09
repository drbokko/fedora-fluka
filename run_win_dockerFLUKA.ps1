#!/bin/bash
# Script to run a Customized Docked Fedora 27 for running Fluka 
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
# andrea.fontana@pv.infn.it
docker run -i --rm --name fluka --net=host -e DISPLAY=192.168.0.100:0.0 -v $pwd\docker_work:/docker_work -t my_fedora_27-fluka bash
