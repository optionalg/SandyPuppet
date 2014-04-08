class replicated_single_mongo($replicaSet="rs0"){
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

	file { "/etc/mongodb.conf":
		source => "puppet:///modules/replicated_single_mongo/mongodb.conf",
		mode    => '644',
	}

	exec { "restart_replicated_mongo":
		command => "service mongodb restart;mongo --eval 'rs.initiate()'; service mongodb restart",
		logoutput => true,
		require => File["/etc/mongodb.conf"],
	}

}
