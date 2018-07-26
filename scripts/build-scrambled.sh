#!/bin/bash

./resetPhp/reset-php.sh

./php-scrambler
./php-transformer -phar -replace /php/php-src/ext/phar

cd php-src
make install -k
