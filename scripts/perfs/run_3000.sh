#!/bin/bash
  
i=0

while [ $i -lt 30000 ]
do

        /polyscripted-php/bin/php tests/php-tests.php >/dev/null 2>&1
        i=$[$i+1]

done

echo ran tests/php-testes $i times - standard php
