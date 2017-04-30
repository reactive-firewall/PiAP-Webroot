<?php

include_once 'PiAP-config.php';
include_once 'functions.php';
include 'session.php';

if (login_check() === true){

	function power_down() {
		exec(sprintf('../bin/power_off.bash'), $res, $rval);;
		if ($rval === 0) {
			return true;;
		}else {
			return false;;
		}
	}

	if (power_down() === true) {
		// tool success
		header("Location: /pages/logout.php");
		exit();
	} else {
		// tool failed
		header("Location: /pages/error.php?err=Could not shutdown. Pull the plug. (bad_tool) 500");
		exit();
	}
} else {
	// login first
	header("Location: /pages/index.php?error=1");
	exit();
}
