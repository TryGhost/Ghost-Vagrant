#  Install casperjs stuff

class casperjs {

    file { "phantomjs-src":
      path => "/home/vagrant/software/phantomjs-1.9.1-linux-x86_64.tar.bz2",
      source => "puppet:///modules/ghost/software/phantomjs-1.9.1-linux-x86_64.tar.bz2",
    }

    exec { "extract-phantomjs":
        cwd => "/home/vagrant/software",
        command => "/bin/tar xvjf phantomjs-1.9.1-linux-x86_64.tar.bz2",
        creates => "/home/vagrant/software/phantomjs-1.9.1-linux-x86_64",
        require => [File["phantomjs-src"]]
    }



    exec { "link-phantomjs":
        cwd => "/home/vagrant/software/phantomjs-1.9.1-linux-x86_64",
        command => "/bin/ln -sf /home/vagrant/software/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs",
        creates => "/usr/local/bin/phantomjs",
        require => [Exec["extract-phantomjs"]]
    }

    exec { "git-casperjs":
        cwd => "/home/vagrant/software",
        command => "/usr/bin/git clone git://github.com/n1k0/casperjs.git",
        creates => "/home/vagrant/software/casperjs"
    }

    exec { "link-casperjs":
        cwd => "/home/vagrant/software/casperjs",
        command => "/bin/ln -sf /home/vagrant/software/casperjs/bin/casperjs /usr/local/bin/casperjs",
        creates => "/usr/local/bin/casperjs",
        require => [Exec["git-casperjs"]]
    }
}