class redis() {

	package { 'redis':
		name => "redis-server",
		ensure => present,
	}
	
}
