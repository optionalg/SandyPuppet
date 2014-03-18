class secure_system() {
	package { 'fail2ban':
		ensure => present,
	}
}	
