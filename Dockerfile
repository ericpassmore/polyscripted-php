FROM golang
WORKDIR /go/src/github.com/polyverse/
COPY . .
RUN git clone https://github.com/polyverse/php-scrambler.git
WORKDIR ./php-scrambler
RUN git checkout 779e6567a7473b411fd7c231b8ef38ac8805fbb3
RUN go get -v .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build
WORKDIR /go/src/github.com/polyverse/
RUN git clone https://github.com/polyverse/tok-php-transformer.git
WORKDIR ./tok-php-transformer
RUN git checkout 76efde20927324fd84b2f800cc515c1d577ba633


FROM ubuntu

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

COPY scripts /php/
COPY --from=0 /go/src/github.com/polyverse/php-scrambler/php-scrambler /php/
COPY --from=0 /go/src/github.com/polyverse/tok-php-transformer/tok-php-transformer.php /php/
COPY --from=0 /go/src/github.com/polyverse/tok-php-transformer/snip-transform.php /php/


WORKDIR /php
RUN git clone https://github.com/php/php-src.git
ENV PHP_SRC_PATH /php/php-src/
