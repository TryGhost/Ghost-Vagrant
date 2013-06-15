# -*- mode: ruby -*-
# vi: set ft=ruby :

GhostSourcePath = "../Ghost"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"
  # Overridden in the virtualbox provider below
  config.vm.box_url = ""

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb, override|
    # Don't boot with headless mode
    # vb.gui = true
 
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    # To add cores
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Via http://blog.liip.ch/archive/2012/07/25/vagrant-and-node-js-quick-tip.html
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

    # NOTE: This should match your path to the Ghost source
    override.vm.synced_folder GhostSourcePath, "/home/vagrant/code/Ghost"

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # override.vm.network :forwarded_port, guest: 80, host: 8080

    # The url from where the 'override.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    override.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # TODO: Add a host entry to your hosts file; e.g. 192.168.33.10 local.tryghost.org
    override.vm.network :private_network, ip: "192.168.33.10"

    # Update packages to latest
    override.vm.provision :shell,
      :inline => "apt-get update -y"

    # Enable provisioning with Puppet stand alone.  Puppet manifests
    # are contained in a directory path relative to this Vagrantfile.
    # You will need to create the manifests directory and a manifest in
    # the file base.pp in the manifests_path directory.
    override.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "base.pp"
      puppet.module_path = "modules"

      puppet.facter = {
        "os_user_name" => 'vagrant'
      }
    end
  end
  
  # When using the AWS (ec2) provider
  config.vm.provider :aws do |aws, override|
    # NOTE: This should match your path to the Ghost source
    override.vm.synced_folder GhostSourcePath, "/home/ubuntu/code/Ghost"

    # Don't check these in
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']

    # This should match with your private key path below
    aws.keypair_name = "ghostdeploy"

    # Either you should enable ssh and http traffic in your default, 
    # or create a new security group and change it here
    aws.security_groups = ['default']

    # More info: http://cloud-images.ubuntu.com/releases/12.04.2/release/
    # Ubuntu Server Precise Pangolin 64bit 12.04.02 LTS
    # t1-micro instance
    aws.ami = "ami-e7582d8e"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = File.expand_path("~/.ssh/ghostdeploy.pem")

    # Install puppet before provisioning
    override.vm.provision :shell, :path => "shell/install_puppet.sh"
    
    # Secure the test site
    override.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "base.pp"
      puppet.module_path = "modules"

      puppet.facter = {
        "os_user_name" => 'ubuntu',
        "upstart_site" => 'true', # Not working right now, must log in and start the site
        "secure_site" => 'true',
        "user_file_path" => '/home/ubuntu/.htpasswd',
        'user_name' => 'ghost',
        'user_pass' => ENV['GHOST_PASSWORD']
      }
    end

    # Show the public hostname
    override.vm.provision :shell, :path => "shell/print_public_hostname.sh"
  end
end