# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos"  
#  config.vm.box = "ubuntu"
#  config.vm.box_url = "https://googledrive.com/host/0B2JacpSnObRwWE1qR3A4TEpXdVU"
#  config.vm.network "forwarded_port", guest: 80, host: 8080
#  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest:443, host: 8443
end
