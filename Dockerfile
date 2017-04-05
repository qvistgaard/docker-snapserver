# docker run --rm
#            --name snapserver 
#            -p 1704:1704 -p 1705:1705
#            -v /tmp/snapcast:/tmp
#            stilllman/docker-snapserver
FROM ubuntu:16.04

ENV snapcast_version 0.10.0
ENV shairport_version 2.9.5.7
ENV librespot_version 0.0.20161102

RUN apt-get update \
 && apt-get install -y \
    wget \
    git \
    apt-utils \
	autoconf \
	automake \
    libtool \
    build-essential \
    portaudio19-dev \
    libprotoc-dev \
    libtool-bin \
    libdaemon-dev \
    libasound2-dev \
    libpopt-dev \
    libconfig-dev \
	libssl-dev \
    avahi-daemon \
    libavahi-client-dev \
    libsoxr-dev \
    libvorbisfile3 \
 && rm -rf /var/lib/apt/lists/*

RUN cd /root \
 && git clone https://github.com/mikebrady/shairport-sync.git \
 && cd /root/shairport-sync \
 && git checkout -q tags/${shairport_version} \
 && autoreconf -i -f \
 && ./configure --with-stdout --with-avahi --with-ssl=openssl --with-metadata \
 && make \
 && make install

RUN wget -qO- https://github.com/badaix/librespot/releases/download/v${librespot_version}/librespot.x64.bz2 \
 | bzip2 -dc > /usr/local/bin/librespot
RUN chmod 755 /usr/local/bin/librespot

RUN  wget https://github.com/badaix/snapcast/releases/download/v${snapcast_version}/snapserver_${snapcast_version}_amd64.deb
RUN  dpkg -i snapserver_${snapcast_version}_amd64.deb \
  ;  apt-get update \
  && apt-get -f install -y \
  && rm -rf /var/lib/apt/lists/*

ADD snapserver.sh /snapserver.sh
RUN chmod 755 /snapserver.sh
RUN mkdir -p /var/run/dbus

# ENTRYPOINT ["/snapserver.sh"]
