# Taken from https://github.com/mozilla/openbadges/blob/development/.puppet-manifests/nvm.pp

class nvm ($node_version) {

  Exec {
    path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }

  exec { "set-node-version": 
    command => "bash -c \"source /home/${os_user_name}/nvm/nvm.sh && nvm alias default ${node_version}\"",
    require => Exec["install-node"],
    unless => "bash -c \"source /home/${os_user_name}/nvm/nvm.sh && nvm ls | grep -qc \"default -> ${node_version}\"",
  }

  exec { "install-node": 
    command => "bash -c \"source /home/${os_user_name}/nvm/nvm.sh && nvm install ${node_version}\"",
    require => Exec["clone-nvm"],
    creates => "/home/${os_user_name}/nvm/${node_version}",
    timeout => 0,
  }

  exec { "clone-nvm":
    command => "git clone git://github.com/creationix/nvm.git /home/${os_user_name}/nvm",
    user => "${os_user_name}",
    group => "${os_user_name}",
    creates => "/home/${os_user_name}/nvm/nvm.sh",
    require => Package["git-core"],
  }

  exec { "source-nvm":
    command => "echo 'source /home/${os_user_name}/nvm/nvm.sh' >> /home/${os_user_name}/.bashrc",
    onlyif => "grep -q 'source /home/${os_user_name}/nvm/nvm.sh' /home/${os_user_name}/.bashrc; test $? -eq 1",
  }
}