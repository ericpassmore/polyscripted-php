#!/bin/bash
  
i=0

while [ $i -lt 30000 ]
do
        /polyscripted-php/bin/php /php/tests/php-tests.php >/dev/null
	i=$((i+1))
done

echo ran tests/php-testes $i times - standard php
