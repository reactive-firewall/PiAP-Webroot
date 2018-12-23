<?php

include_once 'PiAP-config.php';
include_once 'functions.php';
include 'session.php';

if (login_check() === true){

	function get_x509(){
		// check the pepper var is empty
		$x509_data = "";;
		$file_path = "../files/db/x509/";
		$file_path .= get_user_id(getUserName(), get_pepper());
		$file_path .= ".p12" ;;
		try {
			if ( file_exists($file_path) ) {
				//- turn off compression on the server
				$file_size  = filesize($file_path);
				@apache_setenv('no-gzip', 1);
				@ini_set('zlib.output_compression', 'Off');
				header("Pragma: private");
				header("Expires: -1");
				header("Cache-Control: private, must-revalidate, post-check=0, pre-check=0");
				header("Content-Disposition: inline;");
				header("Content-Type: application/octet-stream;");
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
			exit();
		} catch (Exception $e) {
		    header("Location: /pages/error.php?err=Security Error. Session not trusted. (crypt_weak) 406");
			exit();
		}
		exit();
	}

	get_x509();;
	exit();
} else {
	// login first
	header("Location: /pages/index.php?error=1");
	exit();
}
