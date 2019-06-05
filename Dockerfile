# Customized Docked Fedora 27 for running Fluka
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
# andrea.fontana@pv.infn.it
# docker run -i --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -v $(pwd):/local_path -t my_fedora_for_fluka bash

FROM drbokko/fedora_for_fluka
ARG fluka_package

# Add default user
RUN useradd -c 'Fluka user' -m -d /home/fluka -s /bin/bash fluka

# Copy fluka to local folder
COPY $fluka_package /tmp

RUN mkdir -p /opt/fluka
RUN tar -zxvf /tmp/*.tar.gz -C /opt/fluka
ENV FLUFOR=gfortran
ENV FLUPRO=/opt/fluka
RUN cd /opt/fluka; make

RUN chown -R fluka:fluka /opt/fluka
RUN chmod -R g+rw /opt/fluka
# Remove tmp file
RUN rm -rf /tmp/*.gz

