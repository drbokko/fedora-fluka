# Customized Docked Fedora 27 for running Fluka
# ========================================================
# dr.vittorio.boccone@ieee.org
# vittorio.boccone@dectris.com

FROM drbokko/fedora_27-fluka

COPY *.tar.gz /tmp

RUN tar -zxvf /tmp/*.tar.gz -C /opt/fluka
RUN ar x /opt/fluka/libflukahp.a fluka.o
RUN cd /opt/fluka; make

