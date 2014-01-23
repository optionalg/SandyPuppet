class base_system() {
	package { 'openjdk-7-jre':
		ensure => present,
	}
	package { 'git-core':
                ensure => present,
        }
	file { '/data':
		ensure => directory,
        }
}
