class ruby($ruby_version="1.9.3") {

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
	#########Git should be present in the system########################
	exec { "install_rvm":
		command   => "\curl -sSL https://get.rvm.io | bash -s stable",
		logoutput => true,
	}
	
	exec { "install_nodejs":
		command   => "bash -c 'rvm install ${ruby_version};rvm alias create default ${ruby_version}'",
		path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
                logoutput => true,
                require => [ Exec['install_rvm']],
        }
}
