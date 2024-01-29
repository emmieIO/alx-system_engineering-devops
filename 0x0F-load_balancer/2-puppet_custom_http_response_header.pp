# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Get the current hostname
$hostname = $facts['hostname']

# Configure Nginx with custom header
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "add_header X-Served-By ${hostname};\n",
}

# Reload Nginx to apply changes
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}
