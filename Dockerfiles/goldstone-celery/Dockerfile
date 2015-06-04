# vim:set ft=dockerfile:

FROM solinea/goldstone
MAINTAINER Luke Heidecke <luke@solinea.com>

# Configure environment
USER celery
ENV PATH /env/bin:/usr/local/bin:/usr/bin:/bin
RUN virtualenv /env

CMD ["celery", \
  "worker", \
  "-A", "celery.py", \
  "-Q", "default", \
  "-n", "default@%h", \
  "--loglevel=info"]
