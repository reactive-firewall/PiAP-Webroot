<?php
include_once 'PiAP-config.php';
include_once 'functions.php';

function client_list() {
	exec(sprintf('../bin/client_status_table.bash'), $res, $rval);;
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
	exec(sprintf('../bin/interface_list.bash'), $res, $rval);;
	if ($rval === 0) {
			return $res;;
	} else {
		return array();;
	}
}

function interface_status() {
	$the_iface_list = interface_list();;
	$blob = "<table class=\"table table-striped\">";
	$blob .= "<thead><th>Interface</th><th>MAC</th><th>IP Addresses</th><th>Status</th></thead><tbody>";
	foreach ($the_iface_list as $iface_name) {
		$res = "";;
		exec(sprintf('../bin/interface_status.bash %s', strip_input($iface_name)), $res, $rval);;
		if ($rval === 0) {
			for ($num = 0; $num < count($res) ; $num++) {
				$blob .= "" . $res[$num] . "\n";;
			};
		} else {
			return tool_error_msg("Server error. (tool_bug) 500");
		}
	};
	$blob .= "</tbody>";
	$blob .= "</table>";;
	return $blob;;
}

