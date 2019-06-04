#!/bin/bash
# Script to run a Customized Docked Fedora 27 for running Fluka 
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
# andrea.fontana@pv.infn.it
# docker run -i --rm --name fluka --net=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $PWD/docker_work:/docker_work -t my_fedora_for_fluka bash

USER_NAME=$(whoami)
USER_ID=$(id -u)
GROUP_ID=$(id -g)
HOME_DIR="/home/${USER_NAME}"
CURRENT_DIR=${PWD}

echo ${USER_NAME}, ${USER_ID}, ${GROUP_ID}, ${HOME_DIR}
DOCKER_IMAGE_NAME="my_fedora_for_fluka"

DOCKER_OPTIONS="-v ${PWD}/docker-startup.sh:/docker-startup.sh -v ${HOME_DIR}:${HOME_DIR}
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=${DISPLAY}
    -e USER_NAME=${USER_NAME} -e USER_ID=${USER_ID} -e GROUP_ID=${GROUP_ID} -e HOME_DIR=${HOME_DIR}"

DOCKER_REMOTE_COMMAND="/usr/local/bin/docker-startup.sh"

# docker run -i --rm --net=host --env="DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix:rw -t my_fedora_for_fluka bash
docker run --rm --privileged -ti ${DOCKER_OPTIONS} --workdir ${HOME_DIR} ${DOCKER_IMAGE_NAME} ${DOCKER_REMOTE_COMMAND}
