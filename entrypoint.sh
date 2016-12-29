#!/bin/bash

postconf -e myhostname="$HOSTNAME.$DOMAIN"
postconf -e mydomain="$DOMAIN"
postconf -e smtpd_banner="\$myhostname ESMTP"
postconf -e mail_spool_directory="/var/spool/mail/"
postconf -e mydestination="localhost, $myhostname, $mydomain"
postconf -Me submission/inet="submission inet n - - - - smtpd"

postconf 

cat > /etc/supervisor/conf.d/10-rsyslog.conf <<EOF
[program:rsyslog]
command=/usr/sbin/rsyslogd -n
EOF

cat > /etc/supervisor/conf.d/20-postfix.conf <<EOF
[program:postfix]
command=/usr/sbin/postfix -c /etc/postfix start
EOF

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

