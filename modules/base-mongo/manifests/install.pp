class base-mongo::install {

	$sources_list_file_content="$base-mongo::params::sources_list_file_content"
	exec { "add_mongo_key":
               command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
               logoutput => true,
       }
	
#	file { "$base-mongo::params::sources_list_file":
	file { "/root/sandy":
                source => "puppet:///modules/base-mongo/${sources_list_file_content}",
		require => Exec['add_mongo_key'],
        }
      Exec {
               path => [
                       '/usr/local/bin',
                       '/opt/local/bin',
                       '/usr/bin',
                       '/usr/sbin',
                       '/bin',
                       '/sbin'],
                       logoutput => true,
       }
       
       exec { "update_packages":
               command => "apt-get update",
               logoutput => true,
#               require => File["$base-mongo::params::sources_list_file"],
		require => File["/root/sandy"],
       }

	#Sometime you have to execute the command sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10  to add key	
	package { 'mongodb':
		name => "$base-mongo::params::server_pkg_name",
		ensure => present,
		require => Exec["update_packages"],
	}

}

