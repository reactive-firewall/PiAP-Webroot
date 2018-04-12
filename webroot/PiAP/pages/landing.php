<?php
include 'session.php';
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>loading</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<link rel="shortcut icon" type="image/x-icon" href="https://pocket.PiAP.local/logo.ico">
		<meta name="description" content="Loading">
		<meta name="author" content="">
		<!-- RFC2318 defines text/css -->
		<link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
		<link rel="stylesheet" type="text/css" href="/styles/grid.css"/>
		<link rel="stylesheet" type="text/css" href="/styles/loaders.min.css" media="screen"/>
		<!-- Loading page send to dashboard -->
		<meta http-equiv="Refresh" content="1; URL=https://pocket.PiAP.local/pages/dashboard.php">
	</head>
	<body>
		<?php if (login_check() != true) : ?>
			<div class="container">
				<p>
				<span class="panel-alert">You are not authorized to load this page.</span> Please <a href="/pages/index.php">login</a>.
				</p>
		<?php else : ?>
		<nav>
			<ul class="topnav">
				<li><a class="active" href="#">PiAP</a></li>
				<li><a class="active" href="#">Dashboard</a></li>
				<li class="dropdown">
					<a href="javascript:void(0)" class="dropbtn">Configuration</a>
					<div class="dropdown-content">
						<a href="javascript:void(0)">Loading</a>
					</div>
				</li>
				<li class="dropdown">
						<a href="javascript:void(0)" class="dropbtn">Command Center</a>
						<div class="dropdown-content">
							<a href="javascript:void(0)">Loading</a>
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
			<div class="loading-row">
				<div class="loader">
					<div class="loader-inner ball-scale">
        			  <div></div>
					</div>
				</div>
			</div>
		<?php endif; ?>
		</div> <!-- /container -->
	</body>
</html>
