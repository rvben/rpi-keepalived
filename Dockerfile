FROM multiarch/alpine:armhf-latest-stable AS builder
LABEL maintainer "Ruben Jongejan - ruben.jongejan@gmail.com"

ARG KEEPALIVED_VERSION=2.0.5

RUN apk --no-cache add \
       autoconf \
       curl \
       gcc \
       ipset \
       ipset-dev \
       iptables \
       iptables-dev \
       libnfnetlink \
       libnfnetlink-dev \
       libnl3 \
       libnl3-dev \
       make \
       musl-dev \
       openssl \
       openssl-dev \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && mkdir -p /build/keepalived \
    && tar -xzf keepalived.tar.gz --strip 1 -C /build/keepalived \
    && cd /build/keepalived \
    && ./configure --disable-dynamic-linking \
    && make && make install

FROM multiarch/alpine:armhf-latest-stable
RUN apk --no-cache add \
       bash \
       ipset \
       iptables \
       libnfnetlink \
       libnl3 \
       libgcc \
       openssl && \
       adduser keepalived_script --disabled-password
COPY --from=builder /usr/local/sbin/keepalived /usr/local/sbin/keepalived
COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY notify.sh /notify.sh
COPY entrypoint.sh /entrypoint.sh

ENV INTERFACE="eth0"
ENV STATE="BACKUP"
ENV ROUTER_ID="41"
ENV PRIORITY="100"
ENV UNICAST_PEERS="192.168.2.101 192.168.2.102 192.168.2.103"
ENV VIRTUAL_IPS="192.168.2.100/24"
ENV PASSWORD="KeptAliv"
ENV NOTIFY="/notify.sh"

CMD ["bash", "-x", "entrypoint.sh"]
