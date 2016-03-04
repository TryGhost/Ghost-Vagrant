# Ghost-Vagrant

A development environment for [Ghost](https://ghost.org) using [Vagrant](http://www.vagrantup.com/downloads.html).

## Prerequisites

You will need the following applications to setup the Ghost development environment:

- [Vagrant](http://www.vagrantup.com/downloads.html)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Git](https://git-scm.com/downloads)

Linux users will also need `nfs-common` and `nfs-kernel-server`

```bash
sudo apt-get install nfs-common nfs-kernel-sever
```

## Setup

To get started with the Ghost development environment, you will first need to clone this repo and navigate into it:

```bash
git clone git://github.com/TryGhost/Ghost-Vagrant.git
cd Ghost-Vagrant
```

You will now need a copy of Ghost itself:

```bash
git clone git://github.com/Tryghost/Ghost.git
```

Now we have both repos cloned, we can proceed with setting up the VM:

```bash
vagrant up
```

Once the VM has been setup, you will need to log in to the VM and setup Ghost:

```bash
vagrant ssh

# When logged into the VM...

cd code/Ghost
npm install
grunt init
```

On the host you should now be able to access Ghost by navigating to `local.tryghost.org` or `192.168.33.10` in your browser. Make sure to update the development URL to `http://local.tryghost.org` in `Ghost/config.js`.

## Stopping and Starting Ghost

Once you have been through the setup process above, you can stop Ghost by logging in to the VM (`vagrant ssh`) and running:

```bash
sudo stop app
```

To start Ghost again run:

```bash
sudo start app
```

If you do not want to use the service for starting and stopping Ghost, you can alternatively run:

```bash
npm start
```

This is useful when you want to debug what Ghost is doing when it boots up, what URLs are being accessed etc.

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

If `vm_config.yml` is not present when you first run `vagrant up`, it will be automatically created with the default values found in [.vm_config_default.yml](.vm_config_default.yml).

## Developing and Running Tests

See the [working on Ghost core](https://github.com/TryGhost/Ghost/blob/master/CONTRIBUTING.md#core) section of the Ghost [contributing guide](https://github.com/TryGhost/Ghost/blob/master/CONTRIBUTING.md).

## Copyright & License

Copyright (c) 2013-2016 Ghost Foundation - Released under the [MIT license](LICENSE).
