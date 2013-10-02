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


}
