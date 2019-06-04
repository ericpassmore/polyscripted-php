#!/bin/bash
  
rm -rf $POLYSCRIPT_PATH/expected
mkdir $POLYSCRIPT_PATH/expected

find $POLYSCRIPT_PATH/tests -name '*.php' -type f | while read file
do
        base=$(basename $file)
	php $file > "$POLYSCRIPT_PATH/expected/$base"
done


