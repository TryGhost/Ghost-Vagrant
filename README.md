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

Copyright (C) 2014 The Ghost Foundation - Released under the MIT Lincense.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
