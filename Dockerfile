FROM ubuntu:bionic

ENV LD_LIBRARY_PATH=/opt/z-way-server/libs
ENV PATH=/opt/z-way-server:$PATH
ENV DEBIAN_FRONTEND noninteractive
ENV ZWAY_VERSION=3.1.1

#install deps
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install \
        sharutils \
        tzdata \
        gawk \
        libc-ares2 \
        wget \
        libssl1.0.0 \
        libavahi-compat-libdnssd-dev \
        libcurl3 \
        libcurl-openssl1.0-dev \
        libarchive13 \
    && apt-get -y autoremove && apt-get -y autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#install z-way-server
RUN wget http://razberry.z-wave.me/z-way-server/z-way-server-Ubuntu-v${ZWAY_VERSION}.tgz \
    && tar -vzxf z-way-server-Ubuntu-v${ZWAY_VERSION}.tgz -C /opt \
    && rm z-way-server-Ubuntu-v${ZWAY_VERSION}.tgz

EXPOSE 8083

WORKDIR /opt/z-way-server

CMD ["z-way-server"]
