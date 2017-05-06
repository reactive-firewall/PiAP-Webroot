<?php

include_once 'PiAP-config.php';
include_once 'session.php';
include_once 'paranoia.php';
include_once 'functions.php';
include_once 'PiAP-updates.php';

if (login_check() != true) {
    // The correct POST variables were not sent to this page.
    header("Location: /pages/error.php?err=You are not authorized to view this page. Please Log in. (crypt_auth) 406");
    exit();
}
else {
	if (updatePiAP() === true) {
		// configure success
		header("Location: /pages/updates.php?update_success=1");
		exit();
	} else {
		// configure failed
		header("Location: /pages/lan_setup.php?update_error=1");
		exit();
	}
};

