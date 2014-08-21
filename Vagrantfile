# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # I don't feel like making and hosting a box, so we'll use chef's
  config.vm.box = "chef/centos-6.5"

  # Configures the location of your shared folder.
  config.vm.synced_folder "./data", "/data", create: true

  # Change this configuration to match what resources you want to devote to the box
  config.vm.provider "virtualbox" do |v|
    # v.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
    v.memory = 2048
    v.cpus = 2
    # v.gui = true
  end

  # Handles installation of packages for a working developer instance
  config.vm.provision "shell", path: "post_install.sh"

  # Transfers SSH keys for github access or CLI commits
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"

  # Transfers global Git configuration
  config.vm.provision "file", source: "~/.composer/auth.json", destination: "~/.composer/auth.json"
  config.vm.provision "file", source: "~/.gitconfig", destination: "~/.gitconfig"
  config.vm.provision "file", source: "base.conf", destination: "~/base.conf"
  config.vm.provision "shell", inline: "sudo mv ~/base.conf /etc/httpd/conf.d/base.conf", privileged: false

  # Installs Base 3.0 developer instances
  config.vm.provision "shell", path: "base_install.sh", privileged: false

end
