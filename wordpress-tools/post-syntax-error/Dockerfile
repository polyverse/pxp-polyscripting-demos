FROM polyverse/polyscripted-wordpress:debian-73c14657d70afae3b87de99d263eb3e87e2f681a 

RUN apt-get update && \
    apt-get install -y mysql-server wget less pwgen && \
    mysql_install_db

RUN wget -O wp.phar https://github.com/wp-cli/wp-cli/releases/download/v2.0.1/wp-cli-2.0.1.phar && \
    mv wp.phar /usr/local/bin

COPY wordpress /wordpress
COPY scripts/* /usr/local/bin/
COPY apache2 /etc/apache2
