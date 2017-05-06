# MariaDB
#
# VERSION	10.0

FROM phusion/baseimage:0.9.21
MAINTAINER James Brink <brink.james@gmail.com>
LABEL version="10.0"
LABEL decription="MariaDB Server"
ARG DEBIAN_FRONTEND=noninteractive
ARG MARIADB_VERSION=10.0

# Ensures consistent IDs.
RUN groupadd -r mysql && useradd -r -g mysql mysql

# Add MariaDB repository setup script.
COPY ./setup_mariadb_repo.sh /usr/local/bin/

# Add MariaDB entrypoint script.
COPY ./entrypoint.sh /usr/local/bin/

# Update script permissions and execute setup_script.
RUN chmod 755 /usr/local/bin/setup_mariadb_repo.sh \
	&& chmod 755 /usr/local/bin/entrypoint.sh \
    && /usr/local/bin/setup_mariadb_repo.sh $MARIADB_VERSION

# Instal MariaDB via apt-get.
RUN apt-get update -qq \
  && apt-get install -yqq \
    mariadb-server-$MARIADB_VERSION \
	mariadb-client-$MARIADB_VERSION \
  && rm -rf /var/lib/apt/lists/*

# Set MariaDB's data directory up as a volume.
VOLUME /var/lib/mysql
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]