FROM golang
WORKDIR /go/src/github.com/polyverse/
COPY . .
RUN git clone https://github.com/polyverse/php-scrambler.git
WORKDIR ./php-scrambler
RUN go get -v .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build
WORKDIR /go/src/github.com/polyverse/
RUN git clone https://github.com/polyverse/tok-php-transformer.git


FROM ubuntu

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
      git \
      make \
      autoconf \
      gcc \
      re2c \
      bison \
      libxml2-dev \
      vim \
      ccache \
      apache2 \
      apache2-dev 

RUN a2dismod mpm_event && a2enmod mpm_prefork

COPY scripts /php/
COPY tok-php-transformer.php /php/
COPY snip-transform.php /php/
COPY --from=0 /go/src/github.com/polyverse/php-scrambler/php-scrambler /php/

WORKDIR /php
RUN git clone https://github.com/polyverse/php-src
