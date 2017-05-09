<?php
include_once 'PiAP-config.php';
include_once 'paranoia.php';
include_once 'functions.php';

function uptime_status() {
	exec(sprintf('uptime -p'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<p>PiAP have has been ";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= xssafe($res[$num]) . "\n";
		};
		$blob .= "</p>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function memory_status() {
	exec(sprintf('../bin/memory_status_table.bash'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div>";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";
		};
		$blob .= "</div>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function entropy_status() {
	exec(sprintf('/usr/lib/nagios/plugins/check_entropy'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<pre class=\"box\">Entropy ";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= xssafe($res[$num]) . "\n";
		};
		$blob .= "</pre>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function disk_space_status() {
	exec(sprintf('df -h'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<pre class=\"box\">";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= xssafe($res[$num]) . "\n";
		};
		$blob .= "</pre>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function disk_status() {
	exec(sprintf('../bin/disk_status_table.bash'), $res, $rval);;
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

function temperature_status() {
	exec(sprintf('../bin/temperature_status.bash'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div id=\"temperature_box\">";
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";
		};
		$blob .= "</div>";
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function firewall_status() {
	exec(sprintf('../bin/fw_status_table.bash'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div class=\"row\">";;
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";;
		};
		$blob .= "</div>";;
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

function user_list() {
	exec(sprintf('python3 -m piaplib.pocket lint check users --list 2>/dev/null ;'), $res, $rval);;
	if ($rval === 0) {
		return $res;;
	}
	else {
		return array();;
	}
}

function user_status() {
	exec(sprintf('python3 -m piaplib.pocket lint check users --all --html 2>/dev/null ;'), $res, $rval);;
	if ($rval === 0) {
		$blob = "<div class=\"row\">";;
		for ($num = 0; $num < count($res) ; $num++) {
			$blob .= $res[$num] . "\n";;
		};
		$blob .= "</div>";;
		return $blob ;;
	} else {
		return tool_error_msg("Server error. (tool_bug) 500");
	}
}

