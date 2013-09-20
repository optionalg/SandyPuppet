define tomcat($user, $tomcat_location, $listening_port, $shutdown_port, $version = "7.0.40",){  

	file { "/usr/local/${tomcat_location}":
		source  => "puppet:///modules/tomcat/apache-tomcat-${version}",
		recurse => true,
		owner => "${user}",
		group => "${user}",
		ensure => [ ['directory'] , ['present']],
		mode => '0750',
	}

	file { "/var/log/${user}/${tomcat_location}":
                ensure => directory,
                owner => "${user}",
                group => "${user}",
                mode => '0755',
        }
	
	file { "/usr/local/${tomcat_location}/conf/server.xml" :
                     ensure  => present,
                     content => template("tomcat/server.xml.erb"),
                     require =>  File["/usr/local/${tomcat_location}"],
                     mode => '0750',
                     owner =>"${user}",
                     group =>"${user}",
        }

	file { "/usr/local/${tomcat_location}/webapps" :
                ensure => [ ['directory'] , ['present']],
                require =>  File["/usr/local/${tomcat_location}"],
                mode => '0750',
                owner =>"${user}",
                group =>"${user}",
        }

	file { "/usr/local/${tomcat_location}/webapps/ckeditor" :
		ensure => [ ['directory'] , ['present']],
		source  => "puppet:///modules/tomcat/ckeditor",
		require =>  File["/usr/local/${tomcat_location}/webapps"],
		mode => '0750',
		owner =>"${user}",
		group =>"${user}",
		recurse => true,
        }
}

