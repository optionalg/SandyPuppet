class base_system() {
	package { 'openjdk-7-jre':
		ensure => present,
	}
	package { 'git':
                ensure => present,
        }
	file { '/data':
		ensure => directory,
        }
	package { 'curl':
                ensure => present,
        }

}
