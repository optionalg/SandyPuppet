define tomcat($user, $user_tomcat, $listening_port, $shutdown_port, $version = "7.0.40",){  

	file { "/usr/local/${user_tomcat}":
		source  => "puppet:///modules/usertomcat/apache-tomcat-${version}",
		recurse => true,
		owner => "${user}",
		group => "${user}",
		ensure => [ ['directory'] , ['present']],
		mode => '0755',
	}

	file { "/var/log/${user}/${user_tomcat}":
                ensure => directory,
                owner => "${user}",
                group => "${user}",
                mode => '0755',
        }
	
	file { "/usr/local/${user_tomcat}/conf/server.xml" :
                     ensure  => present,
                     content => template("usertomcat/server.xml.erb"),
                     require =>  File["/usr/local/${user_tomcat}"],
                     mode => '0755',
                     owner =>"${user}",
                     group =>"${user}",
        }

	file { "/usr/local/${user_tomcat}/webapps/ckeditor" :
		ensure => [ ['directory'] , ['present']],
		source  => "puppet:///modules/usertomcat/ckeditor",
		require =>  File["/usr/local/${user_tomcat}"],
		mode => '0755',
		owner =>"${user}",
		group =>"${user}",
		recurse => true,
        }
}

