class nodejs() {

	sruser{nodejs: user => nodejs, }

	file { "/home/nodejs/nodeapps":
		owner => nodejs,
		group => nodejs,
		ensure => directory,
		require => Sruser['nodejs'],
	}
