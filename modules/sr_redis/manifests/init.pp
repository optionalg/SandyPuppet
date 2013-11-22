define sr_redis($port = 6379) {

	file {"/etc/redis/${port}.conf":
		ensure => present,
		content => template('sr_redis/redis.conf'),
	}

	file {"/etc/init.d/redis_${port}":
                ensure => present,
                content => template('sr_redis/redis_init_script'),
        }

	file {"/var/redis/${port}":
		ensure => directory,
	}
}
