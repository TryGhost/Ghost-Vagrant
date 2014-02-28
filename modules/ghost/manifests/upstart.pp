class upstart ($node_version) {

    file { "app-conf":
        ensure  => file,
        path => "/etc/init/app.conf",
        content => template("ghost/config/app.conf")
    }

    service { 'app':
        ensure => running,
        provider => 'upstart',
        require => File['app-conf'],
    }

}
