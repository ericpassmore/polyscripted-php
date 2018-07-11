#!/bin/bash
 
 
./resetPhp/reset-php.sh

if [[ $1 = "-t" ]]
then
	cd tests
	./get-expected-out.sh
cd ..
fi

./scrambler

./php-transformer /php/php-src/ext/phar -replace=true

cd php-src
./buildconf
make install -k

cd /polyscripted-php
find . -type d -empty -delete

