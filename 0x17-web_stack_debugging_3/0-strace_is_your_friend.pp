# Puppet manifest to fix Apache 500 error
file { '/var/www/html/my_directory':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => File['/var/www/html/my_directory'],
}
