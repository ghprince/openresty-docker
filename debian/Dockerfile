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
        build-essential \
        ca-certificates \
        curl \
        git \
        libc6-dev \
        libcurl3 \
        libgcc1 \
        libpcre3-dev \
        libssl-dev \
        libstdc++6 \
        perl \
        unzip \
        wget \
        zlib1g-dev \
      && /install_openresty.sh \
      && /install_luarocks.sh \
      && apt-get purge --yes --auto-remove \
        build-essential \
        iproute \
        libpcre3-dev \
        libssl-dev \
        rename \
        wget \
        zlib1g-dev \
      && echo 'Yes, do as I say!' | apt-get purge --yes --force-yes --auto-remove \
        manpages \
        manpages-dev \
        linux-libc-dev \
        libc6-dev \
      && rm -rf \
        /var/lib/apt/lists/* \
        /install_openresty.sh \
        /install_luarocks.sh

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
