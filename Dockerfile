FROM ubuntu:19.04

MAINTAINER Anthony "cngzwing@vip.163.com"
LABEL Author="LiBoWen"
LABEL Version="2019.12"
LABEL Descruption="Python 3.7 开发环境"

ENV TIMEZONE Asia/Chongqing
ENV DEBIAN_FRONTEND noninteractive

RUN echo $TIMEZONE > /etc/timezone \
    && mkdir /data

# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
#     && apt-get clean \
#     && apt-get update

RUN apt-get clean && apt-get update && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Chongqing /etc/localtime \
    && dpkg-reconfigure -f $DEBIAN_FRONTEND tzdata \
    && apt-get install -y iproute2 \
    vim \
    build-essential \
    libevent-dev \
    checkinstall \
    libreadline-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    libbz2-dev \
    libssl-dev \
    libncurses5-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libdb-dev \
    libpcap-dev \
    xz-utils \
    libexpat1-dev \
    liblzma-dev \
    libffi-dev \
    libc6-dev

RUN cd /opt && curl -o /opt/python-3.7.6.tgz https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz \
    && tar xzf python-3.7.6.tgz \
    && cd Python-3.7.6 \
    && ./configure --prefix=/usr/local/python3 --enable-optimizations \
    && make && make install

RUN rm -f /usr/bin/python3 && rm -f /usr/bin/pip3 \
    && ln -sf /usr/local/python3/bin/python3.7 /usr/bin/python3 \
    && ln -sf /usr/local/python3/bin/pip3.7 /usr/bin/pip3

RUN cd ~ && mkdir -p .pip \
    && echo "[global]" > .php/pip.conf \
    && echo "index-url=http://mirrors.aliyun.com/pypi/simple/" >> .pip/pip.conf \
    && echo " " >> .pip/pip.conf \
    && echo "[install]" >> .pip/pip.conf \
    && echo "trusted-host=mirrors.aliyun.com" >> .pip/pip.conf

WORKDIR /data
VOLUME ["/data"]
EXPOSE 80


