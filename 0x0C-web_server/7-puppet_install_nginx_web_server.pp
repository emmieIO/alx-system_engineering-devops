# File: nginx_setup.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => template('nginx_setup/nginx.conf.erb'),
  notify  => Service['nginx'],
}

# Create the custom index.html file
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  require => Package['nginx'],
}

# Create the redirect configuration for /redirect_me
file { '/etc/nginx/sites-available/redirect_me':
  ensure  => 'file',
  content => template('nginx_setup/redirect_me.conf.erb'),
  notify  => Service['nginx'],
}

# Create a symbolic link to enable the redirect configuration
file { '/etc/nginx/sites-enabled/redirect_me':
  ensure => 'link',
  target => '/etc/nginx/sites-available/redirect_me',
  notify => Service['nginx'],
}

# Remove the default symlink to prevent conflicts
file { '/etc/nginx/sites-enabled/default':
  ensure => 'absent',
  notify => Service['nginx'],
}

# Notify Nginx service if any of the Nginx configuration files are changed
# This triggers a service reload to apply the changes
Class['nginx'] -> File['/etc/nginx/sites-available/default']
Class['nginx'] -> File['/etc/nginx/sites-available/redirect_me']