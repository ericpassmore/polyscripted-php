#!/bin/bash
  
rm -rf /php/expected
mkdir /php/expected

for file in *.php
do
        /polyscripted-php/bin/php $file > "/php/expected/${file}"
done

