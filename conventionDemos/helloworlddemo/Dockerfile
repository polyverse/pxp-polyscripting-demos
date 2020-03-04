FROM polyverse/ps-php7.2-apache-demo:33bf972c0f240d1b66d5746f38f7237c551c5f41

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
      git \
	wget \
      autoconf \
      gcc \
      re2c \
      libsqlite3-dev \
	make \
	bison \
      libxml2-dev \
      vim \
      ccache \
      apache2 \
	dpkg \
      apache2-dev 
RUN wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb

RUN dpkg -i bat_0.11.0_amd64.deb

RUN a2dismod mpm_event && a2enmod mpm_prefork

WORKDIR /usr/local/bin/polyscripting/

ENV POLYSCRIPT_PATH /usr/local/bin/polyscripting
ENV PHP_SRC_PATH $PHP_SRC_PATH

COPY ./util/evalExploit.php /usr/local/bin/polyscripting
COPY ./util/gramscram.php /usr/local/bin/polyscripting
COPY ./util/gramtest.php /usr/local/bin/polyscripting
COPY ./util /usr/local/bin/polyscripting/util

RUN $POLYSCRIPT_PATH/util/ps-config.sh

WORKDIR $PHP_SRC_PATH
RUN make install

WORKDIR /usr/local/bin/polyscripting/
