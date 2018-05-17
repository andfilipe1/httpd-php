FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40 


RUN yum -y --setopt=tsflags=nodocs install httpd && \
    yum -y --setopt=tsflags=nodocs install nano && \
    yum -y --setopt=tsflags=nodocs install php-fpm  php libapache2-mod-php php-mcrypt php-mysql

EXPOSE 80

# Script de inicialização simples para evitar alguns problemas observados com a reinicialização do contêinerart

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
ADD info.php /var/www/html

#CMD sudo systemctl restart httpd.service
CMD ["/run-httpd.sh"]
CMD cp /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.old
CMD cp /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/userdir.conf.old
CMD cp /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.old

WORKDIR /etc/httpd


#yum -y --setopt=tsflags=nodocs install php php-mysql && \
#yum clean all 
#yum -y --setopt=tsflags=nodocs  update && \
#docker run -d -p 80:80 andfilipe1/httpd