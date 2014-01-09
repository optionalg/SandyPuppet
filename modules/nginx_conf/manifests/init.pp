define nginx_conf($listen_port = 80, $app_domain_name = "localhost", $app_name, $app_host = "localhost", $app_port = "8080" ) {

	file {"/etc/nginx/sites-available/${app_name}.conf":
		ensure => present,
		content => template("nginx.conf"),
	}

	file {"/etc/nginx/ssl":
		ensure => present,
		recurse => true,
		mode => 0755,
		content => template('nginx_conf/ssl'),
	}

}
