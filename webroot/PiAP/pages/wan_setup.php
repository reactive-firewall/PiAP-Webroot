<?php
include_once 'session.php';
include_once 'functions.php';
include_once 'networking.php';
include_once 'menu_functions.php';

?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP WAN Setup</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<meta name="description" content="PiAP Wan Setup">
		<meta name="author" content="PiAP">
		<!-- RFC2318 defines text/css -->
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
		<?php echo topNavMenu() ;; ?>
			<div class="container">
				<div class="row">
					<div class="panel-wide" id="recon_box">
						<div class="panel-heading">
							<a name="recon"><h3>Wifi Recon</h3></a>
						</div>
						<div class="panel-content">
							<?php echo wifi_list() ;; ?>
						</div>
					</div>
					<div class="panel" id="wan_settings_box">
						<div class="panel-heading"><a name="wan_settings"><h3>WAN Setup</h3></a></div>
							<div class="panel-content">
								<form action="/pages/do_wan_setup.php" method="post" name="wan_settings_form" class="form-config">
									<div class="row">
										<label for="target_ssid" class="sr-only">Public WiFi Name</label>
										<input type="text" name="target_ssid" id="target_ssid" class="form-control" placeholder="WiFi Name" required autofocus/>
									</div>
									<div class="row">
										<label for="challenge" class="sr-only">WPA2 Password</label>
										<input type="password" name="challenge" id="challenge" class="form-control" placeholder="Password" required/>
									</div>
									<div class="row">
										<button class="btn btn-lg btn-block btn-primary" id="join_button" onclick="submit">Join</button>
									</div>
								</form>
							</div>
							<?php
								if (login_check() === true) {
									if (isset($_GET['wan_error'])) {
										echo '<div id="error_alert" class="alert-error"><div class="txt-alert"><strong>Error!</strong> Configuration update failed.</div></div>';;
									}
									else {
										if (isset($_GET['wan_success'])) {
											echo '<div id="success_alert" class="alert-success"><div class="txt-alert"><strong>Done!</strong> Configuration update compleate. The Radio antanas are now restarting.</div></div>';;
										}
									}
								}
							?>
						</div>
					</div>
			<?php endif; ?>
		</div> <!-- /container -->
	</body>
</html>
