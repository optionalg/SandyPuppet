class base-mongo::install {

	
	file { "$base-mongo::params::sources_list_file":
                source => "puppet:///modules/base-mongo/$base-mongo::params::sources_list_file_content",
        }
	
	package { 'mongodb':
		name => "$base-mongo::params::server_pkg_name",
		ensure => present,
		require => File["$base-mongo::params::sources_list_file"],
	}

}

