class mysql {
  class { '::mysql::server':
    root_password => 'secret'
  }

  include '::mysql::server'

  mysql_database { 'ghost_prod':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_general_ci',
  }

  mysql_database { 'ghost_dev':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_general_ci',
  }

  mysql_database { 'ghost_test':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_general_ci',
  }

  mysql_user { 'ghost@localhost':
    ensure                   => 'present',
    password_hash            => mysql_password('secret'),
    max_connections_per_hour => '0',
    max_queries_per_hour     => '0',
    max_updates_per_hour     => '0',
    max_user_connections     => '0',
  }

  mysql_grant { 'ghost@localhost/ghost\_%.*':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => 'ghost@localhost'
  }
}
