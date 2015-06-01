# vim:set ft=dockerfile:

FROM centos:7
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN yum -y update; yum clean all

RUN yum install -y java-1.7.0-openjdk; yum clean all

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

CMD ["bash"]
