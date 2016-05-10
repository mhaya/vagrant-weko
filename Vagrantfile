# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.boot_timeout = 360 
  config.vm.box = "centos7"  
  config.vm.box_url = "https://googledrive.com/host/0B2JacpSnObRwaExDNUVOYUcyYWM/centos7.box"
  config.ssh.insert_key = true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :weko do |weko|
    weko.vm.hostname = "weko"
    weko.vm.network :private_network, ip: "192.168.111.10"
  end

  #
  # Run Ansible from the Vagrant Host
  #
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "vvv"
    ansible.ask_sudo_pass = false 
    ansible.playbook = "site.yml"
    ansible.limit = "all"  
  end

#  config.vm.provider "virtualbox" do |vb|
#  	# Use VBoxManage to customize the VM. For example to change memory:
#    	vb.customize ["modifyvm", :id, "--memory", "2048"]
#  end
end
