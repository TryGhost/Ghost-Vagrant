class nginx($secure_site = 'false', $user_file_path = "/home/ubuntu/.htpasswd", $user_name = 'ghost', $user_pass = 'ghost') {

  # Not sure if this is necessary in here
  Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin', "/home/${os_user_name}/nvm/${ghost::node_version}/bin"], }

  package { "nginx":
    ensure => installed,
    before => [File['nginx-htpasswd']]
  }
  
  service { 'nginx' :
    ensure => running,
    enable => true,
    hasrestart => true,
    subscribe => [File['nginx-htpasswd'], File['nginx-conf']],
  }

  file { 'nginx-htpasswd':
    path => "/home/${os_user_name}/scripts/htpasswd.py",
    source => "puppet:///modules/ghost/script/htpasswd.py",
    owner => "${os_user_name}",
    group => "${os_user_name}",
    mode => 755,
    before => [File['nginx-conf']]
  }

  if $secure_site == 'true' {
    file { 'nginx-userfile': 
      path => "${nginx::user_file_path}",
      ensure => "present",
      owner => "${os_user_name}",
      group => "${os_user_name}",
      before => [Exec['set-site-credentials']]
    }

    exec { 'set-site-credentials':
      command => "/home/${os_user_name}/scripts/htpasswd.py -b ${nginx::user_file_path} ${nginx::user_name} ${nginx::user_pass}",
    }
  }

  file { 'nginx-conf':
    path => "/etc/nginx/sites-enabled/default",
    content => template('ghost/nginx.conf.erb')
  }
}