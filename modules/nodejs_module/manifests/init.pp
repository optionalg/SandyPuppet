# This user defined type has dependency on nodejs module nodejs module should also be configured on the system
define nodejs_module($module) {

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

	exec { "install_module_${module}":
		user      => nodejs,
		command   => "npm install ${module}",
		cwd       => "/home/nodejs/",
		logoutput => true,
		require => Sruser['nodejs'],
		environment => [ "HOME=/home/nodejs" ],
	}
}
