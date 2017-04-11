<?php
include_once 'PiAP-config.php';

// paranoia is a virtue

//xss mitigation function from OSWAP cheetsheet
function xssafe($data, $encoding='UTF-8')
{
	return htmlspecialchars($data,ENT_QUOTES | ENT_HTML5,$encoding);
}

function xecho($data)
{
	echo xssafe($data);
}

function checkIntegerRange($int, $min, $max)
{
    if (is_string($int) && !ctype_digit($int)) {
        return false; // contains non digit characters
    }
    if (!is_int((int) $int)) {
        return false; // other non-integer value or exceeds PHP_MAX_INT
    }
    return ($int >= $min && $int <= $max);
}

function strip_output($evildata, $encoding='UTF-8')
{
	return strip_tags(htmlentities($evildata,ENT_QUOTES | ENT_HTML5,$encoding));
}

function strip_input($evildata)
{
	$tained_str = filter_var($evildata,FILTER_SANITIZE_STRING);
	if (is_string($tained_str) === true) {
		return $tained_str;
	} else {
		return "";
	}
}

function scrub_input($evildata, $encoding='UTF-8')
{
	return preg_replace("/[^a-zA-Z0-9_\-]+/", '', strip_input($evildata));
}

//scrub to be alphanumeric
function scrub_hash($evilhash)
{
	return preg_replace("/[^a-zA-Z0-9]+/", '', strip_input($evilhash));
}
