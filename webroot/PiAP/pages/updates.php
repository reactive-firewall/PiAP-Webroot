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
		<title>PiAP Updates</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://https://pocket.PiAP.local/favicon.ico">
		<meta name="description" content="PiAP Updates">
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
						<a href="/pages/profile.php">User Setup</a>
					</div>
					</li>
					<li class="dropdown">
					<a href="javascript:void(0)" class="dropbtn">Command Center</a>
					<div class="dropdown-content">
						<a href="#">Updates</a>
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
					<?php
							if (isset($_GET['update_error'])) {
								echo '<div id="error_alert" class="alert-error"><div class="txt-alert"><strong>Error!</strong> Configuration update failed. Please <a href="https://github.com/reactive-firewall/PiAP-Webroot/issues">report this issue.</a></div></div>';
							}
							else {
								if (isset($_GET['update_done'])) {
									echo '<div id="success_alert" class="alert-success"><div class="txt-alert"><strong>Done!</strong> Pocket PiAP update compleate. You may need to reboot.</div></div>';
								}
							}
						?>
				</div>
				<div class="row">
					<div class="panel" id="piaplib_updates_box">
						<div class="panel-heading">
							<a name="piaplib_updates"><h3>Update Pocket PiAP</h3></a>
						</div>
						<div class="panel-content">
							<form action="/pages/do_piaplib_update.php" method="post" id="piaplib_update_form" name="piaplib_update_form" class="form-config">
								<div class="row">
									<p class="txt-desc" id="caution">Online update of the PiAP. This may take several minutes and should <strong>Not</strong> be inturupted once started.</p>
								</div>
								<div class="row">
									<button class="btn btn-lg btn-primary btn-block" id="update_button" onclick="submit">Update</button>
								</div>
							</form>
						</div>
					</div> <!-- /piap -->
			</div> <!-- /row -->
		<?php endif; ?>
	  </div> <!-- /container -->
	</body>
</html>
