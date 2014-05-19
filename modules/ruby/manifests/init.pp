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

	file { "/root/rubyInstall.sh":
		source => "puppet:///modules/ruby/rubyInstall.sh",
		mode => '0750',
	}

	exec { "install_rvm":
		command   => "cat /root/rubyInstall.sh | bash -s stable",
		logoutput => true,
		require => [ File['/root/rubyInstall.sh']],
	}
	
	exec { "install_nodejs":
		command   => "bash -c 'rvm install ${ruby_version};rvm alias create default ${ruby_version}'",
		path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
                logoutput => true,
                require => [ Exec['install_rvm']],
        }
}
