<?php

include_once 'session.php';
include_once 'menu_functions.php';
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- <base href="https://pocket.PiAP.local/" target="logout"> -->
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<meta http-equiv="default-style" content="/styles/main.css">
		<meta name="description" content="PiAP Template Page">
		<meta name="keywords" content="PiAP, Template, WiFi, Access Point, Security">
		<meta name="author" content="PiAP">
		<title>PiAP Template Page</title>
	</head>
	<body>
		<?php if (login_check() != true) : ?>
			<p>
				<span class="error">You are not authorized to access this page.</span> Please <a href="index.php">login</a>.
			</p>
		<?php else : ?>
		<?php echo topNavMenu() ;; ?>
		<p>Template Page</p>
	<?php endif; ?>
	</body>
</html>
