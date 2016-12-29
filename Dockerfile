
FROM debian:jessie

MAINTAINER Rafa Couto <caligari@treboada.net> 

EXPOSE 25 587

#VOLUME ["/var/spool/mail/"]

RUN echo "$HOSTNAME" > /etc/hostname \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        supervisor \
        postfix \
        rsyslog \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf \
    && sed -i 's/^\(.\+|\/dev\/xconsole\)$/#\1/' /etc/rsyslog.conf

ENV HOSTNAME="mail" \
    DOMAIN="example.com" \
    MY_NETWORKS="127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128"

ADD entrypoint.sh /opt/docker/

ENTRYPOINT ["/bin/bash", "/opt/docker/entrypoint.sh"]

