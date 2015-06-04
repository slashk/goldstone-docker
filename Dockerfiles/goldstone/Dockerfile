# vim:set ft=dockerfile:

FROM solinea/python-wsgi

WORKDIR $APP_PREFIX

# Install Python requirements
COPY requirements.txt $APP_PREFIX/requirements.txt
ENV buildDeps 'ca-certificates gcc libpq-dev libssl-dev'
#RUN buildDeps=' \
    #ca-certificates \
    #gcc \
    #libpq-dev \
    #libssl-dev \
  #' \
#RUN set -x \
  #&& apt-get update \
  #&& apt-get install -y --no-install-recommends $buildDeps \
  #&& rm -r /var/lib/apt/lists/* \
  #&& pip install -r requirements.txt \
  #&& apt-get purge -y --auto-remove $buildDeps \
  #&& chown -R www-data:www-data $APP_PREFIX

USER root
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -r /var/lib/apt/lists/*

USER www-data
RUN virtualenv $APP_PREFIX \
  && . $APP_PREFIX/bin/activate \
  && pip install -r requirements.txt

USER root
RUN apt-get purge -y --auto-remove $buildDeps

# Copy Application
COPY . $APP_PREFIX
RUN chown -R www-data:www-data $APP_PREFIX

#COPY httpd-foreground /usr/local/bin/

ENV PATH $PATH:$APP_PREFIX/bin

USER www-data
#CMD ["./run_goldstone.sh"]
#apachectl -d . -f httpd.conf -e info -DFOREGROUND
