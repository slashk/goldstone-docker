# vim:set ft=dockerfile:

FROM postgres:9.4
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

ENTRYPOINT /usr/bin/tail -f /dev/null
