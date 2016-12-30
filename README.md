
# Postfix

Postfix is a free and open-source mail transfer agent (MTA) that routes and
delivers electronic mail.

This image is built in order to run Postfix only with SMTP service and provide
email sending from another hosts reachable from network.

## Get the docker image

### Pull a pre-built image

    docker pull caligari/postfix:latest

Available [image tags here](https://hub.docker.com/r/caligari/postfix/tags/).


### From Dockerfile

    git clone git@github.com:rafacouto/docker-postfix.git
    docker build -t caligari/postfix:latest ./docker-postfix

## Usage

Start SMTP service and expose it at port 25:

    docker run --detach --name mailserver \
        -p 25:25 \
        -e DOMAIN=mydomain.com \
        caligari/postfix


## Docker variables

    docker run \
        -e HOSTNAME="mail" \
        -e DOMAIN="example.com" \
        -e MY_NETWORKS="127.0.0.0/8 172.17.0.0/16" \
        caligari/postfix

- __HOSTNAME__="mail" Hostname for the SMTP mailname.
- __DOMAIN__="example.com" Domain for the SMTP mailname.
- __MY\_NETWORKS__="127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128" Networks allowed to send messages from.


## Docker volumes

### /var/spool/mail

Directory where mail queue is stored:

    docker run \
        -e DOMAIN=example.com \
        -v $(pwd)/mail:/var/spool/mail \
        caligari/postfix

