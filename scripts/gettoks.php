<?php
/**
 * Created by PhpStorm.
 * User: bluegaston
 * Date: 1/23/19
 * Time: 4:37 PM
 */


$f = getopt("f:");
$f = $f['f'];

$string = file_get_contents($f);

$tokens = token_get_all($string);

foreach ($tokens as $token) {
    if (is_array($token)) {
        echo "Line {$token[2]}: ", token_name($token[0]), " ('{$token[1]}')", PHP_EOL;
    } else {
	    echo "TOKEN $token", PHP_EOL ;
}
}
