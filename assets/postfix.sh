#!/bin/bash

postconf -e myhostname="$HOSTNAME.$DOMAIN"
postconf -e mydomain="$DOMAIN"
postconf -e smtpd_banner="\$myhostname ESMTP"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mydestination="localhost, $myhostname, $mydomain"

postfix -c /etc/postfix start

tail -f /var/log/mail.log

