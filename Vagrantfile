# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#  config.vm.provider "virtualbox" do |vb|
#    vb.gui = true
#  end

  # Key
  config.ssh.private_key_path = "/var/root/.vagrant.d/insecure_private_key"
  
  config.vm.boot_timeout = 120

  config.vm.box = "centos"  
#  config.vm.box = "ubuntu"
#  config.vm.box_url = "https://googledrive.com/host/0B2JacpSnObRwWE1qR3A4TEpXdVU"
#  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 80, host: 80
#  config.vm.network "forwarded_port", guest: 8080, host: 8080
#  config.vm.network "forwarded_port", guest:443, host: 8443
end
