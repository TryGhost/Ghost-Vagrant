# Take from openbadges setup.

class essentials {
  group { "puppet" :
    ensure => present,
    name => "puppet";
  }

  Package { ensure => installed }

  package {
    ["curl",
    "libssl-dev",
    "git-core",
    "python",
    "build-essential",
    "libpq-dev"
    ]:
  }

  file { "/home/vagrant/software":
    ensure => "directory",
  }

  #file { "/usr/local":
  #  recurse => true,
  #  group => "vagrant",
  #  owner => "vagrant";
  #}
}