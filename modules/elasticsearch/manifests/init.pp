define elasticsearch( version = 0.90.5) {

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

	exec { "install_elasticsearch":
		command   => "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb;dpkg -i elasticsearch-${version}.deb",
		logoutput => true,
	}	
/*
class elasticsearch{

	user { "elasticsearch":
		ensure     => 'present',
		home       => "/home/${user}",
		shell      => '/bin/bash',
		uid 	   => "753",
		managehome =>  true,
	}

	file { "/opt/elasticsearch": 
		ensure => directory,
		owner => "elasticsearch",
                group => "elasticsearch",
		require => User ['elasticsearch'],
		source => 'puppet:///modules/elasticsearch/elasticsearch-0.20.6',
		recurse => true
	}

	file_line { 'logstash entry':
                ensure => present,
                line   => "${ipaddress} logstash.snapdeal.com",
                path   => '/etc/hosts',
        }

*/
}
