# 1-user_limit.pp

# Increase the open file limit for the holberton user
user { 'holberton':
  hard => 'nofile',
  soft => 'nofile',
  value => '4096',
}

# End of Puppet manifest
