#!/bin/bash

./php-scrambler

/php/php tok-php-transformer.php -p "$PHP_SRC_PATH"ext/phar --replace --inc --phar

cd $PHP_SRC_PATH
make install -k

cd ..
/php/php tok-php-transformer.php -p "$PHP_SRC_PATH"ext/phar --replace

cd $PHP_SRC_PATH
make install -k

cd ..
/php/php tok-php-transformer.php -p "$PHP_SRC_PATH"ext/phar/phar.php --replace

cd $PHP_SRC_PATH
make install
