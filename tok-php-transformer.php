<?php

include 'snip-transform.php';
const LONG_OPTS = array("replace", "test", "dump");

set_error_handler("error_handle", E_USER_ERROR);

$replace = false;
$dump = false;
$extensions = array("php");
$root_path = "";
$out_path = "";
$num_ps = 0;


arg_parse(getopt("p:", LONG_OPTS));


echo "Polyscript from dir " . $root_path . " to dir:" . $out_path, PHP_EOL;

if (!is_dir($out_path))
{
    polyscriptify($root_path, $out_path);
    return;
} else {
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($root_path, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::SELF_FIRST);

    foreach ($iterator as $fileInfo) {
        $fileOut = str_replace($root_path, $out_path, $fileInfo);
        if (in_array(pathinfo($fileInfo, PATHINFO_EXTENSION), $extensions)) {
            if ($dump) {
                echo "Polyscripting $fileInfo \n";
            }
            polyscriptify($fileInfo, $fileOut);
            $num_ps++;
        } else if (is_dir($fileOut)) {
            continue;
        } else if ($fileInfo->isDir() && !$replace) {
            mkdir($fileOut);
        } else if (!$replace) {
            copy($fileInfo, $fileOut);
        }
    }
}

echo "Done. Polyscripted " . $num_ps . " files\n";

function arg_parse($opts)
{
    global $dump, $root_path, $out_path, $replace;

    if ($opts['p']==NULL) {
        trigger_error("Missing required argument: '-p'", E_USER_ERROR);
    }

    //Parse
    $replace = array_key_exists("replace", $opts);
    $dump = array_key_exists("dump", $opts);
    get_ext($opts);

    //Path handle
    $root_path = rtrim($opts['p'], '/');

    if (file_exists($root_path)) {
        $out_path = $replace ? $root_path : get_out_root($root_path);
    } else {
        trigger_error("Invalid path or file.", E_USER_ERROR);
    }
}

function get_out_root($root)
{
    $path_out = pathinfo($root, PATHINFO_DIRNAME) . "/" . pathinfo($root, PATHINFO_FILENAME) . "_ps";

    if (is_dir($root)) {
        if (!is_dir($path_out)) {
            mkdir($path_out);
        }
        return $path_out;
    } else {
        return $path_out . "." . pathinfo($root, PATHINFO_EXTENSION);
    }
}

function get_ext($opts)
{
    global $extensions;
    if (array_key_exists("test", $opts)) { array_push($extensions, "phpt"); }
    if (array_key_exists("phar", $opts)) { array_push($extensions, "inc"); }
}

function polyscriptify($file_name, $fileOut)
{
    $file_str = token_get_all(file_get_contents($file_name));
    $fp = fopen($fileOut, 'w');
    fwrite($fp, poly_snip($file_str));
    fclose($fp);
}

function error_handle($errno, $errstr) {
    echo "Error: [$errno] $errstr\n";
    echo "Failing.";
    die();
}