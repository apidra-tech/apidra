FROM zelal/c7-systemd-v1:nano_wget
RUN yum -y install httpd; yum clean all

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN yum-config-manager --enable remi-php72

RUN yum -y install php
RUN yum -y install php-pdo
RUN yum -y install php-pear
RUN yum -y install php-devel
RUN yum -y install php-mysql
RUN yum -y install php-zip
RUN yum -y install php-mbstring
RUN yum -y groupinstall "Development Tools"

RUN curl -sL https://rpm.nodesource.com/setup_13.x | bash -
RUN yum -y install nodejs

RUN yes | pecl install xdebug \
&& echo "zend_extension=$(find /usr/lib64/php/modules/ -name xdebug.so)" > /etc/php.d/xdebug.ini \
&& echo "xdebug.remote_enable=1" >> /etc/php.d/xdebug.ini \
&& echo "xdebug.remote_autostart=1" >> /etc/php.d/xdebug.ini \
&& echo 'xdebug.remote_port=9100' >> /etc/php.d/xdebug.ini \
&& echo 'xdebug.idekey="PHPSTORM"' >> /etc/php.d/xdebug.ini \
&& echo 'xdebug.remote_connect_back=1' >> /etc/php.d/xdebug.ini \
&& echo "xdebug.remote_host=host.docker.internal" >> /etc/php.d/xdebug.ini \
fi;

RUN systemctl enable httpd.service

EXPOSE 80
CMD ["/usr/sbin/init"]