class nginx {
  package { "nginx":
    ensure => installed,
    before => File['nginx-conf'];
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    subscribe => File['nginx-conf'],
    require => File['ssl-cert', 'ssl-cert-key', 'nginx-conf'],
  }

  file { '/etc/nginx/ssl/':
    ensure => "directory",
  }

  file { 'ssl-cert':
    path => "/etc/nginx/ssl/server.crt",
    source => "puppet:///modules/ghost/config/server.crt",
    owner  => "root",
    group  => "root",
    require => File["/etc/nginx/ssl/"],
  }

  file { 'ssl-cert-key':
    path => "/etc/nginx/ssl/server.key",
    source => "puppet:///modules/ghost/config/server.key",
    owner  => "root",
    group  => "root",
    require => File["/etc/nginx/ssl/"],
  }

  file { 'nginx-conf':
    path => "/etc/nginx/sites-enabled/default",
    source => "puppet:///modules/ghost/config/nginx.conf",
  }
}