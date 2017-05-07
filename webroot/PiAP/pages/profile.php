<?php

include 'session.php';
include_once 'functions.php';
include_once 'networking.php';

function can_x509_check() {
	return False;;
}

function has_downloaded_x509_check() {
	return True;;
}

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
						<a href="/pages/lan_setup.php">Lan Setup</a>
						<a href="/pages/wan_setup.php">Wan Setup</a>
						<a href="#">User Setup</a>
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
					<div class="panel" id="settings_box">
						<div class="panel-heading"><a name="User_Settings"><h3>User Settings</h3></a></div>
						<div class="panel-content">
							<div class="row">
								<form action="/pages/do_legacy_auth_setup.php" method="post" name="legacy_auth_form" class="form-config">
									<div class="row">
										<h2 class="form-config-heading"><strong>NOT AVAILABLE</strong> YET</h2>
									</div>
									<div class="row">
										<label for="input_username" class="sr-only">Set Login Username</label>
										<input type="text" name="input_username" id="input_username" class="form-control" placeholder="Admin Name" required autofocus/>
									</div>
									<div class="row">
										<label for="legacy_password" class="sr-only">Set Login Password</label>
										<input type="password" name="legacy_password" id="challenge" class="form-control" placeholder="Password" required/>
									</div>
									<div class="row">
										<?php if (can_x509_check() != true) : ?>
											<button class="btn btn-lg btn-block" id="disable_button" onclick="javascript:void(0)">Disable</button>
										<?php endif; ?>
										<button class="btn btn-lg btn-primary btn-block" id="update_button" onclick="javascript:void(0)">Update</button>
									</div>
								</form>
							</div>
							<div class="row">
								<form action="/pages/do_auth_setup.php" method="post" name="portal_auth_settings_form" class="form-config">
									<div class="row">
										<h2 class="form-config-heading">x509 Auth<strong>NOT AVAILABLE</strong> YET</h2>
									</div>
									<div class="row">
										<label for="auth_cert_button" class="sr-only">Admin User Certificate</label>
										<?php if (can_x509_check() != true) : ?>
											<button class="btn btn-lg btn-primary btn-block" id="auth_cert_button" onclick="javascript:void(0)">Generate</button>
										<?php else : ?>
											<?php if (has_downloaded_x509_check() != true) : ?>
												<button class="btn btn-lg btn-primary btn-block" id="auth_cert_button" onclick="javascript:void(0)">Download</button>
											<?php else : ?>
												<button class="btn btn-lg btn-primary btn-block" id="auth_cert_button" onclick="javascript:void(0)">Regenerate</button>
											<?php endif; ?>
										<?php endif; ?>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="panel" id="info_box">
						<div class="panel-heading"><a name="User_Info"><h3>User Info</h3></a></div>
						<div class="panel-content"><h2><strong>NOT AVAILABLE</strong> YET</h2></div>
					</div>
				</div>
		<?php endif; ?>
		</div> <!-- /container -->
	</body>
</html>
