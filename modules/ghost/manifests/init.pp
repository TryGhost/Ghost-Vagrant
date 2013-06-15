
class ghost($node_version = "v0.10.5", $secure_site = 'false', $user_file_path = '', $user_name = 'ghost', $user_pass = 'ghost') {
    # Some common paths
    $ghost_path = "/home/${os_user_name}/code/Ghost"
    $node_path = "/home/${os_user_name}/nvm/${node_version}"
    $node_bin_path = "${node_path}/bin"
    $node_exec_path = "${node_bin_path}/node"
    
    # Add some default path values
    Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin', $node_bin_path], }

    # Base packages and ruby gems (sass, compass)
    class { essentials: }

    class { 'nginx':
        secure_site => $secure_site,
        user_file_path => $user_file_path,
        user_name => $user_name,
        user_pass => $user_pass,
        require => [Class["essentials"]]
    }

    # Install node through NVM
    class { 'nvm':
        node_version => $node_version,
        require => [Class["essentials"]]
    }

    # This function depends on some commands in the nvm.pp file
    define npm( $directory="/home/${os_user_name}/nvm/${ghost::node_version}/lib/node_modules" ) {
      exec { "install-${name}-npm-package":
        unless => "test -d ${directory}/${name}",
        command => "npm install -g ${name}",
        require => Exec['install-node'],
      }
    }

    # Global npm modules
    npm { ["grunt-cli",
           "sass",
           "mocha",
           "forever" ]:
    }

    # Make sure our code directory has proper permissions
    file { "code_directory":
        path => "/home/${os_user_name}/code",
        ensure => "directory",
        owner  => "${os_user_name}",
        group  => "${os_user_name}"
    }

    # Start the app as a service (assumes this is on ec2)
    # NOTE: This is not working because the npm install is barfing,
    #       but I'll keep it in case someone else wants to troubleshoot it.
    if $upstart_site == 'true' {
        class { 'upstart':
            ghost_path => $ghost_path,
            node_path => $node_path,
            require => [Exec['npm-install-packages'], Class['nginx'], Exec['install-forever-npm-package']]
        }
    }
}
