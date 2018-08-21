# Polyscripting RoadMap

This document outlines our developement plan from a high level.

This document has the potential to grow and evolve as we shift priorities and recieve feedback.

Scrambler hereby refers to the process of changing the C source code for the interpreter.
Transfromer hereby refers to the process of changing a php document to be able to be interpreted by the scrambled php interpreted.

## WORDPRESS
Current project 8/20/18: 
Applying Polyscripting to WordPress to demonstrate the protection against the risks of the recently announced and unfixed php vulnerablitiy:
https://www.bleepingcomputer.com/news/security/php-deserialization-issue-left-unfixed-in-wordpress-cms/

### MediaWiki
Generating recipes for other apps to easily apply polyscripting


### AST Scrambling - Grammar
Develope a method for scrambling the grammar of the php-src, and concurrently transform a document to match the scramble.

### Scramble built-in functions & built in Objects
Scramble functions that are not reserved keywords

### Apply to other languages
After a PHP proof of concept is robust and resiliant, we will begin looking at how to apply a similar concept to SQL and other languages.


#### Other Goals
-Fix php-src compile time issues 
-Pass .phpt within php-src test
