define nodeapp( $app_name) {

	file { "/etc/init/${app_name}.conf":
		owner => root,
                group => root,
                ensure => present,
                content => template("nodeapp/nodeapp.erb.xml"),	
		mode => 0644,
	}

	file { "/var/log/${app_name}.sys.log":
                owner => root,
                group => root,
                ensure => present,
		mode => 0666,
        }

	file { "/home/nodejs/nodeapps/${app_name}":
                owner => nodejs,
                group => nodejs,
                ensure => ['directory','present'],
                mode => 0755,
        }
}
