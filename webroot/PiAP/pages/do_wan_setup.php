<?php

include 'session.php';
include_once 'PiAP-wan-setup.php';

if (login_check() != true) {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=You are not authorized to view this page. Please Log in. (crypt_auth) 406");
    exit();
}
else {
if (isset($_POST['target_ssid'])) {
	$ssid = filter_input(INPUT_POST, 'target_ssid', FILTER_SANITIZE_STRING);;
	$passphrase = '';;
	if (isset($_POST['target_ssid'], $_POST['challenge'])) {
	$challenge = filter_input(INPUT_POST, 'challenge', FILTER_SANITIZE_STRING);;
	}
	if (changeWiFi($ssid, $challenge) === true) {
		// configure success
		header("Location: https://pocket.PiAP.Local/pages/wan_setup.php?wan_success=1");;
		exit();
	} else {
		// configure failed
		header("Location: https://pocket.PiAP.Local/pages/wan_setup.php?wan_error=1");;
		exit();
	}
 } else {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=Could not configure Wan settings. (tool bug) 500");
    exit();
 }
};

