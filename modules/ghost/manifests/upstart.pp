
class upstart($ghost_path, $node_path) {

	file { '/etc/init/ghost.conf':
		ensure => file,
		content => template('ghost/ghost.conf.erb')
	}

	file { '/var/log/ghost.log':
		ensure => file,
		owner => $os_user_name,
		group => $os_user_name
	}

	exec { "start ghost":
		command => '/sbin/start ghost',
		subscribe => [File['/etc/init/ghost.conf']],
		onlyif => "/sbin/status ghost | /bin/grep -q -c start/running"
	}
}