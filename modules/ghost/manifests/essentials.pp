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
    "build-essential"
    ]:
  }

  # Ruby modules for general development
  package {
    ["sass", "compass"]:
      provider => "gem"
  }

  #file { "/usr/local":
  #  recurse => true,
  #  group => "vagrant",
  #  owner => "vagrant";
  #}
}