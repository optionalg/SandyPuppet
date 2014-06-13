class apache() {
	package { 'apache2':
                ensure => present,
        }

	exec { 'install_default_modules':
		command   => "a2enmod ssl proxy proxy_http"
	}
}
