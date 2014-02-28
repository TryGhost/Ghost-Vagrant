# Taken from https://github.com/mozilla/openbadges/blob/development/.puppet-manifests/nvm.pp

class nvm ($node_version) {

  Exec {
    path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }

  exec { "set-node-version": 
    command => "bash -c \"source /home/vagrant/nvm/nvm.sh && nvm alias default ${node_version}\"",
    require => Exec["install-node"],
    unless => "bash -c \"source /home/vagrant/nvm/nvm.sh && nvm ls | grep -qc \"default -> ${node_version}\"",
  }

  exec { "install-node": 
    command => "bash -c \"source /home/vagrant/nvm/nvm.sh && nvm install ${node_version}\"",
    require => Exec["clone-nvm"],
    creates => "/home/vagrant/nvm/${node_version}",
    timeout => 0,
  }

  # Ensure proper permissions for nvm (and node in general)
  file { "set-node-permissions":
    path => "/home/vagrant/nvm/${node_version}", 
    ensure => "directory",
    recurse => true,
    owner  => "vagrant",
    group  => "vagrant",
    require => [Exec['install-node']]
  }

  exec { "clone-nvm":
    command => "git clone git://github.com/creationix/nvm.git /home/vagrant/nvm",
    user => "vagrant",
    group => "vagrant",
    creates => "/home/vagrant/nvm/nvm.sh",
    require => Package["git-core"],
  }

  exec { "source-nvm":
    command => "echo 'source /home/vagrant/nvm/nvm.sh' >> /home/vagrant/.bashrc",
    onlyif => "grep -q 'source /home/vagrant/nvm/nvm.sh' /home/vagrant/.bashrc; test $? -eq 1",
  }
}