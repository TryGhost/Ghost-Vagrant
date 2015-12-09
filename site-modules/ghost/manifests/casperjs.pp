#  Install and symlink casperjs and phantomjs

class casperjs {
    archive { "phantomjs":
        source => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2",
        path => "/tmp/phantomjs-1.9.8-linux-x86_64.tar.bz2",
        extract => true,
        extract_path => "/home/vagrant/software",
        checksum => "d29487b2701bcbe3c0a52bc176247ceda4d09d2d",
        checksum_type => "sha1",
        creates => "/home/vagrant/software/phantomjs-1.9.8-linux-x86_64"
    }

    exec { "link-phantomjs":
        command => "/bin/ln -sf /home/vagrant/software/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs",
        creates => "/usr/local/bin/phantomjs",
        require => [Archive["phantomjs"]]
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
