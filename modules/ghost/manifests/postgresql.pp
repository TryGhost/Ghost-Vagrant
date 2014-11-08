class postgresql {
    class { 'postgresql::server':
        encoding => 'UTF8',
    }

    postgresql::server::role { 'vagrant':
        password_hash => postgresql_password('vagrant', 'secret'),
        superuser => true
    }

    postgresql::server::db { 'ghost_prod':
        user     => 'vagrant',
        password => 'secret',
    }

    postgresql::server::db { 'ghost_dev':
        user     => 'vagrant',
        password => 'secret',
    }

    postgresql::server::db { 'ghost_test':
        user     => 'vagrant',
        password => 'secret',
    }
}
