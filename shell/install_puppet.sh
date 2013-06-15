wget –-quiet --output-file /var/log/wget.log http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg --install puppetlabs-release-precise.deb
apt-get --quiet update
apt-get --quiet --assume-yes install puppet-common rubygems
