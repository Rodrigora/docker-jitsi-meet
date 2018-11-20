FROM jitsi/base

ADD https://packages.prosody.im/debian/pool/main/p/prosody-trunk/prosody-trunk_1nightly747-1~stretch_amd64.deb /tmp/prosody-trunk.deb

RUN \
	apt-dpkg-wrap apt-get update && \
	apt-dpkg-wrap apt-get install -y lua5.1 lua-expat lua-socket lua-filesystem luarocks gcc libssl1.1 libssl1.0-dev git && \
	apt-cleanup && \
	dpkg -i /tmp/prosody-trunk.deb && \
	rm -rf /etc/prosody /tmp/prosody-trunk.deb

RUN \
	luarocks install luaossl CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install luajwt CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install luajwtjitsi CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install jwt-jitsi CRYPTO_LIBDIR=/usr/lib/x86_64-linux-gnu CRYPTO_INCDIR=/usr/include OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu OPENSSL_INCDIR=/usr/include && \
	luarocks install luasec && \
	luarocks install luabitop

COPY rootfs/ /
COPY git-modules/jitsi-meet/resources/prosody-plugins /prosody-plugins

EXPOSE 5222 5269 5347 5280

VOLUME /config

