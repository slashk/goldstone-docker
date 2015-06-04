#!/bin/bash
set -e

# have a command for running django, celery, and static

# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

#exec apachectl -d . -f httpd.conf -e info -DFOREGROUND
# mod_wsgi-express start-server --locale C.UTF-8
