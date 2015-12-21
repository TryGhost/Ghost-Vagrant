# Ghost-Vagrant

Vagrant setup for developing [Ghost](https://ghost.org)

## Instructions

- Install the latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/downloads.html).
	- Linux users will also need to run `sudo apt-get install nfs-common nfs-kernel-sever`.
- Clone this repo with `git clone git://github.com/TryGhost/Ghost-Vagrant.git`.
- `cd` into the cloned repo.
- Clone the Ghost master repo with `git clone git://github.com/Tryghost/Ghost.git` (_case matters!_)
- Enter `vagrant up` to create your new Vagrant box and `vagrant ssh` to log in.
- After logging into your box enter `cd code/Ghost` and install Ghost by running `npm install` and `grunt init`.
- Enter `npm start`

On the host you should now be able to access Ghost by navigating to `local.tryghost.org` or `192.168.33.10`. Make sure to update the development URL to `http://local.tryghost.org` in `Ghost/config.js`.

## Stopping and Starting Ghost

- _After_ running `npm install`, `grunt init`, and `npm start`, you can stop and start Ghost by running `sudo stop app` and `sudo start app` _inside_ your box.

## Configuring the VM

You can configure various properties of the VM by creating a file named `vm_config.yml` in the root directory. The following properties are configurable:

- **hostname** - URI that will be used to access Ghost from the browser
- **ip** - IP address assigned to the virtual machine
- **memory** - Amount of memory the virtual machine should have
- **ghost_path** - Path to Ghost installation

```yml
hostname: local.tryghost.org
ip: 192.168.33.10
memory: 1024
ghost_path: ./Ghost
```

If you do not have a `vm_config.yml` file when you first run `vagrant up`, one will be automatically created with the default values.

## Developing and Running Tests

- See the [working on ghost core](https://github.com/TryGhost/Ghost/blob/master/CONTRIBUTING.md#core) section of the Ghost [contributing guide](https://github.com/TryGhost/Ghost/blob/master/CONTRIBUTING.md).

## Changelog

#### 3.0
- Vagrantfile: Removed comments, removed symlink hack, changed Ghost source path, changed default box name (now attempts to pull from Atlas before using box URL as a fallback.)
- Updated phantomjs version to 1.9.8
- Added a one-liner for updating `/etc/hosts`.
- Updated Puppet submodule commit references.
- Changed Upstart default behavior to manual.
- Removed `npm install` and `grunt init` from the provisioning process for better installation debugging.
- Made significant changes to README.md content, formatting, and structure.
- Made a few small changes to comments in module code (correcting links etc.)

#### 2.0

- Switched to Ubuntu 14.04 LTS image

#### 1.2

- Changed the Ghost shared folder path to `/home/vagrant/code/Ghost`

#### 1.1

- Changed Compass to Bourbon as an automatic gem install

## Copyright & License

Copyright (c) 2013-2015 Ghost Foundation - Released under the [MIT license](LICENSE).
