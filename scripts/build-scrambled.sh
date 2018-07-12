#!/bin/bash
 
 
./resetPhp/reset-php.sh

if [[ $1 = "-t" ]]
then
	cd tests
	./get-expected-out.sh
cd ..
fi

./scrambler


cd php-src
./buildconf
make install -k

./php-transformer -k /php/php-src/ext/phar

cd php-src
make install -k

cd /polyscripted-php
find . -type d -empty -delete

cd /php
./php-transformer tests
