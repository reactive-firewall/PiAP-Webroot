<?php
include_once 'PiAP-config.php';
include_once 'session.php';

sec_session_start();

if (login_check() === true) {
    $logged = 'in';
} else {
    $logged = 'out';
}
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Please Login">
        <meta name="author" content="PiAP">
        <title>PiAP Login</title>
        <!-- RFC2318 defines text/css -->
        <link rel="stylesheet" type="text/css" href="/styles/main.css" media="screen"/>
        <link rel="stylesheet" type="text/css" href="/styles/sign_in.css" media="screen"/>
        <!-- RFC4329 defines application/javascript -->
        <script type="application/javascript" src="/scripts/sha512.js" charset="UTF-8"></script>
        <script type="application/javascript" src="/scripts/hashing.js" charset="UTF-8"></script>
    </head>
	<body>
		<div class="container">
			<div class="panel">
				<div id="error_alert" class="row">
					<?php
						if (isset($_GET['error'])) {
							echo '<div class="alert-error"><div class="txt-alert"><strong>Error Logging In</strong></div></div>';;
						}
					?>
				</div>
				<form action="/pages/do_login.php" method="post" name="login_form" class="form-signin">
					<div class="row">
						<h2 class="form-signin-heading">Please sign in</h2>
					</div>
					<div class="row">
						<label for="username" class="sr-only">Username</label>
						<input type="text" name="username" id="username" class="form-control" placeholder="Username" required autofocus/>
					</div>
					<div class="row">
						<label for="password" class="sr-only">Password</label>
						<input type="password" name="password" id="password" class="form-control" placeholder="Password" required/>
					</div>
					<div class="row">
						<button class="btn btn-lg btn-primary btn-block" id="login_button" onclick="hashsubmit(this.login_form.password, this.login_form);">Sign in</button>
					</div>
				</form>
			</div>
			<div class="row">
				<div id="logout_box" class="panel-logout">
					<p id="logout_line" class="txt-logout">Remember to <a href="/pages/logout.php" id="logout">log out</a>.</p>
					<p id="login_status" class="txt-logout">You are currently logged <?php xecho($logged) ?>.</p>
				</div>
			</div>
		</div> <!-- /container -->
	</body>
</html>
