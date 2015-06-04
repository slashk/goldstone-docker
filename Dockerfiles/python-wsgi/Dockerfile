# vim:set ft=dockerfile:

# Adapted from Docker official repos of python and httpd

FROM buildpack-deps:jessie

MAINTAINER Luke Heidecke <luke@solinea.com>

# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF
# see https://httpd.apache.org/download.cgi#verify
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A93D62ECC3C8EA12DB220EC934EA76E6791485A8

# Versions
ENV HTTPD_VERSION 2.4.12
ENV PYTHON_VERSION 2.7.10
ENV PYTHON_PIP_VERSION 7.0.3

# Installation Directories
ENV APP_PREFIX /app
ENV HTTPD_PREFIX /usr/local/apache2

ENV PATH $PATH:/env/bin:/$HTTPD_PREFIX/bin

# Create directories
RUN mkdir -p "$APP_PREFIX" "$HTTPD_PREFIX" \
  && chown -R www-data:www-data "$APP_PREFIX" "$HTTPD_PREFIX" \
  && usermod -d $APP_PREFIX www-data

# install httpd runtime dependencies
# https://httpd.apache.org/docs/2.4/install.html#requirements
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libapr1 \
    libaprutil1 \
    libpcre++0 \
    libssl1.0.0 \
  && rm -r /var/lib/apt/lists/*

# Build Apache
ENV HTTPD_BZ2_URL https://www.apache.org/dist/httpd/httpd-$HTTPD_VERSION.tar.bz2
RUN buildDeps=' \
    ca-certificates \
    curl \
    bzip2 \
    gcc \
    libapr1-dev \
    libaprutil1-dev \
    libc6-dev \
    libpcre++-dev \
    libssl-dev \
    make \
  ' \
  set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -r /var/lib/apt/lists/* \
  && curl -SL "$HTTPD_BZ2_URL" -o httpd.tar.bz2 \
  && curl -SL "$HTTPD_BZ2_URL.asc" -o httpd.tar.bz2.asc \
  && gpg --verify httpd.tar.bz2.asc \
  && mkdir -p src/httpd \
  && tar -xvf httpd.tar.bz2 -C src/httpd --strip-components=1 \
  && rm httpd.tar.bz2* \
  && cd src/httpd \
  && ./configure --enable-so --with-mpm=worker --enable-ssl --prefix=$HTTPD_PREFIX \
  #&& ./configure --enable-so --enable-ssl --prefix=$HTTPD_PREFIX \
  && make -j"$(nproc)" \
  && make install \
  && cd ../../ \
  && rm -r src/httpd \
  && sed -ri ' \
    s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
    s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
    ' /usr/local/apache2/conf/httpd.conf

# Install Python
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends curl \
  && mkdir -p /usr/src/python \
  && curl -SL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
  && curl -SL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
  && gpg --verify python.tar.xz.asc \
  && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
  && rm python.tar.xz* \
  && cd /usr/src/python \
  && ./configure --enable-shared --enable-unicode=ucs4 \
  && make -j$(nproc) \
  && make install \
  && ldconfig \
  && curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
  && pip install --upgrade pip==$PYTHON_PIP_VERSION \
  && find /usr/local \
    \( -type d -a -name test -o -name tests \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' + \
  && rm -rf /usr/src/python \
  && apt-get purge -y --auto-remove $buildDeps

# Install virtualenv
RUN pip install virtualenv

RUN pip install mod_wsgi

USER www-data
WORKDIR $APP_PREFIX

cmd []
