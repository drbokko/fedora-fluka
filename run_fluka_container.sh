#!/bin/bash
# Script to run a Customized Docked Fedora 27 for running Fluka 
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
# andrea.fontana@pv.infn.it
docker run -i --rm --name fluka --net=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $PWD/docker_work:/docker_work -t my_fedora_27-fluka bash
e
