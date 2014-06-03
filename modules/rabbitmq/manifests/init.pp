class rabbitmq() {

	package { 'erlang-nox':
                ensure => present,
        }


	file { "/root/rabbitmq-server_3.3.0-1_all.deb": 
		ensure => present,
		source =>  "puppet:///rabbitmq/rabbitmq-server_3.3.0-1_all.deb",
		require => Package['erlang-nox'],
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

	exec { "install_rabbitmq":
		command => 'dpkg -i /root/rabbitmq-server_3.3.0-1_all.deb;  rabbitmqctl add_user master master;  rabbitmqctl set_permissions master ".*" ".*" ".*"',
		logoutput => true,
		timeout     => 1800,
		require => [File["/root/rabbitmq-server_3.3.0-1_all.deb"]],
	}	
}
