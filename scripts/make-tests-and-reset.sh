#!/bin/bash
TEST=@1

cp -r $PHP_SRC_PATH/$TEST ./resetPhp/php-tests/
./build-scrambled.sh 
s_php tok-php-transformer.php -p $PHP_SRC_PATH/$TEST --test --inc
s_php tok-php-transformer.php -p $PHP_SRC_PATH/run-tests.php
cd $PHP_SRC_PATH
php run-tests_ps.php -P $PHP_SRC_PATH/{$TEST}_ps -g FAIL --show-diff
cd $POLYSCRIPT_PATH
cp scrambled.json lastdict.json
./util/resetPhp/reset-php.sh
