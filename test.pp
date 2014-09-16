class { 'apache':  }
apache::vhost { 'first.example.com':
  port    => '80',
  docroot => '/var/www/first',
}
apache::vhost { 'second.example.com':
  port          => '80',
  docroot       => '/var/www/second',
  docroot_owner => 'third',
  docroot_group => 'third',
}
