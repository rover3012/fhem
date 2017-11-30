FROM resin/rpi-raspbian

LABEL version="0.1beta"
LABEL maintainer=<albert@it-weis.net>

ENV FHEM_VERSION 5.8

RUN apt-get update && \
    apt-get -qy install perl \
                        libdevice-serialport-perl \
                        libio-socket-ssl-perl \
                        wget \
                        apt-utils \
                        apt-transport-https \
                        libwww-perl \
                        libcgi-pm-perl \
                        libjson-perl \
                        sqlite3 \
                        libdbd-sqlite3-perl \
                        libtext-diff-perl \
                        usbutils

#                        make
               
#RUN export PERL_MM_USE_DEFAULT=1 && \
#    cpan -i Module::Pluggable

RUN wget http://fhem.de/fhem-$FHEM_VERSION.deb

RUN dpkg -i fhem-$FHEM_VERSION.deb

RUN rm fhem-$FHEM_VERSION.deb

RUN apt-get install -f


# Some additions to the standard fhem.cfg
RUN echo 'attr global    nofork     1\n'    >> /opt/fhem/fhem.cfg && \
    echo 'attr WEB       editConfig 1\n'    >> /opt/fhem/fhem.cfg && \
    echo 'attr WEB       csrfToken  none\n' >> /opt/fhem/fhem.cfg && \
    echo 'attr WEBphone  csrfToken  none\n' >> /opt/fhem/fhem.cfg && \
    echo 'attr WEBtablet csrfToken  none\n' >> /opt/fhem/fhem.cfg 

#RUN addgroup fhem && \
#    adduser -D -G fhem -h /opt/fhem -u 1000 fhem

#EXPOSE 8083 8084 8085 7072
EXPOSE 8083

WORKDIR /opt/fhem


#CMD perl fhem.pl fhem.cfg
CMD /etc/init.d/fhem start
