<?php
include_once 'PiAP-config.php';
include_once 'paranoia.php';

// logs errors for debugging
function log_error($some_msg) {
	$debug = true ;
	if ($debug) {
	error_log($some_msg, 0);;
	}
	return false;
}

function store_in_session($key,$value)
{
	if (isset($_SESSION))
	{
		$_SESSION[$key]=strip_input($value);
	}
}

function unset_session($key)
{
	$_SESSION[$key]=' ';
	unset($_SESSION[$key]);
}

function get_from_session($key)
{
	if (isset($_SESSION[$key]))
	{
		return strip_input($_SESSION[$key]);
	} else { return false; }
}

function http_method()
{
	if (isset($_SERVER['REQUEST_METHOD']))
	{
		$HTTP_Method = strip_input($_SERVER['REQUEST_METHOD']);
		if (xssafe($HTTP_Method) === 'GET'){
			return 'GET';;
		} else {
			if (xssafe($HTTP_Method) === 'POST'){
				return 'POST';;
			} else {
				if (xssafe($HTTP_Method) === 'HEAD'){
					return 'HEAD';;
				} else {
					return false;;
				}
			}
		}
	} else {  return false; }
}


function tool_error_msg($the_error_msg) {
	return '<div class=\"alert-error\"><div class=\"txt-alert\"><strong>Error</strong>' . strip_input($the_error_msg) . '</div></div>';
}

function nativehash($secret, $key) {
		exec(sprintf('../bin/saltify.py --msg %s --salt %s', escapeshellarg(strip_input($secret)), escapeshellarg(strip_input($key))), $res, $rval);;
	if ($rval === 0) {
		if ($res[0] != "") {
			return $res[0] ;;
		} else {
		header("Location: /pages/error.php?err=Server Refused. (crypt_weak) 406");
		exit();
		}
	} else {
		header("Location: /pages/error.php?err=Server Refused. (crypt_weak) 406");
		exit();
	}
}

function sec_session_start() {
	$session_name = SESSION_NAME;
	$secure = SECURE;
	// This stops JavaScript being able to access the session id.
	$httponly = true;

	if (http_method() === false) {
		header("Location: /pages/error.php?err=Could not initiate a safe session (http_head)");
		exit();
	} else {
		if (http_method() === 'HEAD') {
			header("Location: /pages/error.php?err=Could not initiate a safe session (http_head)");
			exit();
		}
	}
	// Forces sessions to only use cookies.
	if (ini_set('session.use_only_cookies', 1) === false) {
		header("Location: /pages/error.php?err=Could not initiate a safe session (ini_set)");
		exit();
	}

	// Gets current cookies params.
	$cookieParams = session_get_cookie_params();
	session_set_cookie_params($cookieParams["lifetime"], $cookieParams["path"], $cookieParams["domain"], $secure, $httponly);

	// Sets the session name to the one set above.
	session_name($session_name);

	session_start();			// Start the PHP session
	session_regenerate_id();	// regenerated the session, delete the old one.
	bindSessionToIP();
}

function get_pepper(){
	// check the pepper var is empty
	$pepper = "";;
	$file = fopen("../files/db/pepper", "r");;
	while(!feof($file))
	{
		$pepper = fgets($file);
	}
	fclose($file);;
	if ($pepper !== "") {
		return $pepper;;
	} else {
		header("Location: /pages/error.php?err=Security Error. Session not trusted. (crypt_weak) 406");
		exit();
		return "";;
	}
}

function get_salt($username, $pepper){
	// check the salt var is empty
	$salt = BADSALT;;
	// XSS protection as we might pass this value
	$username = scrub_hash($username);
	$the_user_id = get_user_id($username, $pepper);;
	exec(sprintf('../../dsauth.py --check --file ../files/db/passwd --user-id %s --pepper %s ;', escapeshellarg($the_user_id), escapeshellarg($pepper)), $res, $rval);
	if ($rval === 0) {
		$salt = $res[0] ;;
	}
	if ($salt !== BADSALT) {
		return $salt;;
	} else {
		log_error("Security Error. crypt_weak 406 - salt");;
		header("Location: /pages/error.php?err=Security Error. Server scoffed at us. (crypt_weak) 406");
		exit();
		return BADSALT;;
	}
}

function get_rows($username, $pepper){
	$username = scrub_input($username);
	$the_user_id = get_user_id($username, $pepper);;
	exec(sprintf('../../dsauth.py --check --file ../files/db/passwd --user-id %s --pepper %s 2>/dev/null;', escapeshellarg($the_user_id), escapeshellarg($pepper)), $res, $rval);
	$row_num = 0;;
	if ($rval === 0) {
		$row_num = 1;;
	}
	if ($row_num === 1) {
		return true;;
	} else {
		log_error("Security Error. auth_err 403 - username");;
		header("Location: /pages/error.php?err=Security Error. Please login. (auth_err) 403");
		exit();
		return false;;
	}
}

function get_user_id($username, $pepper){
	// XSS protection as we might pass this value
	$username = scrub_input($username);
	$the_user_id = BADID;
	exec(sprintf('../../dsauth.py --check --file ../files/db/passwd --username %s --pepper %s ', escapeshellarg($username), escapeshellarg($pepper)), $res, $rval);;
	if ($rval === 0) {
		$the_user_id = $res[0];;
		}
	if ($the_user_id !== BADID) {
		return scrub_hash($the_user_id);;
	} else {
		log_error("Security Error. auth_err 403 - userid");;
		header("Location: /pages/error.php?err=Security Error. Please login. (auth_err) 403");
		exit();
		return BADID;;
	}
}

function get_password($user_id){
	if ($user_id !== BADID) {
		$the_user_id = scrub_hash($user_id);;
		exec(sprintf('../../dsauth.py --check --file ../files/db/passwd --user-id %s ', escapeshellarg($the_user_id)), $res, $rval);;
		if ($rval === 0) {
			$the_password = $res[0];;
			return $the_password;;
		} else {
			// can never be too carefull
			unset($the_user_id);;
			log_error("Security Error. crypt_weak 406 - passwd");;
			header("Location: /pages/error.php?err=Security Error. The server said no. (crypt_weak) 406");
			exit();
		}
	} else {
		log_error("Security Error. crypt_weak 406 - passwd");;
		header("Location: /pages/error.php?err=Security Error. The server said no. (crypt_weak) 406");
		exit();
	}
}

function getIPAddress(){
	if (get_from_session('IP') != false) {
		return scrub_hash(get_from_session('IP'));;
	} else {
		return false;;
	}
}

function getRealIPAddress(){
	$RAWIP = scrub_input(getenv("REMOTE_ADDR"));;
	return $RAWIP;;
}

// function to help keep sessions on one ip from login
function bindSessionToIP(){
	if (getIPAddress() !== false) {
		$client_ip = scrub_hash(getIPAddress());
		$real_ip = scrub_hash(hash('sha512', getRealIPAddress() ));;
		if ( $client_ip === $real_ip ) {
			return true;;
		} else {
			log_error("Bug 1 is here with [" . $client_ip . "] != [" . $real_ip . "]");;
			// error case
			return false;;
		}
	} else {
		// start session
		store_in_session('IP', scrub_hash(hash('sha512', getRealIPAddress() )));;
		log_error("Bind to IP");;
		return false;;
	}
}

function checkaffinity() {
	$has_ip_affinity = bindSessionToIP();;
	if ($has_ip_affinity === true) {
		return true;;
	} else {
		return false;;
	}
}

function checkallergies($username){
	if (checkaffinity() === true) {
		//if (!isset($_SESSION['HTTP_USER_AGENT'])) {
			//log_error("Banner-Grab attack detected.");;
			// Somthing seems off. Time to panic!
			//return true;
		//} else {
			$attempts = get_brutes($username);;
			if ($attempts < 3) {
				return false;;
			} else {
				log_error("Brute force attack detected.");;
				return true;;
			}
		//}
	} else {
		// Somthing seems fake. Time to panic!
		return true;;
	}
}

function login($username, $password) {
	//pick the spices
	$pepper = get_pepper() ;
	$salt = get_salt($username, $pepper) ;
	if ($salt === BADSALT) {
		// no spice no nice
		unset($pepper);;
		unset($salt);;
		return false ;;
	} else {
		// spice is nice
		$one_row = get_rows($username, $pepper);
		$user_id = get_user_id($username, $pepper);
		// Spice things up, hash the given password.
		$password = nativehash(nativehash($password, $salt), $pepper);
		$db_password = get_password($user_id);
		// clear our plate
		$pepper = '';;
		unset($pepper);;
		$salt = BADSALT;;
		unset($salt);;
		if ($one_row === true) {
			// check the recipe
			if (checkallergies($user_id) === true) {
				// ugh, yuck
				unset($user_id);;
				$db_password = '';;
				unset($db_password);;
				return false;;
			} else {
				// taste test
				if ($db_password === $password) {
					// Sweet, it worked
					$user_browser = scrub_input(get_from_session('HTTP_USER_AGENT'));
					$user_id = scrub_input($user_id);
					store_in_session('user_id', $user_id);
					$username = scrub_input($username);
					store_in_session('username', $username);
					// this is totaly a CWE-310, need real client side encryption
					store_in_session('login_string', hash('sha512', $password . $user_browser));
					// clear the table
					$db_password = '';;
					unset($db_password);;
					$password = '';;
					unset($password);;
					// all done.
					return true;
				} else {
					// FOOD FIGHT
					//add_brutes($user_id);
					//$now = time();
					// clear the table
					// so swallow the key
					$db_password = '';;
					unset($db_password);;
					$password = '';;
					unset($password);;
					$user_id = '';;
					unset($user_id);;
					return false;
				}
			}
		} else {
			// No user exists. 
			return false;
		}
	}
	return false;
}

function login_check() {
	// Check if all session variables are set
	if (isset($_SESSION['user_id'], $_SESSION['username'], $_SESSION['login_string'])) {
		//if (!isset($_SESSION['HTTP_USER_AGENT'])){
			// Somthing seems off. Time to panic!
		//	return false;
		//}
		$user_id = get_from_session('user_id');
		$login_string = get_from_session('login_string');
		$username = get_from_session('username');
		$user_browser = scrub_input(get_from_session('HTTP_USER_AGENT'));;
		$pepper = get_pepper() ;;
		$db_password = get_password($user_id);
		$login_check = hash('sha512', $db_password . $user_browser);;
		$db_password = false;
		unset($db_password);
		$pepper = false;
		unset($pepper);
		// and check
		if ($login_check === $login_string) {
			// can never be too careful
			$login_check = '';;
			unset($login_check);;
			// Logged In!!!!
			return true;
		} else {
			// can never be too careful
			$login_check = '';;
			unset($login_check);;
			// Not logged in
			return false;
		}
	} else {
		// Not logged in
		return false;
	}
	// Not logged in
	return false;
}

function get_brutes($badguy){
	$brute = 0;
	$file = @fopen("../files/db/brutes/" . escapeshellarg(hash('sha512', scrub_input($badguy))), "r");;
	if ($file != false) {
		while(!feof($file))
		{
			$brute = fgets($file);
		}
		fclose($file);
	};
	$brute = preg_match('/^[0-9]+$/', $brute);;
	if (checkIntegerRange($brute, 0, 5)) {
		return $brute;;
	} else {
		return 0;;
	}
}

function add_brutes($badguy){
	$attempt = get_brutes($badguy);;
	if (checkIntegerRange($attempt, 0, 5)) {
		$attempt = ($attempt + 1);;
		file_put_contents('../files/db/brutes/' . escapeshellarg(hash('sha512', scrub_input($badguy))), $attempt, FILE_APPEND | LOCK_EX );;
	};; // else overflow protect might be DoS attack
	return false;
}


function esc_url($url) {

	if ('' === $url) {
		return $url;
	}

	$url = preg_replace('|[^a-z0-9-~+_.?#=!&;,/:%@$\|*\'()\\x80-\\xff]|i', '', $url);

	$strip = array('%0d', '%0a', '%0D', '%0A');
	$url = (string) $url;

	$count = 1;
	while ($count) {
		$url = str_replace($strip, '', $url, $count);
	}

	// $url = str_replace(';//', '://', $url);

	$url = htmlentities($url);

	$url = str_replace('&amp;', '&#038;', $url);
	$url = str_replace("'", '&#039;', $url);

	if ($url[0] === '/') {
		// We're only interested in relative links from PHP_SELF
		return $url;
	} else {
		return '';
	}
}
