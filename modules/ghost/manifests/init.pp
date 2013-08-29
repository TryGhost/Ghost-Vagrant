
class ghost($node_version = "v0.10.5") {
    # Add some default path values
    Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin', "/home/vagrant/nvm/${node_version}/bin"], }

    # Base packages and ruby gems (sass, compass)
    class { essentials: }

    # Install and setup nginx web server
    class { nginx:
        require => [Class["essentials"]]
    }

    # Install and setup phantomjs and casperjs
    class { casperjs:
        require => [Class["essentials"]]
    }

    # Install node through NVM
    class { 'nvm':
        node_version => $node_version,
        require => [Class["essentials"]]
    }

    # This function depends on some commands in the nvm.pp file
    define npm( $directory="/home/vagrant/nvm/${ghost::node_version}/lib/node_modules" ) {
      exec { "install-${name}-npm-package":
        unless => "test -d ${directory}/${name}",
        command => "npm install -g ${name}",
        require => Exec['install-node'],
      }
    }

    # Global npm modules
    npm { ["grunt-cli",
           "sass",
           "mocha" ]:
    }

    # Make sure our code directory has proper permissions
    file { '/home/vagrant/code':
        ensure => "directory",
        owner  => "vagrant",
        group  => "vagrant"
    }

    # Examples of installing packages from a package.json if we need to.
    #exec { "npm-install-packages":
    #  cwd => "/home/vagrant/",
    #  command => "npm install .",
    #  require => Exec['install-node'],
    #}
}
