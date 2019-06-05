# Docked Fedora for running (and maybe building) Fluka
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
#
# Rebuild: 
#   > docker build -t fedora_for_fluka .
#
# Run image (w/o mount point volumes):
#   > docker run --rm -i -t fedora_for_fluka bash
#
# Run image with volumes and X11 passthough 
#   > docker run -i --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/local_path -t fedora_for_fluka bash

FROM fedora:30

# Add default user
RUN useradd -c 'Fluka user' -m -d /home/fluka -s /bin/bash fluka
RUN mkdir -p /opt/fluka

# RUN echo "http_caching=none" >> /etc/yum.conf
RUN dnf clean all
RUN dnf install -y yum-plugin-ovl

RUN dnf install -y make cpp gcc gcc-gfortran glibc-devel glibc-headers kernel-headers libgfortran emacs
RUN dnf install -y git git-lfs subversion lsof wget sed gawk diffutils vim nano

# Install ipython scipy 
RUN dnf install -y scipy findutils

# Install flair from Vasilis's page
RUN dnf install -y http://www.fluka.org/flair/flair-2.3-0.noarch.rpm
RUN dnf install -y http://www.fluka.org/flair/flair-geoviewer-2.3-0.x86_64.rpm

RUN dnf install -y htop grep procps-ng
# One can now install fluka from the src https://www.fluka.org/packages/fluka2011.2c-linux-gfor64bitAA.tar.gz
RUN echo $'#!/bin/bash\n\
echo "Setting up home folder pass through"\n\
set -xe\n\
groupadd -g ${GROUP_ID} ${USER_NAME}\n\
useradd -u ${USER_ID} -g ${USER_NAME} -G fluka ${USER_NAME} --no-create-home\n\
echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers\n\
su root' > /usr/local/bin/docker-startup.sh

RUN echo $'#!/bin/bash\n\
set -xe\n\
su ${USER_NAME}'> /usr/local/bin/docker-login.sh

RUN chmod +x /usr/local/bin/docker-startup.sh
RUN chmod +x /usr/local/bin/docker-login.sh

