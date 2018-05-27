<?php
include_once 'session.php';
include_once 'functions.php';
include_once 'menu_functions.php';
function startsWith($haystack, $needle)
{
     $length = strlen($needle);
     return (substr($haystack, 0, $length) === $needle);
}

function esc_log_path($url) {

	if ('' === $url) {
		return $url;
	}
	$strip = array('%0d', '%0a', '%0D', '%0A');
	$url = (string) $url;

	$count = 1;
	while ($count) {
		$url = str_replace($strip, '', $url, $count);
	}

	if (startsWith($url, '/var/log/')) {
		$theList = array("/var/log/fw.log", "/var/log/blacklist.log", "/var/log/PiAP_upgrade.log", "/var/log/PiAP.log");;
		foreach ($theList as $whitelist_url) {
			if (startsWith($url, $whitelist_url)) {
				if (strlen($whitelist_url) === strlen($url)) {
					// We're only interested in white-listed logs
					return $url;
				} else {
					log_error("[CWE-20] Path Enumeration attack detected.");;
					return '';
				}
			};
		};
		log_error("Path Enumeration attack detected.");;
		return '';
	} else {
		log_error("[CWE-20] Path Enumeration attack detected.");;
		return '';
	}
}

function get_log_contents($file_path){
	$log_file_data = "";
	$file = @fopen($file_path, "r");;
	if ($file != false) {
		(int) $lineCount = 1;;
		while(!feof($file))
		{
			xecho("Line " . $lineCount . ": " . fgets($file));;
			echo("</br>");;
			$lineCount += 1;;
		}
		fclose($file);
	} else {
		xecho("Can not display content");;
		return 0;
	}
	return 0;;
}


if (isset($_GET['path']) === true) {
	$log_path = esc_log_path(filter_input(INPUT_GET, 'path', $filter=FILTER_SANITIZE_STRING));
}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- <base href="https://pocket.PiAP.local/" target="logout"> -->
		<title>View Log</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="/styles/grid.css"/>
		<meta http-equiv="default-style" content="/styles/main.css">
		<meta name="description" content="PiAP Template Page">
		<meta name="keywords" content="PiAP, Template, WiFi, Access Point, Security">
		<meta name="author" content="PiAP">
		<title>View Log</title>
	</head>
	<body>
		<?php if (login_check() != true) : ?>
			<p>
				<span class="error">You are not authorized to access this page.</span> Please <a href="index.php">login</a>.
			</p>
		<?php else : ?>
		<?php echo topNavMenu() ;; ?>
		<div class="container">
			<div class="row"><h1>LOG <?php xecho($log_path); ?></h1></div>
				<div class="row">
					<div class="well well-lg">
						<p id="log-content" class="panel-scroll-rare">
							<?php get_log_contents($log_path); ?>
						</p>
					</div>
				</div>
			</div>
		</div> <!-- container -->
	<?php endif; ?>
	</body>
</html>
