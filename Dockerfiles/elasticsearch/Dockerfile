# vim:set ft=dockerfile:

FROM solinea/goldstone-centos-jdk-7
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN yum -y update; yum clean all

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN yum -y install elasticsearch; yum clean all

COPY logging.yml /etc/elasticsearch/logging.yml

VOLUME ["/var/lib/elasticsearch"]

expose 9200 9300

CMD ["/usr/share/elasticsearch/bin/elasticsearch", \
  "-Des.path.conf=/etc/elasticsearch", \
  "-Des.path.data=/var/lib/elasticsearch", \
  "-Des.path.logs=/var/log/elasticsearch", \
  "-Des.transport.tcp.port=9300", \
  "-Des.http.port=9200"]
