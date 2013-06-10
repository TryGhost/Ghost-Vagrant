Ghost-Vagrant
=============

Vagrant setup for developing Ghost

### Changelog

#### 1.2

- changed the Ghost shared folder path to `/home/vagrant/code/Ghost`

#### 1.1

- changed compass to bourbon as an automatic gem install
- NOTE: be sure to install the Guest Additions bit

### Instructions

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant 1.2.2](http://downloads.vagrantup.com/tags/v1.2.2)
- Clone this repo
- Edit the `Vagrantfile` in the root
    - Change your `GhostSourcePath` to match your environment
- Edit your machines `hosts` file add `192.168.33.10 local.tryghost.org`
- Run `vagrant up` from the root of the cloned repo.
- Login to the VM with `vagrant ssh`
- Change to the Ghost source directory: `cd code/Ghost`
- Install git submodules: `git submodule update --recurse`
- Install dependencies: `npm install`
- Build Admin styles: `grunt init`
- Run the Ghost App: `node app.js`
- Validate code: `grunt validate`

### Updating Virtual Box Guest Additions

The packaged vagrant box from Ubuntu contains outdated Virtual Box Guest Additions.  Most of the time this shouldn't be a problem, but if you want to update them I recommend this procedure:

1. Install the [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest): `vagrant plugin install vagrant-vbguest`
1. Boot the vm without provisioning: `vagrant up --no-provision`
1. Login with `vagrant ssh` and run `sudo apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11`
1. Logout and `vagrant halt`
1. `vagrant up`

### License

Copyright 2013 Ghost
