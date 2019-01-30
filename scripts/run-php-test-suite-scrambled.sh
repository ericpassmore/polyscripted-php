s_php tok-php-transformer.php -p $PHP_SRC_PATH --dump --replace --test --inc
cd $PHP_SRC_PATH
php run-tests.php -P $PHP_SRC_PATH/Zend/ -g FAIL
php run-tests.php -P $PHP_SRC_PATH/tests/ -g FAIL


