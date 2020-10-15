FROM archlinux
LABEL MAINTAINER Guillermo Adrián Molina <guillermoadrianmolina@hotmail.com>

RUN pacman -Syu --noconfirm php-apache php-gd

WORKDIR /srv/http

RUN \
    curl -s https://wordpress.org/latest.tar.gz | tar xz --strip-components=1 && \
    sed -i 's/LoadModule mpm_event_module/#LoadModule mpm_event_module/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/#LoadModule mpm_prefork_module/LoadModule mpm_prefork_module/g' /etc/httpd/conf/httpd.conf && \
    sed -i 's/\/var\/log\/httpd\/error_log/\/dev\/stderr/g' /etc/httpd/conf/httpd.conf && \
    echo "TransferLog /dev/stdout" >> /etc/httpd/conf/httpd.conf && \
    echo "ServerName Guillermo" >> /etc/httpd/conf/httpd.conf && \
    echo "LoadModule php7_module modules/libphp7.so" >> /etc/httpd/conf/httpd.conf && \
    echo "Include conf/extra/php7_module.conf" >> /etc/httpd/conf/httpd.conf && \
    sed -i "s/;extension=pdo_mysql/extension=pdo_mysql/g" /etc/php/php.ini && \
    sed -i "s/;extension=mysqli/extension=mysqli/g" /etc/php/php.ini && \
    sed -i "s/;extension=gd/extension=gd/g" /etc/php/php.ini

    
EXPOSE 80

CMD [ "/usr/bin/httpd", "-DFOREGROUND" ]