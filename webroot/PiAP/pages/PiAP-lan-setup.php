<?php
include_once 'PiAP-config.php';
include_once 'functions.php';

function changePiAP($ssid, $secret) {
	exec(sprintf('../bin/updatePiAP.bash %s %s ;', escapeshellarg($secret), escapeshellarg($ssid)), $res, $rval);;
	if ($rval === 0) {
		return true ;;
	} else {
		header("Location: /pages/error.php?err=Server Refused. (tool_bug) 500");
		exit();
	}
}
