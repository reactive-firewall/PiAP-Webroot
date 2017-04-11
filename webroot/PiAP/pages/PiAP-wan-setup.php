<?php
include_once 'PiAP-config.php';

function changeWiFi($ssid, $secret) {
	exec(sprintf('../bin/updateWiFi.bash %s %s ;', escapeshellarg($ssid), escapeshellarg($secret)), $res, $rval);;
	if ($rval === 0) {
		return true;;
	} else {
		return false;;
	}
}
