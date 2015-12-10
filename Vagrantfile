# -*- mode: ruby -*-
# vi: set ft=ruby :
require "yaml"

# Load in external config
config_file = "#{File.dirname(__FILE__)}/vm_config.yml"
default_config_file = "#{File.dirname(__FILE__)}/.vm_config_default.yml"

if !File.file? config_file
  puts "Creating vm_config.yml..."
  FileUtils.cp default_config_file, config_file
end

vm_external_config = YAML.load_file(config_file)

# Install required Vagrant plugins
missing_plugins_installed = false
required_plugins = %w(vagrant-cachier vagrant-hostsupdater vagrant-librarian-puppet)

required_plugins.each do |plugin|
  if !Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    missing_plugins_installed = true
  end
end

# If any plugins were missing and have been installed, re-run vagrant
if missing_plugins_installed
  exec "vagrant #{ARGV.join(" ")}"
end

# Configure Vagrant
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network :private_network, ip: vm_external_config["ip"]
  config.vm.hostname = vm_external_config["hostname"]

  config.vm.synced_folder vm_external_config["ghost_path"], "/home/vagrant/code/Ghost", :nfs => true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", vm_external_config["memory"]]
  end

  config.cache.scope = :box

  config.librarian_puppet.placeholder_filename = ".gitkeep"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "base.pp"
    puppet.module_path = "modules"
  end
end
