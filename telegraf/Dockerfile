FROM buildpack-deps:buster-curl

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends iputils-ping snmp procps lm-sensors && \
    rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    mkdir ~/.gnupg; \
    echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf; \
    for key in \
        05CE15085FC09D18E99EFB22684A14CF2582E0C5 ; \
    do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
        gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done

ENV TELEGRAF_VERSION 1.17.3
# RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" && \
#     case "${dpkgArch##*-}" in \
#       amd64) ARCH='amd64';; \
#       arm64) ARCH='arm64';; \
#       armhf) ARCH='armhf';; \
#       armel) ARCH='armel';; \
#       *)     echo "Unsupported architecture: ${dpkgArch}"; exit 1;; \
#     esac && \
#     wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb.asc && \
#     wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb && \
#     gpg --batch --verify telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb.asc telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb && \
#     dpkg -i telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb && \
#     rm -f telegraf_${TELEGRAF_VERSION}-1_${ARCH}.deb*
COPY telegraf/build/dist/telegraf_1.17.3-1_amd64.deb /tmp/
RUN dpkg -i /tmp/telegraf_1.17.3-1_amd64.deb && \
    rm -rf /tmp/telegraf_1.17.3-1_amd64.deb

EXPOSE 8125/udp 8092/udp 8094

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
