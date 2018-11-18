FROM jitsi/base

RUN \
	apt-dpkg-wrap apt-get update && \
	apt-dpkg-wrap apt-get install -t stretch-backports -y prosody luarocks gcc libssl1.1 libssl1.0-dev git && \
	apt-cleanup && \
	rm -rf /etc/prosody

COPY rootfs/ /
COPY git-modules/jitsi-meet/resources/prosody-plugins /prosody-plugins

RUN \
	luarocks list --outdated && \
	luarocks install luaossl  CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu  CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install luajwt CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu  CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install luajwtjitsi CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu  CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install jwt-jitsi CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu  CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include

EXPOSE 5222 5269 5347 5280

VOLUME /config

