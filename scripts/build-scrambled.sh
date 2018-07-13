#!/bin/bash

./resetPhp/reset-php.sh

./scrambler

rm -rf /php/php-src/ext/phar/pharTemp
./php-transformer -replace /php/php-src/ext/phar
mkdir /php/php-src/ext/phar/pharTemp
mv /php/php-src/ext/phar/phar.php /php/php-src/ext/phar/pharTemp/phar.php


cd php-src
make install -k

cd /polyscripted-php
find . -type d -empty -delete

cd /php
./php-transformer /php/tests
./php-transformer /php/xtra/evalTest
