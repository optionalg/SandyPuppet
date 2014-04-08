define elasticsearch_plugin( $plugin_path){

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

	exec { "plugin_${plugin_path}":
		command => "/usr/share/elasticsearch/bin/plugin --install ${plugin_path}",
		logoutput => true,
		timeout     => 1800,
	}
}

