<?php
include 'session.php';
include_once 'networking.php';
include_once 'menu_functions.php';
include_once 'dashboard_functions.php';
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP Dashboard</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<meta name="description" content="PiAP Dashboard">
		<meta name="author" content="PiAP">
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" />
		<link rel="stylesheet" type="text/css" href="/styles/grid.css"/>
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
				<div class="panel" id="uptime_box">
					<div class="panel-heading">
						<a name="uptime"><h3>System</h3></a>
					</div>
					<div class="panel-content">
						<?php echo uptime_status() . "\n" . memory_status() ;; ?>
					</div>
				</div><div class="panel" id="hardware_box">
					<div class="panel-heading">
						<a name="hardware"><h3>Hardware</h3></a>
					</div>
					<div class="panel-content">
						<?php echo temperature_status() . "\n" . disk_status() . "\n" . entropy_status() ;; ?>
					</div>
				</div><div class="panel" id="networking_box">
					<div class="panel-heading">
						<a name="networking"><h3>Networking</h3></a>
					</div>
					<div class="panel-content">
						<?php echo interface_status() ;; ?>
					</div>
				</div><div class="panel" id="Users_box">
					<div class="panel-heading">
						<a name="User_status"><h3>User Status</h3></a>
					</div>
					<div class="panel-content">
						<?php echo user_status() ;; ?>
					</div>
				</div>
				<div class="panel" id="Firewall_box">
					<div class="panel-heading">
						<a name="Firewall"><h3>Firewall</h3></a>
					</div>
					<div class="panel-content panel-scroll-short">
						<?php echo firewall_status() ;; ?>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="panel-wide" id="clients_box">
					<div class="panel-heading">
						<a name="clients"><h3>Clients</h3></a>
					</div>
					<div class="panel-content">
						<?php echo client_list() ;; ?>
					</div>
				</div>
			</div>
		<?php endif; ?>
		</div> <!-- /container -->
	</body>
</html>
