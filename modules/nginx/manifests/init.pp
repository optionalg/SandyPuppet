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

	file {"/usr/sbin/nginxdissite":
                ensure => present,
                mode => 0755,
                content => "puppet:///modules/nginx_conf/nginxdissite",
        }

	file {"/usr/sbin/nginxensite":
                ensure => present,
                mode => 0755,
                content => "puppet:///modules/nginx_conf/nginxensite",
        }
}
