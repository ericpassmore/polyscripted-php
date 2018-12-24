FROM polyverse/ps-php7.2-apache:38bbbb695b9563e874eb0b5b8561e74d5111327d 

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
      git \
      make \
      autoconf \
      gcc \
      re2c \
      libsqlite3-dev \
	bison \
      libxml2-dev \
      vim \
      ccache \
      apache2 \
      apache2-dev 

RUN a2dismod mpm_event && a2enmod mpm_prefork

WORKDIR $PHP_SRC_PATH
RUN make install

COPY scripts /usr/local/bin/polyscripting/

ENV PHP_SRC_PATH /usr/src/php

ENTRYPOINT /usr/local/bin/polyscripting/
