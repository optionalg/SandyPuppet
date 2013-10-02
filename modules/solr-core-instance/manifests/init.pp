define solr-core-instance( $instance_name, $core_name, $master, $slave, $port) {
	file { "/etc/solr/${instance_name}/${core_name}/conf":
		owner => solr,
		group => solr,
		ensure => link,
		target => "/etc/solr/${instance_name}/conf",
	}
	
	file { "/etc/solr/${instance_name}/${core_name}/conf/solrcore.properties":
                owner => solr,
                group => solr,
                ensure => present,
                content => template("solr-core-instance/solrcore.properties"),
                recurse => true,
        }

	file { [ "/etc/solr/${instance_name}/${core_name}", "/etc/solr/${instance_name}/${core_name}/data" ]:
                owner => solr,
                group => solr,
                ensure => directory,
		before => File["/etc/solr/${instance_name}/${core_name}/conf"],
        }
}
