# Increases the amount of traffic an Nginx server can handle.

# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/local/bin/', '/bin/'],
  onlyif  => 'test "$(grep "^ulimit" /etc/default/nginx)" != "ulimit -n 4096"',
} ->

# Restart Nginx
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => Exec['fix--for-nginx'],
}
