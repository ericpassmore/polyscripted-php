## Welcome to the Polyscripting Playground

From within the Docker container here are the steps to running polyscripted php.

Install standard php configured to support Polyscripting:

``` ./build-php.sh```

This command also creates a directory /php/expected/ that will hold the expected output (before scrambling) of files within /php/tests

Next, to build a scrambled version of php:

```./build-scrambled.sh```

Note: You can build a newly scrambled version of php at any time with
the build-scrambled script.

Now to the fun stuff.
Notice that if you try to run a php program within the tests directory, you will be hit with some parse error:

 ```/polyscripted-php/bin/php tests/smallWorld.php```

  Parse error: syntax error, unexpected 'as'

Because php no longer recognizes its standard keywords.

To transform your php files to their polyscripted version use the executable ./php-transformer :

``` ./php-transformer <path>```

Here's an example:

``` ./php-transformer /php/xtra/evalTest```

To transform all files within the tests folders run 

```./build-tests.sh```

This will generate a new directory with an appended -ps to the root directory name. All files will be copied to the new directory and it will maintain its structure, with the new scrambled php.
If you'd like to overwrite the original directory use the option -replace

``` ./php-transformer -replace tests/smallWorld.php```

To run the newly created files use /polyscripted-php/bin/php where you would
typically use the php command.

```/polyscripted-php/bin/php tests-ps/smallWorld.php```

This will use polyscripted php to interpret your file.

If you ran the -t option when scrambling your build you can see the difference
in the outputs of using standard php and scrambled php by using the command:

```diff <(/polyscripted-php/bin/php tests-ps/smallWorld.php) expected/smallWorld.php```


Feel free to try it out with your own php files. 
There's also a small program with an eval vulnerability in xtra/evalTest/evalExploit.php if you're unfamiliar with code injection attacks, then run this with standard php first. Then scramble it up, and see what you can't do.

Note: You can build a newly scrambled version of php at any time with
the build-scrambled script, but if you'd like to revert back to standard php
to run your original programs or generate new tests expected outputs you can run
the reset-php.sh with the -revert option.

To revert back to standard php use the command:

``` ./resetPhp/reset-php.sh -revert```
