# vim:set ft=dockerfile:

FROM logstash:1.5
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN /opt/logstash/bin/plugin install logstash-filter-translate

# Fix for https://github.com/elastic/logstash/issues/3249
RUN chown -R logstash:logstash /opt/logstash/.bundle
