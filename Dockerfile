FROM ubuntu:latest

MAINTAINER Peter Woodiwiss <pete@woodiwiss.email>

ENV DEBIAN_FRONTEND=noninteractive \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    LANGUAGE="en_US.UTF-8"

RUN apt-get install -qy --force-yes wget && \
    apt-get upgrade -qy --force-yes && \
    latest_lms=$(wget -q -O - "http://www.mysqueezebox.com/update/?version=7.9&revision=1&geturl=1&os=deb") && \
    mkdir -p /sources && \
    cd /sources && \
    wget -O lms.deb $latest_lms && \
    dpkg -i lms.deb && \
    ls /sources/logi* -1t | tail -3| xargs -d '\n' rm -f

VOLUME ["/music", "/config"]
EXPOSE 3483 3483/udp 9000

CMD ["/usr/sbin/squeezeboxserver","--user","root","--prefsdir","/config/prefs","--logdir","/config/logs","--cachedir","/config/cache"]
