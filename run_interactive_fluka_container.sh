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

RED='\033[0;31m'
BLUE='\033[0;34m'
LBLUE='\033[1;34m'
NC='\033[0m' # No Color
echo -e "${LBLUE}*****************************************************${NC}"
echo -e "${LBLUE}** Starting interactive Docker container for Fluka **${NC}"
echo -e "${LBLUE}*****************************************************${NC}"
echo ""
echo "Setting up user ${USER_NAME} (UID:${USER_ID}, GID:${GROUP_ID}, home:${HOME_DIR})"

DOCKER_IMAGE_NAME="my_fedora_for_fluka"

DOCKER_OPTIONS="-v ${PWD}/docker-startup.sh:/docker-startup.sh -v ${HOME_DIR}:${HOME_DIR}
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=${DISPLAY}
    -e USER_NAME=${USER_NAME} -e USER_ID=${USER_ID} -e GROUP_ID=${GROUP_ID} -e HOME_DIR=${HOME_DIR}"

DOCKER_REMOTE_COMMAND="/usr/local/bin/docker-startup.sh"
CONTAINER_NAME="fluka-${USER_NAME}"

if [ "$(docker ps -aq -f status=exited -f name=${CONTAINER_NAME})" ]; then
  # cleanup
  echo "Removing existing exited container ${CONTAINER_NAME}"
  docker rm ${CONTAINER_NAME}
fi

EXISTING_CONTAINERS=$(docker ps -q -f name=${CONTAINER_NAME})
NUMBER_OF_EXISTING_CONTAINERS=$(echo $EXISTING_CONTAINERS | wc -w | cut -d ' ' -f 1)

if [ ! "${EXISTING_CONTAINERS}" ]; then
  # run your container
  docker run --rm -d --privileged -ti ${DOCKER_OPTIONS} --name $CONTAINER_NAME --workdir ${HOME_DIR} ${DOCKER_IMAGE_NAME} ${DOCKER_REMOTE_COMMAND}
  echo "Welcome to your FLUKA/Flair container [${CONTAINER_NAME}]"
  echo "Detach from container:      > exit"
  echo "Reattach to container:      docker exec -it ${CONTAINER_NAME} /usr/local/bin/docker-login.sh"
  docker exec -it ${CONTAINER_NAME} /usr/local/bin/docker-login.sh
else
  if [ "$NUMBER_OF_EXISTING_CONTAINERS" -eq "1" ]; then
    echo "Reattaching container"
    docker exec -it ${CONTAINER_NAME} /usr/local/bin/docker-login.sh
  else
    echo -e "${RED}Cannot create container${NC}"
    echo -e "${RED}The containers with id"
    for c_id in $EXISTING_CONTAINERS; do
      echo -e "- $c_id"
    done
    echo -e "match the container name [${CONTAINER_NAME}]$NC"
    exit 1
  fi
fi