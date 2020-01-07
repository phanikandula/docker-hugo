#This image is for dev use case. So using latest.
#If using for production use case.. use a specific tag and SHA ID
FROM ubuntu:latest

EXPOSE 1313

RUN apt update \
    && apt install -y sudo wget vim \
    && adduser --disabled-password --gecos "" devuser \
    && usermod -a -G sudo devuser \
    && echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/no_passwd_sudo

WORKDIR /home/devuser
USER devuser

#Version of hugo we want.
ARG VERSION=0.62.1

#Even though we switched to non-root user, files brought by ADD will still be owned by root.
#so, using sudo to access those files.

ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_Linux-64bit.tar.gz .
ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_checksums.txt .
RUN sudo grep hugo_${VERSION}_Linux-64bit.tar.gz hugo_${VERSION}_checksums.txt | sudo sha256sum -c \
    && sudo tar -zxvf hugo_${VERSION}_Linux-64bit.tar.gz \
    && sudo mv hugo /usr/local/bin \
    && rm -rf hugo_${VERSION}_Linux-64bit.tar.gz

ENTRYPOINT ["/usr/local/bin/hugo"]

