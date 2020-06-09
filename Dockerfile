FROM debian:10-slim AS gosuinstaller

ENV GOSU_VERSION 1.12

RUN set -eux; \
  apt-get update; \
  apt-get -y --no-install-recommends install \
      ca-certificates \
      wget \
      gnupg2; \
  rm -rf /var/lib/apt/lists/*;

RUN set -eux; \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm /usr/local/bin/gosu.asc; \
  chmod +x /usr/local/bin/gosu; \
  gosu --version; \
  gosu nobody true;

FROM debian:10-slim

COPY --from=gosuinstaller /usr/local/bin/gosu /usr/local/bin/gosu

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
