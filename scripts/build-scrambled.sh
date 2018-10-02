#!/bin/bash

./resetPhp/reset-php.sh

./php-scrambler

cp snip-transformer.php php-src/ext/phar/

/php/php tok-php-transformer.php -p /php/php-src/ext/phar --replace --phar

cd php-src
make install -k
