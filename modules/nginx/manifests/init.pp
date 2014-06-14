class nginx() {

	#########Refer this link in fase nginx.conf is not available http://askubuntu.com/questions/361902/how-to-install-nginx-after-removed-it-manually

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

	exec { "update_nginx":
                command   => "add-apt-repository ppa:nginx/stable -y;apt-get update -y;apt-get upgrade -y",
                logoutput => true,
                timeout     => 1800,
        }	

	package { 'nginx':
		ensure => present,
		require => Exec['update_nginx'],
	}

	file {"/etc/nginx/ssl":
		ensure => ['directory', 'present'],
		require => Package['nginx'],
		mode => 0755,
	}

	file {"/etc/nginx/ssl/server.key":
               source => "puppet:///modules/nginx/$server/server.key",
               require => File['/etc/nginx/ssl'],
       }

       file {"/etc/nginx/ssl/server.crt":
                source => "puppet:///modules/nginx/$server/server.crt",
               require => File['/etc/nginx/ssl'],
        }

	file {"/usr/sbin/nginxdissite":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/nginx/nginxdissite",
        }

	file {"/usr/sbin/nginxensite":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/nginx/nginxensite",
        }
}
