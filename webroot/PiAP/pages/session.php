<?php
include_once 'PiAP-config.php';
include_once 'functions.php';
sec_session_start();
header("content-security-Policy: default-src 'none'; style-src 'self'");
header("content-type: text/html; charset=UTF-8");
if (login_check() !== true) {
	header("Location: /pages/index.php&error=1");
	exit();
};
