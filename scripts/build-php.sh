#!/bin/bash

cp -r /php/php-src/ext/phar /php/resetPhp
  
echo "You can specify a git ref to build from my passing a parameter."

cd ./php-src
git pull

if [[ "$1" != "" ]]; then
        echo "You have specified git ref $1"
        echo "Checking out php source to that ref."
        git checkout "$1"
fi

./buildconf --force

sed 's/PHP_EXTRA_VERSION=.*/PHP_EXTRA_VERSION=-polyscripted/' configure > configure.polyscripted
yes | cp configure.polyscripted configure

./configure \
  --without-pear \
  --exec-prefix=/polyscripted-php \
  --prefix=/polyscripted-php \
  --with-apxs2

make install

cd /php/tests
./get-expected-out.sh
rm get-expected-out.sh

cd /polyscripted-php
find . -type d -empty -delete
