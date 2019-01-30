FROM polyverse/ps-php7.2-apache:95206c2063c57fd02f112547a5a7023f920eec29

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

COPY ./scripts/ /usr/local/bin/polyscripting/

WORKDIR /usr/local/bin/polyscripting/

ENV POLYSCRIPT_PATH /usr/local/bin/polyscripting
ENV PHP_SRC_PATH $PHP_SRC_PATH

RUN $POLYSCRIPT_PATH/util/ps-config.sh


