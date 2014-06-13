defile apache($env="mettl.info") {
	Exec {
		path => [
			'/usr/local/bin',
			'/opt/local/bin',
			'/usr/bin',
			'/usr/sbin',
			'/bin',
			'/sbin'],
			logoutput => true,
	}

	package { 'apache2':
                ensure => present,
        }

	exec { 'install_default_modules':
		command   => "a2enmod ssl proxy proxy_http rewrite",
		require => Package['apache2'],
	}

	file { "/etc/ssl/certs/mettl.crt":
               source => "puppet:///modules/apache/${env}/mettl.crt",
               mode => '0750',
       }

       file { "/etc/ssl/private/mettl.key":
                source => "puppet:///modules/apache/${env}/mettl.key",
                mode => '0750',
        }      

       file { "/etc/ssl/certs/mettl_bundle.crt":
                source => "puppet:///modules/apache/${env}/mettl_bundle.crt",
                mode => '0750',
        }

}
