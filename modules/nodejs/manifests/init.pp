class nodejs() {

	sruser{nodejs: user => nodejs, }

	file { "/home/nodejs/nodeapps":
		owner => nodejs,
		group => nodejs,
		ensure => directory,
		require => Sruser['nodejs'],
	}

	file{ "/home/nodejs/deployNodeApp.sh":
		owner => nodejs,
		group => nodejs,
		mode => '0750',
		source => "puppet:///modules/nodejs/deployNodeApp.sh",
		require => File["/home/nodejs/nodeapps"],
	}

	file{ "/home/nodejs/startNodeApp.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/startNodeApp.sh",
                require => File["/home/nodejs/nodeapps"],
        }

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

	exec { "install_nvm":
		user      => nodejs,
		command   => "curl https://raw.github.com/creationix/nvm/master/install.sh | sh",
		cwd       => "/home/nodejs/",
		logoutput => true,
		require => Sruser['nodejs'],
		environment => [ "HOME=/home/nodejs" ],
	}

	exec { "install_npm":
                user      => root,
                command   => "curl http://npmjs.org/install.sh | sh",
                logoutput => true,
        }
}
