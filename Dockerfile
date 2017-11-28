FROM resin/rpi-raspbian

MAINTAINER Albert Weis <albert@it-weis.net> rover3012

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
                        make
               
RUN export PERL_MM_USE_DEFAULT=1 && \
    cpan -i Module::Pluggable

RUN wget http://fhem.de/fhem-$FHEM_VERSION.deb

RUN dpkg -i fhem-$FHEM_VERSION.deb

RUN rm fhem-$FHEM_VERSION.deb

RUN apt-get install -f

EXPOSE 8083 8084 8085 7072

WORKDIR /opt/fhem


CMD perl fhem.pl fhem.cfg
