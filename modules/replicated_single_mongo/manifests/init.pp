define replicated_single_mongo($replicaSet="rs0", $host_name="127.0.0.1", $port="27017"){
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

	file { "/etc/master_replica":
		content => template('replicated_single_mongo/master_replica'),
	}



	exec { "restart_replicated_mongo":
		command => "sleep 1m; service mongodb restart; sleep 1m",
		logoutput => true,
		require => File["/etc/mongodb.conf"],
	}

	exec { "register_replicaset_with_master":
               command => "mongo ${host_name}:${port} < /etc/master_replica",
               logoutput => true,
               require => [File["/etc/master_replica"], Exec ["restart_replicated_mongo"]],
       }
}
