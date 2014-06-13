define apache_vh($templateName="sample") {

	file { "/etc/apache2/sites-available/${templateName}":
		content => template("apache_vh/${templateName}"),
		mode    => '644',
	}
}

