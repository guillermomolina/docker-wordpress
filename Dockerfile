#-----------------------------------------------------------------------------
#
#  Copyright (c) 2020-2020, Guillermo Adrián Molina
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#
#  1. Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
#  THE POSSIBILITY OF SUCH DAMAGE.
#
#-----------------------------------------------------------------------------

FROM archlinux
LABEL MAINTAINER Guillermo Adrián Molina <guillermoadrianmolina@hotmail.com>

RUN pacman -Syu --noconfirm php-apache php-gd

WORKDIR /srv/http

RUN \
    curl -s https://wordpress.org/latest.tar.gz | tar xz --owner=33 --group=33 --strip-components=1 && \
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