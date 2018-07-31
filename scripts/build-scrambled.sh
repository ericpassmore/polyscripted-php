#!/bin/bash

./resetPhp/reset-php.sh
./php-transformer -phar -replace /php/php-src/ext/phar


./php-scrambler

cd php-src
make install -k
