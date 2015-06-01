# vim:set ft=dockerfile:

FROM solinea/centos-jdk-7:0.1
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN yum -y update; yum clean all

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
COPY logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum -y install logstash logstash-contrib; yum clean all

#COPY start_logstash /usr/local/bin/start_logstash
COPY conf.d/* /etc/logstash/conf.d/
COPY patterns/* /opt/logstash/patterns/

ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0/
ENV LS_HOME /opt/logstash/

RUN /opt/logstash/bin/plugin install logstash-filter-translate

expose 5514 5515

CMD ["/opt/logstash/bin/logstash", \
  "agent", \
  "-v", \
  "-f", "/etc/logstash/conf.d/", \
  "-w", "1" ]
