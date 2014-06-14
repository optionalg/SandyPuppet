define nginx-site($siteConfFile="default") {

	file { "/etc/nginx/sites-available/$siteConfFile":
		source => "puppet:///modules/nginx-site/$siteConfFile",
	}
	
}
