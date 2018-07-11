#!/bin/bash
  
rm -r /php/expected
mkdir /php/expected

for file in *.php
do
        /polyscripted-php/bin/php $file > "/php/expected_test_output/${file}"
done

