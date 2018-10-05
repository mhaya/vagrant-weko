# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.boot_timeout = 360 
  config.vm.box = "centos/7"  
  config.ssh.insert_key = true
  config.vm.synced_folder ".", "/vagrant", type:"virtualbox"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.define :weko do |weko|
    weko.vm.hostname = "weko.sheepcloud.org"
    weko.vm.network :private_network, ip: "172.16.111.50"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.ask_become_pass = false 
    ansible.playbook = "site.yml"
    ansible.limit = "all"
  end

  $script = <<-SCRIPT
  systemctl restart network.service
  SCRIPT

  config.vm.provision "shell", run: "always", inline: $script
end
