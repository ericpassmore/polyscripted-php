#!/bin/bash

./resetPhp/reset-php.sh

./php-scrambler

cd php-src
make install -k
