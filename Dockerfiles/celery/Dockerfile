# vim:set ft=dockerfile:

FROM google/python
MAINTAINER Luke Heidecke <luke@solinea.com>

RUN groupadd -r celery && useradd -r -m -g celery celery

# Setup up directories and volumes
RUN mkdir /app /env && chown celery:celery /app /env
VOLUME /app
WORKDIR /app

# Configure environment
USER celery
RUN virtualenv /env
COPY requirements.txt /app/requirements.txt
RUN /env/bin/pip install -r requirements.txt
ENV PATH /env/bin:/usr/local/bin:/usr/bin:/bin

CMD ["celery", \
  "worker", \
  "-A", "celery.py", \
  "-Q", "default", \
  "-n", "default@%h", \
  "--loglevel=info"]
