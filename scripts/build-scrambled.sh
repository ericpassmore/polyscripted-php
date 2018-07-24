#!/bin/bash

./resetPhp/reset-php.sh

./scrambler
sed -i "i3 <?php" /php/php-src/ext/phar/build_precommand.php
sed -i "i18 ?>" /php/php-src/ext/phar/build_precommand.php
./php-transformer -phar -replace /php/php-src/ext/phar


sed -i "i3 ' ' " /php/php-src/ext/phar/build_precommand.php
sed -i "i18 ' ' " /php/php-src/ext/phar/build_precommand.php



cd php-src
make install -k
