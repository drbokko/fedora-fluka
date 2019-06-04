# Customized Docked Fedora 27 for running Fluka
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com
# andrea.fontana@pv.infn.it

FROM drbokko/fedora_for_fluka
ARG fluka_package

# Add default user
RUN useradd -c 'Fluka user' -m -d /home/flukauser -s /bin/bash flukauser

# Copy fluka to local folder
COPY $fluka_package /tmp

RUN mkdir -p /opt/fluka
RUN tar -zxvf /tmp/*.tar.gz -C /opt/fluka
ENV FLUFOR=gfortran
ENV FLUPRO=/opt/fluka
RUN cd /opt/fluka; make

RUN chown -R flukauser:flukauser /opt/fluka

# Remove tmp file
RUN rm -rf /tmp/*.gz

# Default user
USER flukauser

ENV LOGNAME=flukauser
ENV USER=flukauser
ENV HOME /home/flukauser
WORKDIR /home/flukauser
