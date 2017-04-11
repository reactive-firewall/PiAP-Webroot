<?php

include_once 'PiAP-config.php';
include_once 'session.php';
include_once 'functions.php';
include_once 'PiAP-lan-setup.php';

if (login_check() != true) {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=You are not authorized to view this page. Please Log in. (crypt_auth) 406");
    exit();
}
else {
if (isset($_POST['input_ssid'], $_POST['challenge'])) {
	$ssid = filter_input(INPUT_POST, 'input_ssid', FILTER_SANITIZE_STRING);;
	$passphrase = filter_input(INPUT_POST, 'challenge', FILTER_SANITIZE_STRING);;

	if (changePiAP($ssid, $passphrase) === true) {
		// configure success
		header("Location: /pages/lan_setup.php?lan_success=1");
		exit();
	} else {
		// configure failed
		header("Location: /pages/lan_setup.php?lan_error=1");
		exit();
	}
 } else {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=Could not configure lan settings (Tool Bug) 500");
    exit();
 }
};

