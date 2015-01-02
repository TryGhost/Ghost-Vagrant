#Ghost-Vagrant

Vagrant setup for developing Ghost

## Changelog

#### 2.0

- use Ubuntu 14.04 (LTS) image

#### 1.2

- changed the Ghost shared folder path to `/home/vagrant/code/Ghost`

#### 1.1

- changed compass to bourbon as an automatic gem install
- NOTE: be sure to install the Guest Additions bit

## Instructions

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/downloads.html)
- *Linux Users:* Install an NFS daemon, e.g. `apt-get install nfs-kernel-server` 
- Clone this repo
- Initialise and fetch submodules
    - `git submodule init`
    - `git submodule update --recursive`
- Edit the `Vagrantfile` in the root
    - Change your `GhostSourcePath` to match your environment
- Edit your machines `hosts` file add `192.168.33.10 local.tryghost.org`
- Run `vagrant up` from the root of the cloned repo.
- This will automatically start ghost at `local.tryghost.org`
- To validate code, navigate to the Ghost code (`cd code/Ghost`) and run `grunt validate`.

## Post-Installation Configuration

- To connect to the Ghost-Vagrant virtual machine run `vagrant ssh` from the root of the cloned repo.

- Ghost-Vagrant comes with an Upstart job to automatically start Ghost.  It can be stopped and started by running the commands `sudo stop app` and `sudo start app` respectively.  If you would prefer Ghost not be automatically started you can accomplish this by running the command `echo manual | sudo tee --append /etc/init/app.conf`

## Copyright & License

Copyright (c) 2013-2015 Ghost Foundation - Released under the [MIT license](LICENSE).
