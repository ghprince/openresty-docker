FROM debian:jessie

MAINTAINER ghprince@gmail.com

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r nginx && useradd -r -g nginx nginx

WORKDIR /app

ENV \
  OPENRESTY_VERSION=1.11.2.2 \
  LUAROCKS_VERSION=2.4.2 \
  OPENRESTY_PREFIX=/opt/openresty \
  NGX_CACHE_DIR=/var/cache/nginx

ENV PATH=$OPENRESTY_PREFIX/bin:$OPENRESTY_PREFIX/luajit/bin:$PATH

ADD install_openresty.sh /install_openresty.sh
ADD install_luarocks.sh /install_luarocks.sh

RUN set -ex \
      && apt-get update \
      && apt-get upgrade --yes \
      && apt-get install --yes \
        ca-certificates \
        build-essential \
        curl \
        git \
        libc6-dev \
        libcurl3 \
        libgcc1 \
        libpcre3-dev \
        libssl-dev \
        libstdc++6 \
        unzip \
        wget \
        zlib1g-dev \
      && /install_openresty.sh \
      && /install_luarocks.sh \
      && apt-get purge --yes --auto-remove \
        build-essential \
        curl \
        git \
        iproute \
        libgssapi-krb5-2 \
        libidn11 \
        libk5crypto3 \
        libkeyutils1 \
        libkrb5-3 \
        libkrb5support0 \
        libpcre3-dev \
        libssh2-1 \
        libssl-dev \
        rename \
        wget \
        zlib1g-dev \
      && echo 'Yes, do as I say!' | apt-get purge --yes --force-yes --auto-remove \
        manpages \
        manpages-dev \
        krb5-locales \
        unzip \
        linux-libc-dev \
        libc6-dev \
      && rm -rf \
        /opt/openresty/luajit/lib/libluajit-5.1.a \
        /opt/openresty/pod/ \
        /var/lib/apt/lists/* \
        /install_openresty.sh \
        /install_luarocks.sh

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
