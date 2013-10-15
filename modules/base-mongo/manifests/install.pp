class base-mongo::install {

	
	file { "$base-mongo::params::sources_list_file":
                source => "puppet:///modules/base-mongo/$base-mongo::params::sources_list_file_content",
        }
	#Sometime you have to execute the command sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10  to add key	
	package { 'mongodb':
		name => "$base-mongo::params::server_pkg_name",
		ensure => present,
		require => File["$base-mongo::params::sources_list_file"],
	}

}

