# Polyscripting RoadMap

This document outlines our developement plan from a high level.

This document has the potential to grow and evolve as we shift priorities and recieve feedback.

Scrambler hereby refers to the process of changing the C source code for the interpreter.
Transfromer hereby refers to the process of changing a php document to be able to be interpreted by the scrambled php interpreted.



### Robustify Transformer - Lexical Analysis
Currently we are working to make the transformer into a more robust version. Rather than using string replace, we are working on parsing PHP files to their AST and then pretty printing from there in order to allow for a more accurate transformation that accounts for different contexts.

### AST Scrambling - Grammar
Develope a method for scrambling the grammar of the php-src, and concurrently transform a document to match the scramble.

### Scramble built-in functions & built in Objects

### Pass .phpt source code tests
Eventually we would like our transformer to pass the tests and standards laid out in the php-src.

### Apply to other languages
After a PHP proof of concept is robust and resiliant, we will begin looking at how to apply a similar concept to SQL and other languages.
