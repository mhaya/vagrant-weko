# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.boot_timeout = 360 
  config.vm.box = "centos/7"  
  config.ssh.insert_key = true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :weko do |weko|
    weko.vm.hostname = "weko.sheepcloud.org"
    weko.vm.network :private_network, ip: "172.16.111.40"
  end

  #
  # Run Ansible from the Vagrant Host
  #
  config.vm.provision "ansible" do |ansible|
    # ansible.verbose = "vvv"
    ansible.ask_become_pass = false 
    ansible.playbook = "site.yml"
    ansible.limit = "all"
  end

  config.vm.provision "shell", run: "always", inline: "systemctl restart network.service"

#  config.vm.provider "virtualbox" do |vb|
#  	# Use VBoxManage to customize the VM. For example to change memory:
#    	vb.customize ["modifyvm", :id, "--memory", "2048"]
#  end
end
