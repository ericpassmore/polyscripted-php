#!/bin/bash

./resetPhp/reset-php.sh

./php-scrambler

/php/php tok-php-transformer.php -p /php/php-src/ext/phar --replace --inc --phar

cd php-src
make install -k

cd ..
/php/php tok-php-transformer.php -p /php/php-src/ext/phar --replace

cd php-src
make install
