<?php

include_once 'PiAP-config.php';
include_once 'functions.php';

sec_session_start();

// might add this
if (login_check() !== true) {
	header("Location: /pages/index.php");
	exit();
};

