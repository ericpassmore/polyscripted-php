#!/bin/bash

./resetPhp/reset-php.sh

./scrambler
./php-transformer -phar -replace /php/php-src/ext/phar

cd php-src
make install -k
