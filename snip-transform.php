<?php
/**
 * Created by PhpStorm.
 * User: bluegaston
 * Date: 9/28/18
 * Time: 11:30 AM
 */
const IGNORE = array(T_STRING, T_INLINE_HTML, T_CONSTANT_ENCAPSED_STRING, T_START_HEREDOC, T_END_HEREDOC, T_COMMENT);
$keys_ps_map = json_decode(file_get_contents("scrambled.json"), TRUE);

function poly_snip($snip)
{
    $tokens = token_get_all($snip);
    $snipOut = "";

    foreach ($tokens as $token) {
        if (!is_array($token)) {
            $snipOut .= $token;
        } else {
            $snipOut .= get_tok_val($token);
        }
    }
    return $snipOut;
}


function get_tok_val($token)
{
    global $keys_ps_map;

    $cast = false;
    $tok_name = token_name($token[0]);
    $tok_str =  strtolower($token[1]);
    $tok_len = strlen($tok_str) - 1;

    //account for syntax of casting
    if ($tok_str[0] == "(" && $tok_str[$tok_len] == ")" && strpos($tok_name, "_CAST")) {
        $cast = true;
        $tok_str = trim($tok_str, "( )");
    }


    if (in_array($token[0], IGNORE) || !isset ($keys_ps_map[$tok_str])) {
        return $token[1];
    } else if ($cast) {
        return "(" . $keys_ps_map[$tok_str] . ")" ;
    } else {
        return $keys_ps_map[$tok_str];
    }
}
