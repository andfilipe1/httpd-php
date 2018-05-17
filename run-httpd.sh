#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.

cp /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.old
cp /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/userdir.conf.old
cp /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.old


rm -rf /run/httpd/* /tmp/httpd*

exec /usr/sbin/apachectl -DFOREGROUND

sudo systemctl restart httpd.service
