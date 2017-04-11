<?php

include_once 'session.php';
sec_session_start();

// Unset all session values
$_SESSION = array();

// Clear the session cookie.
$params = session_get_cookie_params();
$name = session_name();
setcookie ($name, '', 1);
setcookie ($name, false);
unset($_COOKIE[$name]);
// clean even the session name, leave no suspects
unset($name);
// clean even the params, leave no evidence
unset($params);

// Destroy session
session_unset();
session_destroy();
// Go away
header("Location: /pages/index.php");
exit();
