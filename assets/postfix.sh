#!/bin/bash

postconf -e myhostname="$HOSTNAME.$DOMAIN"
postconf -e mydomain="$DOMAIN"
postconf -e mynetworks="$MY_NETWORKS"
postconf -e smtpd_banner="\$myhostname ESMTP"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mydestination="localhost, $myhostname, $mydomain"

FILES="/etc/localtime /etc/services /etc/resolv.conf /etc/hosts \
        /etc/nsswitch.conf /etc/nss_mdns.config"
tar c $FILES | tar xC /var/spool/postfix

postfix -c /etc/postfix start

tail -f /var/log/mail.log

