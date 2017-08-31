FROM centos:7

MAINTAINER Deloitte Platform Engineering - Training

ENV LOCAL_TIMEZONE=Australia/Sydney
ARG GIT_COMMIT

# install basic tools and set AE(D)ST timezone
RUN yum -y update && \
    yum install -y \
        iproute \
        curl \
        ruby \
        tar \
        wget \
        bind-utils \
        telnet \
        unzip && \
    yum clean all && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/${LOCAL_TIMEZONE} /etc/localtime

# add the dumb-init binary
ENV DUMB_INIT_VERSION 1.2.0
RUN wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    chmod +x /usr/bin/dumb-init

LABEL git_commit ${GIT_COMMIT:-unknown}