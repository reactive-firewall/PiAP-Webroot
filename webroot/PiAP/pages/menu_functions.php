<?php
include_once 'PiAP-config.php';
include_once 'paranoia.php';
include_once 'functions.php';

function topNavMenu($page) {
	$blob = "<nav>\n";
	$pages = array( array( 'Title' => "PiAP",
								 'Link' => "#",
								 'Active' => true,
								 'Kind' => "active",
								 'Links' => array()
								),
						  array( 'Title' => "Dashboard",
							     'Link' => "/pages/landing.php",
							     'Active' => true,
								 'Kind' => "active",
								 'Links' => array()
							    ),
						  array( 'Title' => "Configuration",
								 'Link' => "javascript:void(0)",
								 'Active' => true,
								 'Kind' => "dropbtn",
								'Links' => array( array(	'Title' => "Lan Setup",
											   			'Link' => "/pages/lan_setup.php",
											   			'Active' => true),
											   array(	'Title' => "Wan Setup",
													 	'Link' => "/pages/wan_setup.php",
													 	'Active' => true),
											   array(	'Title' => "User Setup",
													 	'Link' => "/pages/profile.php",
													 	'Active' => true)
											   )
								),
							array( 'Title' => "Command Center",
								  'Link' => "javascript:void(0)",
								  'Active' => true,
								  'Kind' => "dropbtn",
								  'Links' => array( array(	'Title' => "Updates",
														'Link' => "/pages/updates.php",
														'Active' => true),
												 array(	'Title' => "Logs",
													   'Link' => "/pages/logview.php",
													   'Active' => false),
												 array(	'Title' => "Host Scanner",
													   'Link' => "/pages/scanning.php",
													   'Active' => false)
												 )
								  ),
							array( 'Title' => "Power",
								  'Link' => "javascript:void(0)",
								  'Active' => true,
								  'Kind' => "dropbtn",
								  'Links' => array( array(	'Title' => "Reboot",
														'Link' => "/pages/do_reboot.php",
														'Active' => true),
												 array(	'Title' => "Turn Off",
													   'Link' => "/pages/power_off.php",
													   'Active' => true)
												 )
								  )
	);;
	$blob .= "<ul class=\"topnav\">\n";
	$blob .= "<li><a class=\"active\" href=\"#\">PiAP</a></li>";
	for ($row = 0; $row < 5; $row++)
	{
		if ($pages[$row]["Active"] === true){
			if ($pages[$row]["Kind"] === "dropbtn") {
				$blob .= "<li class=\"dropdown\">";
			} else {
				$blob .= "<li>";
			};;
			$blob .= "<a class=\"" . $pages[$row]["Kind"] . "\" href=\"" . $pages[$row]["Link"] . "\">" . $pages[$row]["Title"] . "</a>";;
		if ($pages[$row]["Kind"] === "dropbtn") {
			$blob .= "<div class=\"dropdown-content\">\n";
		foreach($pages[$row]["Links"] as $subpage)
		{
			if ($subpage["Active"] === true){
			$blob .= "<a href=\"" . $subpage["Link"] . "\" >" . $subpage["Title"] . "</a>\n";
			};;
		}
			$blob .= "</div>\n";
		}
		$blob .= "</li>\n";
		}
	}
	$blob .= "<li class=\"right\"><a class=\"logout-btn\" href=\"/pages/logout.php\">Logoff</a></li>";;
	$blob .= "</ul>\n</nav>\n";
	return $blob ;;
}


