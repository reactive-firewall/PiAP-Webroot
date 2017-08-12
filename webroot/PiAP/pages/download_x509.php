<?php

include_once 'PiAP-config.php';
include_once 'functions.php';
include 'session.php';

if (login_check() === true){

	function get_x509(){
		// check the pepper var is empty
		$x509_data = "";;
		$file_path = "../files/x509/";
		$file_path .= get_user_id(getUserName(), get_pepper());
		$file_path .= ".p12" ;;
		try {
			if ( file_exists($file_path) ) {
				//- turn off compression on the server
				$file_size  = filesize($file_path);
				@apache_setenv('no-gzip', 1);
				@ini_set('zlib.output_compression', 'Off');
				header("Pragma: public");
				header("Expires: -1");
				header("Cache-Control: public, must-revalidate, post-check=0, pre-check=0");
				header("Content-Disposition: inline;");
				header("Content-Type: application/octet-stream;" . $ctype);
				header("Content-Length: $file_size");
				$auth_file = @fopen($file_path, "rb");;
				fseek($auth_file, 0);
				while(!feof($auth_file)) {
					print(@fread($auth_file, 1024*8));
					ob_flush();
					flush();
					if (connection_status()!=0) 
					{
						@fclose($auth_file);
						exit();
					}			
				}
				// file save was a success
				@fclose($file);
			}
		exit;
				fclose($auth_file);;
			}
		} catch (Exception $e) {
		    header("Location: /pages/error.php?err=Security Error. Session not trusted. (crypt_weak) 406");
			exit();
		}
		if ($x509_data !== "") {
			return $x509_data;;
		} else {
			header("Location: /pages/error.php?err=Security Error. Session not trusted. (crypt_weak) 406");
			exit();
			return "";;
		}
	}

	if (generate_x509() === true) {
		// tool success
		if ( file_exists("../files/x509/" . get_user_id(getUserName(), get_pepper()) . ".p12") ) {
			header("Location: ../files/x509/" . get_user_id(getUserName(), get_pepper()) . ".p12");;
		}
		exit();
	} else {
		// tool failed
		if ( file_exists("../files/x509/" . get_user_id(getUserName(), get_pepper()) . ".p12") ) {
			header("Location: /pages/error.php?err=Could not regenerate x509. (bad_tool) 500");
		} else {
			header("Location: /pages/error.php?err=Could not generate x509. (bad_tool) 500");
		}
		exit();
	}
} else {
	// login first
	header("Location: /pages/index.php?error=1");
	exit();
}
