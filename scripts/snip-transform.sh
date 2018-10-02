#!/bin/bash
  
echo $SNIP;

if [ -f /php/scrambled.json ]; then
        /php/php tok-php-transformer.php -s $SNIP
else
        echo $SNIP
fi

unset $SNIP
