define ejabberd( $admin = "admin", $password="admin", $hostname="localhost"){

	package { 'ejabberd':
		ensure => installed,
	}
	
	service { "ejabberd":
			    ensure => running,
				enable => true,
				require => Package['ejabberd'],
	}
/*
	file {"/tmp/ejabberd/":
			   ensure => directory,
               mode => 755,
			   require => Service['ejabberd'],
    }

	file {"/tmp/ejabberd/autoejabberd.sh":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/ejabberd/autoejabberd.sh",
			    require => Service['ejabberd'],
    }

*/
	file {"/etc/ejabberd/ejabberd.cfg":
                ensure => present,
                mode => 0600,
				owner => "ejabberd",
				group => "ejabberd",
#                source => "puppet:///modules/ejabberd/ejabberd.cfg",
		content => template("ejabberd.cfg"),
			    require => Service['ejabberd'],
    }
	file {"/etc/ejabberd/ejabberd.pem":
                ensure => present,
                mode => 0640,
				owner => "ejabberd",
				group => "ejabberd",
                source => "puppet:///modules/ejabberd/ejabberd.pem",
			    require => Service['ejabberd'],
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
       
    exec { "ejabberd_install":
#              command => "/tmp/ejabberd/autoejabberd.sh install ${admin} ${hostname} ${password}",
#		command => "echo $HOME",
		command => "ejabberdctl register ${admin} ${hostname} ${password}",
              logoutput => true,
#              require => file ['/tmp/ejabberd/autoejabberd.sh'],
		require => Service['ejabberd'],
    }
	
}
