class apache() {
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
		command   => "a2enmod ssl proxy proxy_http"
		require => Package['apache2'],
	}
}
