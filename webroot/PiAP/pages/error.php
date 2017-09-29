<?php
include_once 'paranoia.php';
if (isset($_GET['err']) === true) {
	$error = strip_input(filter_input(INPUT_GET, 'err', $filter=FILTER_SANITIZE_STRING));
}
if (! $error) {
    $error = strip_input('Oops! An unknown error happened.');
    include_once 'logout.php';
}

function xerror_tagline() {
	$theResult = "Uh oh! Did the monkeys escape? Better find the nearest benevolent geek.";
	switch (rand(0,20)) {
    case 0:
        $theResult = "Uh oh! Did the monkeys escape? Better find the nearest benevolent geek.";;
        break;
    case 1:
        $theResult = "Uh oh! Pocket got tripped up? Don't give your pocket drugs.";;
        break;
    case 2:
        $theResult = "Uh oh! Pocket ran out of the magical unicorns that keep it running smoothly?";;
        break;
    case 3:
        $theResult = "Uh oh! Murphy's law struck again!";;
        break;
    case 4:
        $theResult = "Gasp! There be errors in these parts!";;
        break;
    case 5:
        $theResult = "Huh? Qu'est-ce que le diable vient de se passer?!? ... might as well be a forign language.";;
        break;
    case 6:
        $theResult = "Huh? What just happened?!? ... pourrait aussi bien être une langue étrangère.";;
        break;
    case 7:
        $theResult = "Look out! The gremlens got me. I'm only a poor server after all.";;
        break;
    case 8:
        $theResult = "This is not the page you seek. But here you are.";;
        break;
	case 9:
        $theResult = "Uh oh! Sod's law struck again!";;
        break;
   	case 10:
        $theResult = "Uh oh! The server's bit got crossed! Give it a second to recover.";;
        break;
   	case 11:
        $theResult = "Help, help! I can't find that page.";;
        break;
   	case 12:
        $theResult = "Are you sure you want to do that?";;
        break;
   	case 13:
        $theResult = "Uh oh! Good thing I stopped that page. It could have been full of monkeys.";;
        break; 
   	case 14:
        $theResult = "Uh oh! What is one plus zero again?.";;
        break;
    case 15:
        $theResult = "Huh? I thought that would have worked too.";;
        break;
    case 16:
        $theResult = "Huh? Not the result the cats got when they did that.";;
        break;
    case 17:
        $theResult = "Um, this is embarrassing.";;
        break;
    case 18:
        $theResult = "This is not the page you seek. Probably not. But here you are.";;
        break;
	case 19:
        $theResult = "Uh oh! Sod's law struck again twice in the same place. Or was it Faeries?";;
        break;
   	case 20:
        $theResult = "Uh oh! That did not work at all. Quick herd the monkeys back home.";;
        break;
}
	return $theResult;
}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>PiAP - Error</title>
		<meta name="expected-hostname" content="pocket.PiAP.local">
		<meta content="https://pocket.PiAP.local/images/logo.png" property="og:image">
		<link rel="icon" type="image/x-icon" href="https://https://pocket.PiAP.local/favicon.ico">
		<meta name="description" content="PiAP Error">
		<meta name="author" content="PiAP">
		<link rel="stylesheet" type="text/css" href="/styles/main.css"/>
		<link rel="stylesheet" type="text/css" href="/styles/grid.css"/>
    </head>
    <body>
	<div id="error_page" class="container">
		<div class="row">
			<div class="panel alert-error" id="error_panel">
				<h2 id="error_name">There was a problem</h2>
				<p class="txt-alert" id="error_msg"><?php xecho($error); ?></p>
			</div>
		</div>
		<div class="row">
			<p class="txt-action" id="error_sass"><?php xerror_tagline(); ?></p>
			<p class="txt-action" id="error_help">... or perhaps just try again.</p>
		</div>
	</div>
	</body>
</html>
