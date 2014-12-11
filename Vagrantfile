# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.boot_timeout = 120
  config.vm.box = "centos"  
  config.vm.box_url = "https://googledrive.com/host/0B2JacpSnObRwaExDNUVOYUcyYWM/centos6.5.box"

  config.vm.define :weko do |weko|
    weko.vm.hostname = "weko"
    weko.vm.network :private_network, ip: "192.168.111.10"
  end
end
