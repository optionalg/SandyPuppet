define sr_redis($port = 6379) {

	file { "/usr/local/bin/redis-server":
		source  => "puppet:///modules/sr_redis/redis-server",
		mode => 0754,
	}

	file { "/usr/local/bin/redis-cli":
                source  => "puppet:///modules/sr_redis/redis-cli",
                mode => 0754,
        }


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
