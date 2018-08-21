<?php

$ignore = array(T_STRING, T_INLINE_HTML, T_CONSTANT_ENCAPSED_STRING, T_START_HEREDOC, T_END_HEREDOC, T_COMMENT);

$valid_ext = array("php");

$long_opts = array("replace", "test");

$opts = getopt("p:", $long_opts);
$mode_replace = array_key_exists("replace", $opts);
if (array_key_exists("test", $opts)) { array_push($valid_ext, "phpt"); }
if (array_key_exists("phar", $opts)) { array_push($valid_ext, "inc"); }
$root_dir = $opts[p];

$out_dir = get_out_root($root_dir);
$dic_json = json_decode(file_get_contents("scrambled.json"), TRUE);



$iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($root_dir, FilesystemIterator::SKIP_DOTS), RecursiveIteratorIterator::SELF_FIRST);
echo "Polyscript from dir " . $root_dir . " to dir:" . $out_dir, PHP_EOL;


foreach ($iterator as $fileInfo) {
    $fileOut = str_replace($root_dir, $out_dir, $fileInfo);
    if (in_array(pathinfo($fileInfo, PATHINFO_EXTENSION), $valid_ext)) {
        polyscriptify($fileInfo, $fileOut);
    } else if ($fileInfo->isDir() && !$mode_replace) {
        mkdir($fileOut);
    } else if (!$mode_replace) {
        copy($fileInfo, $fileOut);
    }
}


function get_out_root($root)
{
    global $mode_replace;
    $path = pathinfo($root, PATHINFO_DIRNAME);
    $base = pathinfo($root, PATHINFO_FILENAME);
    $ext = pathinfo($root, PATHINFO_EXTENSION);
    if ($mode_replace) {
        return $root;
    } else if (is_dir($root)) {
        $out = $path . "/" . $base . "_ps";
        delTree($out);  //This is dangerous and needs checking.
        mkdir($out);
        return $path . "/" . $base . "_ps";
    } else {
        return $path . "/" . $base . "_ps" . "." . $ext;
    }
}


function polyscriptify($file_name, $fileOut)
{

    global $ignore, $dic_json;
    $tokens = token_get_all(file_get_contents($file_name));

    $fp = fopen($fileOut, 'w');

    foreach ($tokens as $token) {
        if (is_array($token)) {
            if (in_array($token[0], $ignore) || is_null($dic_json[$token[1]])) {
                $out = $token[1];
            } else {
                $out = $dic_json[$token[1]];
            }

        } else {
            $out = $token;
        }
        fwrite($fp, $out);
    }
    fclose($fp);
}

function delTree($dir)
{
    if (is_dir($dir)) {
        $files = array_diff(scandir($dir), array('.', '..'));
        foreach ($files as $file) {
            (is_dir("$dir/$file")) ? delTree("$dir/$file") : unlink("$dir/$file");
        }
        return rmdir($dir);
    }
}
