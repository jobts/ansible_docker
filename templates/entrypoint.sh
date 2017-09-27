#!/bin/bash
while ! nc -z pgdb 5432; do echo "postgresql is not ready"; sleep 1; done
source /home/django/venv/bin/activate && \
python ./projectname/manage.py migrate && \
cd /home/django/projectname && \
uwsgi --http-socket :8000 \
--module=projectname.wsgi:application \
--chdir=/home/django/projectname/ \
--env DJANGO_SETTINGS_MODULE=projectname.settings \
--uid=1000 --gid=1000  --max-requests=5000 --vacuum  \
--home=/home/django/venv


