#Ghost-Vagrant

Vagrant setup for developing Ghost

## Changelog

#### 1.3

- allow option to secure site with basic auth through nginx
- ec2 provisioning

#### 1.2

- changed the Ghost shared folder path to `/home/vagrant/code/Ghost`
- added some info to the MOTD

#### 1.1

- changed compass to bourbon as an automatic gem install
- NOTE: be sure to install the Guest Additions bit

## Instructions for Ghost Development

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

## Updating Virtual Box Guest Additions

The packaged vagrant box from Ubuntu contains outdated Virtual Box Guest Additions.  Most of the time this shouldn't be a problem, but if you want to update them I recommend this procedure:

1. Install the [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest): `vagrant plugin install vagrant-vbguest`
1. Boot the vm without provisioning: `vagrant up --no-provision`
1. Login with `vagrant ssh` and run `sudo apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11`
1. Logout and `vagrant halt`
1. `vagrant up`

## Instructions for Deploying to EC2

**NOTE**: Because of a limitation of the current version of Vagrant, you must check out the repo into a different directory than your development vm when deploying.

- Setup an Amazon AWS EC2 account and save the access key and secret key.
- [Create a deployment key pair](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-keypair.html)
- Make sure the Amazon deploy key pair is in `~/.ssh/ghostdeploy.pem`
- Install the [vagrant-aws](https://github.com/mitchellh/vagrant-aws) plugin: 
	- `vagrant plugin install vagrant-aws`
- Set some deployment environment variables:
	- `export AWS_ACCESS_KEY=<access_key>` (use `set` if on Windows)
	- `export AWS_SECRET_KEY=<secret_key>`
	- `export GHOST_PASSWORD=<password>`
- Kick off the deploy:
	- `vagrant up --provider=aws`
- Log in and start the site, but first have to re-install modules built for ec2 instance
	- `vagrant ssh`
	- `cd code/Ghost && rm -rf node_modules && npm install`
	- `sudo start ghost`
- Navigate to the public hostname of the ec2 instance to view the site
	- `ec2metadata --public-hostname`

## Copyright & License

Copyright (C) 2013 The Ghost Foundation - Released under the MIT Lincense.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.