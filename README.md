Ghost-Vagrant
=============

Vagrant setup for developing Ghost

### Instructions

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant 1.2.2](http://downloads.vagrantup.com/tags/v1.2.2)
- Clone this repo
- Edit the `Vagrantfile` in the root
    - Change your `GhostSourcePath` to match your environment
- Run `vagrant up` from the root of the cloned repo.
- Edit your `hosts` file, add an entry for `local.tryghost.org` pointing to `192.168.33.10`
- Login to the VM with `vagrant ssh`
- Run the Ghost App with `cd /Ghost-Web && node index.js`

### License

Copyright 2013 Ghost
