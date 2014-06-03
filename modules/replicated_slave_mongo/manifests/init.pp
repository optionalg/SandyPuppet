define replicated_slave_mongo($replicaSet="rs0", $slave_port="27017", $slave_host_name, $master_host_name, $master_port="27017"){
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
		source => "puppet:///modules/replicated_slave_mongo/mongodb.conf",
		mode    => '644',
	}

	file { "/etc/slave_replica":
		content => template('replicated_slave_mongo/slave_replica'),
	}

	exec { "register_slave_mongo":
		command => "sleep 1m;service mongodb restart;sleep 1m",
		logoutput => true,
		require => File["/etc/mongodb.conf"],
	}



	exec { "register_slave_with_master":
		command => "mongo ${master_host_name}:${master_port} < /etc/slave_replica",
		logoutput => true,
		require => [File["/etc/slave_replica"], Exec ["register_slave_mongo"]],
	}
}
