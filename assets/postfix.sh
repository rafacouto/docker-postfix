#!/bin/bash

postconf -e myhostname="$HOSTNAME.$DOMAIN"
postconf -e mydomain="$DOMAIN"
postconf -e smtpd_banner="\$myhostname ESMTP"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mydestination="localhost, $myhostname, $mydomain"
postconf -Me submission/inet="submission inet n - - - - smtpd"

postfix -c /etc/postfix start

tail -f /var/log/mail.log | iconv --to-code=UTF8

