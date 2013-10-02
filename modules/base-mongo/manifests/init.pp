class base-mongo(){

	$public_ip = $::ipaddress

		$server_pkg_name = $::osfamily ? {
			debian => 'mongodb-10gen',
			       redhat => 'mongo-10gen-server',
			       default =>  'mongo-10gen-server',
		}
	$sources_list_file = $::osfamily ? {
		debian => '/etc/apt/sources.list.d/10gen.list',
		       redhat => '/etc/yum.repos.d/10gen.repo',
		       default =>  '/etc/yum.repos.d/10gen.repo',
	}

	$sources_list_file_content = $::osfamily ? {
		debian => 'mongo_debian.repo',
		       redhat => 'mongo.repo',
		       default =>  'mongo.repo',
	}


	file { "${sources_list_file}":
		source => "puppet:///modules/base-mongo/${sources_list_file_content}",
	}


	user { 'mongo':
		ensure => present,
		       managehome => false,
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
		     require => File["${sources_list_file}"],
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

