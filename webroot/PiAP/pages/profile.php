<?php

include_once 'PiAP-config.php';
include_once 'functions.php';
include_once 'networking.php';

sec_session_start();
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP Setup</title>
		<meta name="description" content="PiAP Setup">
		<meta name="author" content="PiAP">
		<link rel="stylesheet" type="text/css" href="/styles/main.css" />
		<link rel="stylesheet" type="text/css" href="/styles/sign_in.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="/styles/grid.css" media="screen"/>
		<!-- RFC4329 defines application/javascript -->
	</head>
	<body>
		<?php if (login_check() != true) : ?>
		<div class="container">
			<p>
				<span class="panel-alert">You are not authorized to access this page.</span> Please <a href="/pages/index.php">login</a>.
			</p>
		<?php else : ?>
			<nav>
				<ul class="topnav">
					<li><a href="#">PiAP</a></li>
					<li><a href="/pages/dashboard.php">Dashboard</a></li>
					<li class="dropdown">
					<a href="javascript:void(0)" class="dropbtn">Configuration</a>
					<div class="dropdown-content">
						<a href="/pages/lan_setup.php">Lan Setup</a>
						<a href="/pages/wan_setup.php">Wan Setup</a>
						<a href="#">User Setup</a>
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
			<div class="container">
				<div class="row">
					<div class="panel" id="settings_box">
						<div class="panel-heading"><a name="User_Settings"><h3>User Settings</h3></a></div>
						<div class="panel-content"><p><strong>NOT AVAILABLE</strong> YET</p></div>
					</div>
				</div>
		<?php endif; ?>
		</div> <!-- /container -->
	</body>
</html>
