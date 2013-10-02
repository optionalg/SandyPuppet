class base-mongo(){

	$public_ip = $::ipaddress

		$server_pkg_name = $::osfamily ? {
			debian => 'mongodb-10gen',
			       redhat => 'mongo-10gen-server',
			       default =>  'mongo-10gen-server',
		}

	file { '/etc/yum.repos.d/10gen.repo':
		source => "puppet:///modules/base-mongo/mongo.repo",
	}


	user { 'mongo':
		ensure => present,
		managehome => false,
		uid        => 723,
	}

	file { 'data':
		path => '/data',
		     ensure => directory,
	}
	/*
	file { 'mongo_logs':
		path => '/var/log/mongo/',
		     owner => mongo,
		     group => mongo,
		     ensure => directory,
		     require => User['mongo'],
		     before => Package['mongodb'],
	}
	*/
	package { 'mongodb':
		name => "${server_pkg_name}",
		     ensure => present,
		require => File['/etc/yum.repos.d/10gen.repo'],
	}
	file {  ["/data/mongo", "/var/log/mongo"] :
		owner => mongo,
		      group => mongo,
		      ensure => directory,
		      require => [ User['mongo'], File['data'], ],
		      before => Package['mongodb'],
		      recurse => true,
	}



}
