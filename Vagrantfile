# -*- mode: ruby -*-
# vi: set ft=ruby :

module OS
  def OS.windows?
    Vagrant::Util::Platform.windows?
  end

  def OS.mac?
    (/darwin/ =~ Vagrant::Util::Platform.platform) != nil
  end

  def OS.unix?
    !Vagrant::Util::Platform.platform
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end


Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "private_network", ip: "192.168.1.10"
  #config.vm.hostname = "weko3.example.org"
  config.disksize.size = "100GB"


  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  if Vagrant.has_plugin?("vagrant-vbguest")
    # set auto_update to false, if you do NOT want to check the correct
    config.vbguest.auto_update = true
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 443, host: 8443, host_ip: "127.0.0.1"
  

  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end

  if OS.windows?
    config.vm.provision :shell, privileged: false,:path => "script.sh"
  else
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.inventory_path = "hosts"
      ansible.limit = 'all'
      ansible.host_key_checking = false
    end
  end
end
