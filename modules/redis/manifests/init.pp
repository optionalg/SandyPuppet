class redis() {

	package { 'redis':
		name => "redis-server",
		ensure => present,
	}
	
	file{ "/etc/init/redis.conf":
                mode => '0750',
                source => "puppet:///modules/redis/redis.conf",
                require => Package["redis"],
        }
}
