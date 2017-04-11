<?php

include_once 'session.php';
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- <base href="https://pocket.PiAP.local/" target="logout"> -->
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
		<nav>
			<ul class="topnav">
				<li><a class="active" href="#">PiAP</a></li>
				<li><a class="active" href="#">Dashboard</a></li>
				<li class="dropdown">
					<a href="javascript:void(0)" class="dropbtn">Configuration</a>
					<div class="dropdown-content">
						<a href="/pages/lan_setup.php">Lan Setup</a>
						<a href="/pages/wan_setup.php">Wan Setup</a>
						<a href="/pages/profile.php">User Setup</a>
					</div>
				</li>
				<li class="dropdown">
					<a href="javascript:void(0)" class="dropbtn">Power</a>
					<div class="dropdown-content">
						<a href="/pages/do_reboot.php">Reboot</a>
						<a href="/pages/power_off.php">Turn Off</a>
					</div>
				</li>
				<li class="right"><a class="logout-btn" href="/pages/logout.php">Logoff</a></li>
			</ul>
		</nav>
		<p>Template Page</p>
	<?php endif; ?>
	</body>
</html>
