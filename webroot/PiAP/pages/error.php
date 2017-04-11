<?php
include_once 'paranoia.php';
if (isset($_GET['err']) === true) {
	$error = strip_input(filter_input(INPUT_GET, 'err', $filter=FILTER_SANITIZE_STRING));
}
if (! $error) {
    $error = strip_input('Oops! An unknown error happened.');
    include_once 'logout.php';
}
if (login_check() != true) {
	header("Location: /pages/error.php?err=500");
	exit();
}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP - Error</title>
		<meta name="description" content="PiAP Error">
		<meta name="author" content="PiAP">
		<link rel="stylesheet" type="text/css" href="/styles/main.css" />
    </head>
    <body>
	<div id="error_page" class="container">
		<div class="row">
			<div class="panel alert-error" id="error_panel">
				<h2 id="error_name">There was a problem</h2>
				<p class="txt-alert" id="error_msg"><?php xecho($error); ?></p>
			</div>
		</div>
	</div>
	</body>
</html>
