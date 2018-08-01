FROM golang
WORKDIR /go/src/github.com/polyverse/
COPY . .
RUN git clone https://github.com/polyverse/php-scrambler.git
WORKDIR ./php-scrambler
RUN go get -v .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build
ADD https://api.github.com/repos/polyverse/php-scrambler/git/refs/heads/master version.json

WORKDIR /go/src/github.com/polyverse
ADD https://api.github.com/repos/polyverse/php-transformer/git/refs/heads/master version.json


RUN git clone https://github.com/polyverse/php-transformer.git
WORKDIR ./php-transformer
RUN go get -v .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build


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
COPY --from=0 /go/src/github.com/polyverse/php-transformer/php-transformer /php/
COPY --from=0 /go/src/github.com/polyverse/php-scrambler/php-scrambler /php/
WORKDIR /php
RUN git clone https://github.com/php/php-src.git

