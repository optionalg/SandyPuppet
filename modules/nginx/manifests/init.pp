class nginx() {

	package { 'nginx':
		ensure => present,
	}

	file {"/etc/nginx/ssl":
		ensure => present,
		recurse => true,
		mode => 0755,
		content => "puppet:///modules/nginx_conf/ssl",
		require => Package['nginx'],
	}

}
