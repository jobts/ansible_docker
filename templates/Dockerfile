#
# Dockerfile
#

# Pull base image.
FROM debian:jessie
ARG DEBIAN_FRONTEND=noninteractive
MAINTAINER  Testdocker
# install 
RUN apt-get update && \
    apt-get install -y  apt-utils && \
    apt-get upgrade -y && \     
    apt-get install -y  wget unzip python python-dev python-pip virtualenv postgresql-client libpq-dev netcat && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
RUN groupadd -g 1000 django && useradd  -u 1000 -g django -s /bin/bash -m django 
USER django
RUN cd && /usr/bin/virtualenv venv && wget https://github.com/kirpit/django-sample-app/archive/master.zip && unzip master.zip && \
    rm -rf master.zip && mv  django-sample-app-master projectname  && \
    cd projectname && rm -rf ./.git ./.gitignore && \
    sed -i 's/{{ project_name }}.settings/projectname.settings/'  ./projectname/wsgi.py && \
    . ~/venv/bin/activate && \
    pip install -r requirements.txt && \
    pip install uwsgi
COPY default.py /home/django/projectname/projectname/settings/
COPY entrypoint.sh /home/django/projectname/
WORKDIR /home/django/projectname/
USER django
CMD ["/home/django/projectname/entrypoint.sh"]
EXPOSE 8000
