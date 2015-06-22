# FLUSSONIC
#
# VERSION               4.5.3

FROM      debian:wheezy
MAINTAINER Virginijus Magelinskas <virginijus@ambernet.lt>

ENV DEBIAN_FRONTEND noninteractive

# make sure the package repository is up to date
RUN apt-get update
RUN apt-get install -y wget supervisor
RUN wget -q -O - http://debian.erlyvideo.org/binary/gpg.key | apt-key add -
RUN echo "deb http://debian.erlyvideo.org binary/" > /etc/apt/sources.list.d/erlyvideo.list
RUN apt-get update
RUN apt-get -y install flussonic flussonic-ffmpeg
ADD supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor
VOLUME ["/etc/flussonic", "/var/run/flussonic", "/var/log/flussonic", "/mnt" ]
EXPOSE 80 81 443 554/udp 1935 3306 8080
CMD ["/usr/bin/supervisord"]
