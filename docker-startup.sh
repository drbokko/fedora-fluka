#!/bin/bash

set -xe

groupadd -g ${GROUP_ID} ${USER_NAME}
useradd -u ${USER_ID} -g ${USER_NAME}  ${USER_NAME} --no-create-home
echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

su ${USER_NAME}
