<?php

include_once 'PiAP-config.php';
include_once 'functions.php';

sec_session_start();

if (isset($_POST['username'], $_POST['p'])) {
	$username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);;
	$passphrase = filter_input(INPUT_POST, 'p', FILTER_SANITIZE_STRING);;

	if (login($username, $passphrase) === true) {
		// Login success
		header("Location: /pages/dashboard.php");
		exit();
	} else {
		// Login failed
		header("Location: /pages/index.php?error=1");
		exit();
	}
} else {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=Could not process login (crypt_auth) 500");
    exit();
}
