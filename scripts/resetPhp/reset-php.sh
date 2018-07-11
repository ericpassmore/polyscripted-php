#!/bin/bash

cp /php/resetPhp/zend_language_parser.y /php/php-src/Zend/
cp /php/resetPhp/zend_language_scanner.l /php/php-src/Zend/
cp -r /php/resetPhp/phar /php/php-src/ext/phar

if [[ $1 == "-revert" ]]; then
        cd /php/tests/
	for file in * 
	do
		if [[ $file == ps-* ]]
		then	
			rm $file
		fi
	done
	cd /php/php-src/
        make install
fi
