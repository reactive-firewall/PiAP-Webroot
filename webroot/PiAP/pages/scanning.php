<?php

include_once 'session.php';
include_once 'menu_functions.php';

	function add_targets($badguy){
		$next_target = escapeshellarg(scrub_input($badguy));;
		$res = file_put_contents("../files/scans/queue.txt", $next_target, FILE_APPEND | LOCK_EX );;
		return true;
	}

	function get_scan_contents($file_path){
		$file = @fopen($file_path, "r");;
		if ($file != false) {
			fclose($file);
			try {
				$xml = new DOMDocument();
				$xml->load($file_path);
				$xsl = new DOMDocument;
				$xsl->load('../styles/nmap.xsl');
				$proc = new XSLTProcessor();
				$proc->importStyleSheet($xsl);
				echo $proc->transformToXML($xml);
			} catch (Exception $e) {
				$temp_error = '<div class=\"alert-error\"><div class=\"txt-alert\"><strong>BUG</strong> ';;
				$temp_error .= 'You FOUND A BUG. Please report this to my creator.';;
				echo($temp_error);;
				echo("</div></div>");;
			}
		} else {
			echo("<div class=\"alert-error\"><div class=\"txt-alert\"><strong>BUG</strong>");;
			xecho("Can not display content. Scan may not have run yet.");;
			echo("</div></div>");;
			return 0;;
		}
		return 0;;
	}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- <base href="https://pocket.PiAP.local/" target="logout"> -->
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="/styles/grid.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="/styles/scans.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<meta http-equiv="default-style" content="/styles/main.css">
		<meta name="description" content="PiAP Template Page">
		<meta name="keywords" content="PiAP, WiFi, Access Point, Security">
		<meta name="author" content="PiAP">
		<title>PiAP Template Page</title>
	</head>
	<body>
		<?php if (login_check() != true) : ?>
			<div class="container">
			<p>
				<span class="error">You are not authorized to access this page.</span> Please <a href="index.php">login</a>.
			</p>
		<?php else : ?>
			<?php echo topNavMenu() ;; ?>
			<div class="container">
				<div class="row">
					<div class="panel-wide" id="uptime_box">
						<div class="panel-heading">
							<a name="uptime"><h3>Scan Settings</h3></a>
						</div><div class="panel-content">
							<form action="/pages/scanning.php" method="post" name="scan_settings_form" class="form-config">
								<div class="row">
									<label for="target_ip" class="sr-only">Scan target</label>
									<input type="text" name="target_ip" id="target_ip" class="form-control" placeholder="10.0.40.0" required autofocus/>
								</div>
								<div class="row">
									<button class="btn btn-lg btn-block btn-primary" id="scan_button" onclick="submit">Load Scan</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="panel-wide" id="uptime_box">
						<div class="panel-heading">
							<a name="uptime"><h3>Results</h3></a>
						</div><div class="panel-content">
							<div class="scan-results">
							<?php
							if (isset($_POST['target_ip'])) {
								$targetIP = filter_input(INPUT_POST, 'target_ip', FILTER_SANITIZE_STRING) ;;
								$scan_file = "../files/scans/scan_" . $targetIP . ".xml" ;;
								add_targets($targetIP) ;;
								get_scan_contents($scan_file) ;;
							};;
							?></div>
						</div>
					</div>
				</div>
		<?php endif; ?>
			</div>
	</body>
</html>
