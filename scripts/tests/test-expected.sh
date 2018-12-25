#!/bin/bash
  
find $POLYSCRIPT_PATH/tests_ps -name '*.php' -type f | while read file
do
        echo TEST $file
        base=$(basename $file)
	diff <(php $file) $POLYSCRIPT_PATH/expected/$base
done

