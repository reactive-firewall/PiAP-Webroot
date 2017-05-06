<?php
include_once 'PiAP-config.php';
include_once 'functions.php';

function updatePiAP() {
	exec(sprintf('python3 -m piaplib.pocket pku update --all || false ;'), $res, $rval);;
	if ($rval === 0) {
		return true ;;
	} else {
		header("Location: /pages/error.php?err=Server Refused. (tool_bug) 500");
		exit();
	}
}
