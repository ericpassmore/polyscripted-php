cd $POLYSCRIPT_PATH
if [ -f "scrambled.json" ]; then
	s_php tok-php-transformer.php -p $POLYSCRIPT_PATH/tests/
	s_php tok-php-transformer.php -p $POLYSCRIPT_PATH/util/evalExploit.php
else
	echo "PHP is not scrambled - build polyscripted php before building out tests." 
fi
