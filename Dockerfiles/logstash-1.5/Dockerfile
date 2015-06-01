# vim:set ft=dockerfile:

FROM solinea/centos-jdk-7:0.1
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN yum -y update; yum clean all

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
COPY logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum -y install logstash logstash-contrib; yum clean all

COPY conf.d /etc/logstash/conf.d
COPY patterns /etc/logstash/patterns

expose 5514 5515

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

CMD ["/opt/logstash/bin/logstash", \
  "agent", \
  "--config /etc/logstash.conf.d", \
  "--filterworker 1", \
  "--watchdog-timeout 10"]
