<?php

include_once 'PiAP-config.php';
include_once 'functions.php';
include 'session.php';

if (login_check() === true){

	function generate_x509() {
		exec(sprintf('../bin/generate_user_x509.bash %s 2>/dev/null > /dev/null;', escapeshellarg(getUserName())), $res, $rval);;
		if ($rval === 0) {
			return true;;
		}else {
			return false;;
		}
	}

	if (generate_x509() === true) {
		// tool success
		if ( file_exists("../files/db/x509/" . get_user_id(getUserName(), get_pepper()) . ".p12") ) {
			header("Location: /pages/download_x509.php");;
		}
		exit();
	} else {
		// tool failed
		if ( file_exists("../files/db/x509/" . get_user_id(getUserName(), get_pepper()) . ".p12") ) {
			header("Location: /pages/download_x509.php");
		} else {
			header("Location: /pages/error.php?err=Could not generate x509. (bad_tool) 500");
		}
		exit();
	}
} else {
	// login first
	header("Location: /pages/index.php?error=1");
	exit();
}
