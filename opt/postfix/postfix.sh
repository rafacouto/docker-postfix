#!/bin/bash

# configuration
postconf -e myhostname="$HOSTNAME.$DOMAIN"
postconf -e mydomain="$DOMAIN"
postconf -e mynetworks="$MY_NETWORKS"
postconf -e smtpd_banner="\$myhostname ESMTP"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mydestination="localhost, $myhostname, $mydomain"

# files for chrooted services
FILES="etc/localtime etc/services etc/resolv.conf etc/hosts \
        etc/nsswitch.conf etc/nss_mdns.config"
tar c $FILES | tar xC /var/spool/postfix

# start master daemon
postfix -c /etc/postfix start

# log to the standard output
tail -f /var/log/mail.log

