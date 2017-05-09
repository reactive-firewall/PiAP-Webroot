<?php
include_once 'PiAP-config.php';
include_once 'paranoia.php';
include_once 'functions.php';

function client_list() {
	exec(sprintf('../bin/client_status.bash'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div class=\"row\">";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";
		};
		$blob .= "</div>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function wifi_list() {
	exec(sprintf('../bin/scan_the_air.bash'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div class=\"row\">";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";
		};
		$blob .= "</div>";
				return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function interface_list() {
	$blob = "";
	exec(sprintf('python3 -m piaplib.pocket lint check iface --list ;'), $res, $rval);;
	if ($rval === 0) {
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= "" . $res[$num] . "\n";;
		};
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");;
	}
	return $blob;;
}

function interface_status() {
	$blob = "";
	exec(sprintf('python3 -m piaplib.pocket lint check iface --all --html ;'), $res, $rval);;
	if ($rval === 0) {
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= "" . $res[$num] . "\n";;
		};
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
	return $blob;;
}

