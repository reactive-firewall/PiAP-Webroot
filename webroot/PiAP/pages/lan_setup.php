<?php

include_once 'session.php';
include_once 'functions.php';
include_once 'networking.php';

?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP Lan Setup</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://https://pocket.PiAP.local/favicon.ico">
		<meta name="description" content="PiAP Setup">
		<meta name="author" content="PiAP">
		<link rel="stylesheet" type="text/css" href="/styles/main.css" />
		<link rel="stylesheet" type="text/css" href="/styles/form_config.css" media="screen"/>
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
						<a href="#">Lan Setup</a>
						<a href="/pages/wan_setup.php">Wan Setup</a>
						<a href="/pages/profile.php">User Setup</a>
					</div>
					</li>
					<li class="dropdown">
						<a href="javascript:void(0)" class="dropbtn">Command Center</a>
						<div class="dropdown-content">
							<a href="/pages/updates.php">Updates</a>
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
					<div class="panel" id="networking_box">
						<div class="panel-heading">
							<a name="Networking"><h3>Networking</h3></a>
						</div>
						<div class="panel-content">
							<?php echo interface_status() ;; ?>
						</div>
					</div>
					<div class="panel" id="clients_box">
						<div class="panel-heading">
						<a name="clients"><h3>Clients</h3></a>
						</div>
						<div class="panel-content">
							<?php echo client_list() ;; ?>
						</div>
					</div>
					<div class="panel" id="lan_settings_box">
						<div class="panel-heading">
							<a name="lan_settings"><h3>LAN Setup</h3></a>
						</div>
						<div class="panel-content">
							<form action="/pages/do_lan_setup.php" method="post" name="lan_settings_form" class="form-config">
								<div class="row">
									<h2 class="form-config-heading">Lan Settings</h2>
								</div>
								<div class="row">
									<label for="input_ssid" class="sr-only">Pocket WiFi Name</label>
									<input type="text" name="input_ssid" id="input_ssid" class="form-control" placeholder="Pocket WiFi Name" required autofocus/>
								</div>
								<div class="row">
									<label for="challenge" class="sr-only">WPA2 Password</label>
									<input type="password" name="challenge" id="challenge" class="form-control" placeholder="Password" required/>
								</div>
								<div class="row">
									<button class="btn btn-lg btn-primary btn-block" id="apply_button" onclick="submit">Create WiFi</button>
								</div>
							</form>
						</div>
						<?php
							if (isset($_GET['lan_error'])) {
								echo '<div id="error_alert" class="alert-error"><div class="txt-alert"><strong>Error!</strong> Configuration update failed.</div></div>';
							}
							else {
								if (isset($_GET['lan_success'])) {
									echo '<div id="success_alert" class="alert-success"><div class="txt-alert"><strong>Done!</strong> Configuration update compleate. The Radio antanas are now restarting. You may need to re-connect.</div></div>';
								}
							}
						?>
					</div> <!-- /lan -->
			</div> <!-- /row -->
		<?php endif; ?>
	  </div> <!-- /container -->
	</body>
</html>
