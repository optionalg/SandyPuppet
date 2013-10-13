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
}
